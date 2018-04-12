//
//  PZ_TiaoBan_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZ_TiaoBan_ListViewController.h"
#import "TiaoBan_DetailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "PPersonCardViewController.h"
@interface PZ_TiaoBan_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_tiaoban;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSString *page_number;
}

@end

@implementation PZ_TiaoBan_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString  *code = self.isRenShi ==1?@"121":@"120";
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    
    if(self.isRenShi==1)
    {
        //人事审批
        [WebRequest Get_ChangeShift_ByHRWithtype:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] userGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_tiaoban removeAllObjects];
                NSDictionary *dic2 =dic[Y_ITEMS];
                page_number =dic2[@"page"];
                NSArray *tarr =dic2[@"list"];
                if (tarr.count) {
                    for (int i=0; i<tarr.count; i++) {
                        TiaoBan_ListModel *model =[TiaoBan_ListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_tiaoban addObject:model];
                    }
                      [tableV reloadData];
                }
                
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
          
        }];
        
    }
    else
    {
    
    [WebRequest Get_ChangeShift_ByCheckerWithtype:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] userGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [arr_tiaoban removeAllObjects];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            page_number =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    TiaoBan_ListModel *model =[TiaoBan_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_tiaoban addObject:model];
                }
                   [tableV reloadData];
            }
         
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
    
        
    }];
    }
    
}
-(void)loadOtherData
{
    if (self.isRenShi==1) {
        [WebRequest Get_ChangeShift_ByHRWithtype:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] userGuid:user.Guid page:page_number And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *dic2 =dic[Y_ITEMS];
                
                NSArray *tarr =dic2[@"list"];
                if(tarr.count==0)
                {
                    [tableV.mj_header endRefreshing];
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
               page_number =dic2[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        TiaoBan_ListModel *model =[TiaoBan_ListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_tiaoban addObject:model];
                    }
                    
                
                   
                    [tableV reloadData];
                }
                
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
        }];
        
    }
    
    else
    {
    
    [WebRequest Get_ChangeShift_ByCheckerWithtype:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] userGuid:user.Guid page:page_number And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            page_number =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                for (int i=0; i<tarr.count; i++) {
                    TiaoBan_ListModel *model =[TiaoBan_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_tiaoban addObject:model];
                }
               [tableV reloadData];
            }
            
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
       
    }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"调班审批列表";
    user =[WebRequest GetUserInfo];
    page_number=@"0";
    arr_tiaoban =[NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_tiaoban.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    TiaoBan_ListModel *model =arr_tiaoban[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TiaoBan_ListModel *model =arr_tiaoban[indexPath.row];
    TiaoBan_DetailViewController *Dvc =[[TiaoBan_DetailViewController alloc]init];
    Dvc.model =model;
    Dvc.isRenShi =self.isRenShi;
    Dvc.isshenpi=(segmentC.selectedSegmentIndex+1)%2;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
