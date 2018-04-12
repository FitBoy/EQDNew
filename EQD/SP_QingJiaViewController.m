//
//  SP_QingJiaViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SP_QingJiaViewController.h"
#import "QJ_DetailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
@interface SP_QingJiaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSString *page_laod;
    NSMutableArray *arr_sehnpi;
}

@end

@implementation SP_QingJiaViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"101" And:^(NSDictionary *dic) {
    }];
}
-(void)loadRequestData{
    [WebRequest Get_Leave_ByHRWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_sehnpi removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            if (dic2) {
                page_laod =dic2[@"page"];
                NSArray *tarr =dic2[@"list"];
                if(tarr.count)
                {
                    for (int i=0; i<tarr.count; i++) {
                        QingJiaListModel *model =[QingJiaListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_sehnpi addObject:model];
                    }
                }
            }
            
        }
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        [tableV reloadData];
       
        
    }];
    
}
-(void)loadOtherData
{
    [WebRequest Get_Leave_ByHRWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page_laod And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
        
                page_laod =dic2[@"page"];
                NSArray *tarr =dic2[@"list"];
            
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    for (int i=0; i<tarr.count; i++) {
                        QingJiaListModel *model =[QingJiaListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_sehnpi addObject:model];
                    }
                    [tableV reloadData];
                }
            
           
        }
       
        
        
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"人事审批";
    arr_sehnpi =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    page_laod =@"0";
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"待审核",@"已审核"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_sehnpi.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    QingJiaListModel *model =arr_sehnpi[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QingJiaListModel *model =arr_sehnpi[indexPath.row];
    QJ_DetailViewController *Dvc =[[QJ_DetailViewController alloc]init];
    Dvc.model=model;
    Dvc.isshenpi=segmentC.selectedSegmentIndex;
    Dvc.isRenShi =1;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
