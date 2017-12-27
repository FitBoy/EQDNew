//
//  XuQiuPerson_listViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "XuQiuPerson_listViewController.h"
#import "SQXuQiuPersonViewController.h"
#import "XuQiuPersonModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "XuQiuPerson_DetailViewController.h"
@interface XuQiuPerson_listViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
    NSMutableArray *arr_model;
}

@end

@implementation XuQiuPerson_listViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if (self.isrenShi==1) {
       
    }else if (self.isrenShi==2)
    {
    }else
    {
    [WebRequest manPowerNeed_Get_mpns_createrWithuserGuid:user.Guid status:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex-1] page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                XuQiuPersonModel  *model = [XuQiuPersonModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page =dic[@"nextpage"];
            [tableV reloadData];
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
    }];
    }
}
-(void)loadOtherData
{
    [WebRequest manPowerNeed_Get_mpns_createrWithuserGuid:user.Guid status:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex-1] page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if(tarr.count==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                XuQiuPersonModel  *model = [XuQiuPersonModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page =dic[@"nextpage"];
            [tableV reloadData];
        }
      
       
        }
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"人力需求列表";
    user =[WebRequest GetUserInfo];
    page =@"0";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"已拒绝",@"申请中",@"已通过"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=1;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)addClick
{
    SQXuQiuPersonViewController  *Svc =[[SQXuQiuPersonViewController alloc]init];
    [self.navigationController pushViewController:Svc animated:NO];
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
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    XuQiuPersonModel *model = arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XuQiuPersonModel *model = arr_model[indexPath.row];
    XuQiuPerson_DetailViewController  *Dvc =[[XuQiuPerson_DetailViewController alloc]init];
    Dvc.mnpId = model.ID;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
