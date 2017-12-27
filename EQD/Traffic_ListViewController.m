//
//  Traffic_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/5.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Traffic_ListViewController.h"
#import "Traffic_AddViewController.h"
#import "TrafficListModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "RepairRecord_DetailViewController.h"
@interface Traffic_ListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation Traffic_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
  
    [WebRequest Com_Vehicle_Get_vehiclelllegalWithuserGuid:user.Guid comid:user.companyId page:@"0" vehicleId:_Id And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            page =dic[@"nextpage"];
            NSArray *tarr =dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                TrafficListModel  *model =[TrafficListModel mj_objectWithKeyValues:tarr[i]];
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
    [WebRequest Com_Vehicle_Get_vehiclelllegalWithuserGuid:user.Guid comid:user.companyId page:page vehicleId:_Id And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            page =dic[@"nextpage"];
            NSArray *tarr =dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                TrafficListModel  *model =[TrafficListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
                 [tableV reloadData];
            }
           
        }
       
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"违章记录";
    user =[WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)tianjiaClick
{
    //添加违章记录
    Traffic_AddViewController  *Avc =[[Traffic_AddViewController alloc]init];
    Avc.Id = self.Id;
    Avc.plteNumber =self.plateNumber;
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
    TrafficListModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    TrafficListModel  *model =arr_model[indexPath.row];
    NSMutableArray *arr_josn = [NSMutableArray arrayWithCapacity:0];
    NSArray  *tarr_names =@[@"车号",@"违章人",@"违章时间",@"违章原因",@"扣罚(扣分与罚款)",@"是否处理",@"提交时间",@"提交人"];
    NSArray *tarr_contents =@[model.plateNumber,model.personLiableName,model.theDate,model.theReason,model.theFine,[model.isdone integerValue]==0?@"未处理":@"已处理" ,model.createTime,model.createrName];
    NSArray *tarr_code = @[@"1",@"1",@"4",@"3",@"1",@"1",@"4",@"1"];
    for (int i=0; i<tarr_contents.count; i++) {
        GNmodel *model1 = [[GNmodel alloc]init];
        model1.name =tarr_names[i];
        model1.content =tarr_contents[i];
        model1.biaoji =[tarr_code[i] integerValue];
        if (i==3) {
            model1.arr_imgs =model.picAddr;
        }
        [arr_josn addObject:model1];
    }
    RepairRecord_DetailViewController  *Dvc = [[RepairRecord_DetailViewController alloc]init];
    Dvc.arr_json = arr_josn;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
