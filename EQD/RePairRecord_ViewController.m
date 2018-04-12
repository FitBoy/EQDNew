//
//  RePairRecord_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RePairRecord_ViewController.h"
#import "Repair_ListModel.h"
#import "Repair_AddViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "RepairRecord_DetailViewController.h"
@interface RePairRecord_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation RePairRecord_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_Vehicle_Get_vehicleRepairVWithuserGuid:user.Guid comid:user.companyId page:@"0" vehicleId:_model.Id And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            page =dic[@"nextpage"];
            NSArray  *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                Repair_ListModel  *model =[Repair_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData
{
    [WebRequest Com_Vehicle_Get_vehicleRepairVWithuserGuid:user.Guid comid:user.companyId page:page vehicleId:_model.Id And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            page =dic[@"nextpage"];
            NSArray  *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                Repair_ListModel  *model =[Repair_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
         
            [tableV reloadData];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page =@"0";
    self.navigationItem.title = @"保养/维修记录列表";
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=65;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    if([_model.Id integerValue]==0)
    {
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    }else
    {
    }
}
-(void)tianjiaClick
{
    Repair_AddViewController  *Avc =[[Repair_AddViewController alloc]init];
    Avc.model = _model;
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
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    Repair_ListModel  *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      Repair_ListModel  *model =arr_model[indexPath.row];
    RepairRecord_DetailViewController  *Dvc =[[RepairRecord_DetailViewController alloc]init];
   NSArray  *tarr_names =@[@"车",@"保养/维修人",@"保养/维修时间",@"保养/维修地点",@"保养/维修费用",@"备注",@"提交时间",@"提交人"];
    NSArray  *tarr_contents =@[model.plateNumber,model.agent,model.when,model.where,model.cost,model.remark,model.createTime,model.createrName];
    NSArray  *tbiaoji = @[@"1",@"1",@"4",@"1",@"1",@"3",@"4",@"1"];
    NSMutableArray   *tarr_json = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<tarr_contents.count; i++) {
        GNmodel *model1 =[[GNmodel alloc]init];
        model1.name =tarr_names[i];
        model1.content =tarr_contents[i];
        model1.biaoji =[tbiaoji[i] integerValue];
        if (i==5) {
            model1.arr_imgs =model.picAddr;
        }
        [tarr_json addObject:model1];
    }
    Dvc.arr_json =tarr_json;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
