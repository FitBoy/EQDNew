//
//  HeTong_list_LeaderViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "HeTong_list_LeaderViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "HeTong_DetailViewController.h"
@interface HeTong_list_LeaderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentC;
    NSMutableArray *arr_list;
    UserModel *user;
    NSString *page;
}

@end

@implementation HeTong_list_LeaderViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"162" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
        
    
    [WebRequest Contracts_Get_Contract_ByLeaderWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            
        [arr_list removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                HeTong_ListModel *model =[HeTong_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_list addObject:model];
            }
        }
              [tableV reloadData];
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
      
    }];
    
}
-(void)loadOtherData
{
   
    [WebRequest Contracts_Get_Contract_ByLeaderWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page And:^(NSDictionary *dic) {
        
        if ([dic[Y_STATUS] integerValue]==200) {
              NSDictionary *dic2 =dic[Y_ITEMS];
             NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
                [tableV.mj_header endRefreshing];
            }else
            {
                page =dic2[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        HeTong_ListModel *model =[HeTong_ListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_list addObject:model];
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
    self.navigationItem.title =@"合同列表";
    user =[WebRequest GetUserInfo];
    page =@"0";
    arr_list=[NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"新合同",@"已同意"]];
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
    return arr_list.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    HeTong_ListModel *model =arr_list[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeTong_ListModel *model =arr_list[indexPath.row];
    HeTong_DetailViewController *Dvc =[[HeTong_DetailViewController alloc]init];
    Dvc.model =model;
    Dvc.isQianDing=segmentC.selectedSegmentIndex==0?3:0;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
