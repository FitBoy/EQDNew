//
//  PX_PlanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/10.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PX_PlanViewController.h"
#import "PX_Plan_AddViewController.h"
#import "PX_PlanDetailViewController.h"
@interface PX_PlanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSString *page;
    NSMutableArray *arr_model;
}

@end

@implementation PX_PlanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
    [WebRequest Training_Get_trainingPlanListWithuserGuid:user.Guid comid:user.companyId type:@"0" page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            page =dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                PlanListModel  *model = [PlanListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData
{
    [WebRequest Training_Get_trainingPlanListWithuserGuid:user.Guid comid:user.companyId type:@"0" page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page =dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                PlanListModel  *model = [PlanListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page =@"0";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"培训计划列表";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    [self loadRequestData];
}
-(void)tianjiaClick
{
    //添加培训计划
    PX_Plan_AddViewController  *Avc = [[PX_Plan_AddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = Y_TextFont;
        cell.detailTextLabel.font = Y_TextFontSmall;
        cell.detailTextLabel.textColor = [UIColor greenColor];
    }
    PlanListModel *model =arr_model[indexPath.row];
    cell.textLabel.text = model.theTheme;
    cell.detailTextLabel.text = model.theCategory;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     PlanListModel *model =arr_model[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(getPlanListModel:)]) {
        [self.delegate getPlanListModel:model];
        [self.navigationController popViewControllerAnimated:NO];
    }else
    {
    PX_PlanDetailViewController  *Dvc = [[PX_PlanDetailViewController alloc]init];
    Dvc.planId = model.ID;
    [self.navigationController pushViewController:Dvc animated:NO];
    }
}




@end
