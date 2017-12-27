//
//  Accident_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/6.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Accident_ListViewController.h"
#import "Accident_AddViewController.h"
#import "AccidentModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "RepairRecord_DetailViewController.h"
@interface Accident_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
    NSString *page;
}

@end

@implementation Accident_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_Vehicle_Get_vehicleAccidentWithuserGuid:user.Guid comid:user.companyId page:@"0" vehicleId:self.Id And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            page =dic[@"nextpage"];
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                AccidentModel *model =[AccidentModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
        }
        [tableV reloadData];
    }];
}
-(void)loadOtherData
{
    [WebRequest Com_Vehicle_Get_vehicleAccidentWithuserGuid:user.Guid comid:user.companyId page:page vehicleId:self.Id And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page =dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                AccidentModel *model =[AccidentModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
                   [tableV reloadData];
            }
        }
     
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"事故记录";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    page= @"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)tianjiaClick
{
    //添加事故记录
    Accident_AddViewController  *Avc =[[Accident_AddViewController alloc]init];
    Avc.Id =self.Id;
    Avc.plateNumber =self.plateNumber;
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
    AccidentModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccidentModel *model = arr_model[indexPath.row];
    NSArray *tarr_names= @[@"车号",@"责任人",@"事故发生时间",@"事故地点",@"责任比例",@"费用(元)",@"备注",@"添加人",@"添加时间"];
    NSArray *tarr_contents = @[model.plateNumber,model.personLiableName,model.theTime,model.thePlace,model.dutyRatio,model.cost,model.remark,model.createrName,model.createTime];
    NSArray *tarr_code = @[@"1",@"1",@"4",@"1",@"1",@"1",@"3",@"1",@"4"];
    NSMutableArray *arr_json = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<tarr_contents.count; i++) {
        GNmodel  *model1 = [[GNmodel alloc]init];
        model1.name = tarr_names[i];
        model1.content =tarr_contents[i];
        model1.biaoji =[tarr_code[i] integerValue];
        if (i==6) {
            model1.arr_imgs = model.picAddr;
        }
        [arr_json addObject:model1];
    }
    
    
    RepairRecord_DetailViewController *Dvc =[[RepairRecord_DetailViewController alloc]init];
    Dvc.arr_json = arr_json;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
