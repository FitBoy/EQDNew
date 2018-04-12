//
//  FFMyExpensesViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FFMyExpensesViewController.h"
#import "FFMyEx_addViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "FFMyExpenseDetailViewController.h"
@interface FFMyExpensesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSString *page;
    UISegmentedControl *segmentC;
    NSMutableArray *arr_model;
}

@end

@implementation FFMyExpensesViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"371" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    [WebRequest Reimburse_Get_Reimburse_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                My_BaoXiaoModel *model =[My_BaoXiaoModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)loadOtherData{
    [WebRequest Reimburse_Get_Reimburse_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:page type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                My_BaoXiaoModel *model =[My_BaoXiaoModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight=60;
                [arr_model addObject:model];
            }
            
            [tableV reloadData];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"我的报销";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(exaddClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];

    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"待审核",@"已报销"]];
    segmentC.frame =CGRectMake(0, DEVICE_HEIGHT-40-kBottomSafeHeight, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
}

-(void)exaddClick
{
    FFMyEx_addViewController *Avc = [[FFMyEx_addViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    My_BaoXiaoModel *model =arr_model[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
 
    My_BaoXiaoModel *model =arr_model[indexPath.row];
    [cell setModel_baoxiao:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    My_BaoXiaoModel *model =arr_model[indexPath.row];
    FFMyExpenseDetailViewController  *Dvc = [[FFMyExpenseDetailViewController alloc]init];
    Dvc.Id = model.Id;
    Dvc.isShow =@"1";
    [self.navigationController pushViewController:Dvc animated:NO];
    
}


@end
