//
//  QingJiaPiZhun_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QingJiaPiZhun_ViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "QJ_DetailViewController.h"
@interface QingJiaPiZhun_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentC;
    NSMutableArray *arr_shenpi;
    UserModel *user;
    NSString *selected_page;
}

@end

@implementation QingJiaPiZhun_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"100" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    [WebRequest Get_Leave_ByLeaderWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_shenpi removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            selected_page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            if (tarr.count) {
                for ( int i=0; i<tarr.count; i++) {
                    QingJiaListModel *model =[QingJiaListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_shenpi addObject:model];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        });
    }];
}
-(void)loadOtherData
{
    [WebRequest Get_Leave_ByLeaderWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:selected_page And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            
            NSArray *tarr =dic2[@"list"];
            if(tarr.count==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                selected_page =dic2[@"page"];
                for ( int i=0; i<tarr.count; i++) {
                    QingJiaListModel *model =[QingJiaListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_shenpi addObject:model];
                }
             
                [tableV reloadData];
            }
        }
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(tableV, self);
    self.navigationItem.title=@"请假审批";
    user =[WebRequest GetUserInfo];
    arr_shenpi =[NSMutableArray arrayWithCapacity:0];
    selected_page =@"0";
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"待审核",@"已审批"]];
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
    return arr_shenpi.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    QingJiaListModel *model =arr_shenpi[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QingJiaListModel *model =arr_shenpi[indexPath.row];
    QJ_DetailViewController *Dvc =[[QJ_DetailViewController alloc]init];
    Dvc.model =model;
    Dvc.isshenpi =segmentC.selectedSegmentIndex;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
