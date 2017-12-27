//
//  CarManager_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CarManager_DetailViewController.h"
#import "CarManager_Detail.h"
#import "FBShowImg_TextViewController.h"
#import "DatePicer_AlertView.h"
#import "FBTextFieldViewController.h"
#import "Accident_ListViewController.h"
#import "Insurance_ListViewController.h"
#import "Traffic_ListViewController.h"
#import "RePairRecord_ViewController.h"
@interface CarManager_DetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    CarManager_Detail *model_detail;
    DatePicer_AlertView  *date_alert;
}

@end

@implementation CarManager_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"车辆详情";
    user = [WebRequest GetUserInfo];
     arr_names = [NSMutableArray arrayWithArray:@[@"车牌号码",@"车辆类型",@"座位数(除司机)",@"颜色",@"车辆识别号(VIN)",@"发动机号码",@"购买日期",@"购买价格",@"保险到期时间",@"年检日期",@"备注(图文)",@"维修次数",@"保养次数",@"违章次数",@"事故次数"]];
    [WebRequest  Com_Vehicle_Get_vehicleDetailInfoWithuserGuid:user.Guid comid:user.companyId vehicleId:self.Id And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            model_detail = [CarManager_Detail mj_objectWithKeyValues:dic[Y_ITEMS]];
        arr_contents =[NSMutableArray arrayWithArray:@[model_detail.plateNumber,model_detail.vehicleType,model_detail.seats,model_detail.color,model_detail.VIN,model_detail.engineCode,model_detail.purchaseDate,model_detail.purchasePrice,model_detail.insuranceEndDate,model_detail.annInspectDate,model_detail.remark,model_detail.repairedCount,model_detail.maintainCount,model_detail.peccancyCount,model_detail.accidentCount]];
            [tableV reloadData];
        }
    }];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];

}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    NSString  *tstr = date_alert.two_btn.B_right.indexpath.row==8?@"insuranceEndDate":@"annInspectDate";
    NSString *data= [NSString stringWithFormat:@"{'%@':'%@'}",tstr,date_str];
    [WebRequest Com_Vehicle_Update_vehicleInfoWithuserGuid:user.Guid comid:user.companyId vehicleId:model_detail.Id data:data And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:date_str];
            [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    [date_alert removeFromSuperview];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    if (indexPath.row==0 || indexPath.row==8|| indexPath.row==9 || indexPath.row==10) {
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
         cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //车牌号
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==8 || indexPath.row ==9)
    {
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
        
    }else if (indexPath.row == 10)
    {
        FBShowImg_TextViewController  *ITvc =[[FBShowImg_TextViewController alloc]init];
        ITvc.arr_imgs  =model_detail.picAddr;
        ITvc.contents = model_detail.remark;
        ITvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:ITvc animated:NO];
    }else if (indexPath.row==11|| indexPath.row==12)
    {
        //,@"维修次数",@"保养次数",@"违章次数",@"事故次数"
        RePairRecord_ViewController   *Lvc =[[RePairRecord_ViewController alloc]init];
        CarManagerModel  *model = [[CarManagerModel alloc]init];
        model.Id =model_detail.Id;
        model.plateNumber =model_detail.plateNumber;
        Lvc.model =model;
        [self.navigationController pushViewController:Lvc animated:NO];
        
    }else if (indexPath.row==13)
    {
        Traffic_ListViewController  *Lvc= [[Traffic_ListViewController alloc]init];
        Lvc.Id =model_detail.Id;
        Lvc.plateNumber=model_detail.plateNumber;
        [self.navigationController pushViewController:Lvc animated:NO];
    }else if (indexPath.row==14)
    {
        Accident_ListViewController *Lvc =[[Accident_ListViewController alloc]init];
        Lvc.Id =model_detail.Id;
        Lvc.plateNumber =model_detail.plateNumber;
        [self.navigationController pushViewController:Lvc animated:NO];
    }
    else
    {
    }
}

#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    NSString  *data = [NSString stringWithFormat:@"{'%@':'%@'}",@"plateNumber",content];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest  Com_Vehicle_Update_vehicleInfoWithuserGuid:user.Guid comid:user.companyId vehicleId:model_detail.Id data:data And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents replaceObjectAtIndex:0 withObject:content];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
}

@end
