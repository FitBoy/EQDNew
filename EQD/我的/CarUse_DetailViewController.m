//
//  CarUse_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CarUse_DetailViewController.h"
#import "CarUseModel.h"
#import <StoreKit/StoreKit.h>
#import "FBTwoButtonView.h"
#import "FBFour_noimgTableViewCell.h"
@interface CarUse_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    CarUseModel *model_detail;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    NSMutableArray *arr_shenpi;
    NSMutableArray *arr_model;
}

@end

@implementation CarUse_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"用车详情";
    arr_shenpi = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
     arr_names = @[@"用车开始时间",@"用车结束时间",@"车号",@"出发地",@"目的地",@"司机",@"乘坐人数",@"用车说明",@"申请人",@"申请人部门",@"申请时间"];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    [WebRequest Com_Vehicle_Get_vehiApplyDetailWithuserGuid:user.Guid comid:user.companyId applicationId:self.apllyId And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            model_detail = [CarUseModel  mj_objectWithKeyValues:dic[Y_ITEMS]];
            arr_contents = [NSMutableArray arrayWithArray:@[model_detail.startTime,model_detail.endTime,model_detail.plateNumber,model_detail.origin,model_detail.destination,model_detail.theDriverName,model_detail.personCount,model_detail.theReason,model_detail.applyerName,model_detail.applyerDepName,model_detail.createTime]];
            [tableV reloadData];
        }
    }];
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_model.count==0?1:2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_contents.count:arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
        }
        cell.textLabel.text = arr_names[indexPath.row];
        cell.detailTextLabel.text =arr_contents[indexPath.row];
        return cell;
    }else
    {
        static NSString *cellId=@"cellID";
       FBFour_noimgTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
           
        }
        cell.textLabel.text = arr_names[indexPath.row];
        cell.detailTextLabel.text =arr_contents[indexPath.row];
        return cell;
    }
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}






@end
