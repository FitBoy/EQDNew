//
//  CarUse_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CarUse_ListViewController.h"
#import "Car_use_AddViewController.h"
#import "CarUseModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "CarUse_DetailViewController.h"
@interface CarUse_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
}

@end

@implementation CarUse_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if (self.isrenshi==2) {
        [WebRequest Com_Vehicle_Get_vehicleCListByLeaderWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeAllObjects];
                    page = dic[@"nextpage"];
                    NSArray *tarr = dic[Y_ITEMS];
                    for (int i=0; i<tarr.count; i++) {
                        CarUseModel  *model =[CarUseModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                [tableV reloadData];
            }
        }];
        
    }else if (self.isrenshi==1)
    {
        [WebRequest Com_Vehicle_Get_vehicleCListByVAdminWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeAllObjects];
                    page = dic[@"nextpage"];
                    
                    NSArray *tarr = dic[Y_ITEMS];
                    for (int i=0; i<tarr.count; i++) {
                        CarUseModel  *model =[CarUseModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                [tableV reloadData];
            }
        }];
    }else
    {
    [WebRequest Com_Vehicle_Get_VApplyList_applientWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
          [arr_model removeAllObjects];
        if([dic[Y_STATUS] integerValue]==200)
        {
            page = dic[@"nextpage"];
          
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                CarUseModel  *model =[CarUseModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
    }];
    }
}
-(void)loadOtherData
{
    if (self.isrenshi==2) {
        [WebRequest Com_Vehicle_Get_vehicleCListByLeaderWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
               
                
                    
                    NSArray *tarr = dic[Y_ITEMS];
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                      page = dic[@"nextpage"];
                    for (int i=0; i<tarr.count; i++) {
                        CarUseModel  *model =[CarUseModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                
               
                [tableV reloadData];
                }
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
        }];
    }else if (self.isrenshi==1)
    {
        [WebRequest Com_Vehicle_Get_vehicleCListByVAdminWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
               
                
                    
                    NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                 page = dic[@"nextpage"];
                    for (int i=0; i<tarr.count; i++) {
                        CarUseModel  *model =[CarUseModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                
               
                [tableV reloadData];
                }
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
        }];
    }else
    {
    [WebRequest Com_Vehicle_Get_VApplyList_applientWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
           
            
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                 page = dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                CarUseModel  *model =[CarUseModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
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
    user =[WebRequest GetUserInfo];
    page =@"0";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"用车列表";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批",@"待归还"]];
    if(self.isrenshi==2 || self.isrenshi==1)
    {
        [segmentC removeSegmentAtIndex:2 animated:NO];
    }
    segmentC.frame =CGRectMake(0, DEVICE_HEIGHT-40, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
}
-(void)tianjiaClick
{
    Car_use_AddViewController  *Avc =[[Car_use_AddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    CarUseModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarUseModel  *model =arr_model[indexPath.row];
    CarUse_DetailViewController *Dvc =[[CarUse_DetailViewController alloc]init];
    Dvc.apllyId =model.ID;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
