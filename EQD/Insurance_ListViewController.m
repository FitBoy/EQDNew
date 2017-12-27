//
//  Insurance_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/6.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Insurance_ListViewController.h"
#import "Insurance_AddViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "InsuranceModel.h"
#import "RepairRecord_DetailViewController.h"
@interface Insurance_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation Insurance_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
   
    [WebRequest Com_Vehicle_Get_vehicleInsuranceWithuserGuid:user.Guid comid:user.companyId page:@"0" vehicleId:self.Id And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            page = dic[@"nextpage"];
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                InsuranceModel *model = [InsuranceModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
        }
        [tableV reloadData];
    }];
}
-(void)loadOtherData
{ [WebRequest Com_Vehicle_Get_vehicleInsuranceWithuserGuid:user.Guid comid:user.companyId page:page vehicleId:self.Id And:^(NSDictionary *dic) {
    [tableV.mj_header endRefreshing];
    [tableV.mj_footer endRefreshing];
    if ([dic[Y_STATUS] integerValue]==200) {
        page = dic[@"nextpage"];
        NSArray *tarr = dic[Y_ITEMS];
        if(tarr.count==0)
        {
            [tableV.mj_footer endRefreshingWithNoMoreData];
        }else{
            
        for (int i=0; i<tarr.count; i++) {
            InsuranceModel *model = [InsuranceModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
             [tableV reloadData];
        }
    }
   
}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"保险记录列表";
    page=@"0";
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
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
    Insurance_AddViewController *Avc =[[Insurance_AddViewController alloc]init];
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
    InsuranceModel  *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InsuranceModel  *model =arr_model[indexPath.row];
    NSArray *tarr_names =@[@"车号",@"保险公司",@"险种",@"缴费金额",@"缴费日期",@"当时公里数",@"经办人",@"备注",@"添加者",@"添加时间"];
    NSArray  *tarr_contents = @[model.plateNumber,model.InsuranceCompany,model.InsuranceType,model.money,model.theDate,model.mileageThen,model.agent,model.remark,model.createrName,model.createTime];
    NSArray *tarr_code = @[@"1",@"1",@"1",@"1",@"4",@"1",@"1",@"3",@"1",@"4"];
    NSMutableArray *arr_josn=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<tarr_contents.count; i++) {
        GNmodel *model1 = [[GNmodel alloc]init];
        model1.name=tarr_names[i];
        model1.content=tarr_contents[i];
        model1.biaoji = [tarr_code[i] integerValue];
        [arr_josn addObject:model1];
    }
    
    RepairRecord_DetailViewController *Dvc =[[RepairRecord_DetailViewController alloc]init];
    Dvc.arr_json = arr_josn;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
