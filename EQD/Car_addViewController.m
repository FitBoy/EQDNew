//
//  Car_addViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Car_addViewController.h"
#import "FBTextFieldViewController.h"
#import "DatePicer_AlertView.h"
#import "FBTextvImgViewController.h"
#import "FBOptionViewController.h"
@interface Car_addViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextvImgViewControllerDelegate,FBTextFieldViewControllerDelegate,FBOptionViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    DatePicer_AlertView  *date_alert;
    NSArray *arr_imgs;
}

@end

@implementation Car_addViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"添加车辆";
    arr_names = [NSMutableArray arrayWithArray:@[@"车牌号码",@"车辆类型",@"座位数(除司机)",@"颜色",@"车辆识别号(VIN)",@"发动机号码",@"购买日期",@"购买价格",@"保险到期时间",@"年检日期",@"备注(图文)"]];
    arr_contents =[NSMutableArray arrayWithArray:@[@"请输入",@"请输入",@"请输入",@"请输入",@"请输入",@"请输入",@"请选择",@"请输入",@"请选择",@"请选择",@"请输入"]];
    
    user = [WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    arr_imgs =nil;
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)option:(NSString*)option indexPath:(NSIndexPath*)indexPath{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadData];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    [arr_contents replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [date_alert removeFromSuperview];
}
-(void)tijiaoClick
{
    NSInteger temp =0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
            temp =1;
            break;
        }
    }
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest  Com_Vehicle_Add_newVehicleInfoWithcomid:user.companyId userGuid:user.Guid plateNumber:arr_contents[0] VIN:arr_contents[4] engineCode:arr_contents[5] vehicleType:arr_contents[1] color:arr_contents[3] seats:arr_contents[2] purchaseDate:arr_contents[6] annInspectDate:arr_contents[9] insuranceEndDate:arr_contents[8] purchasePrice:arr_contents[7] remark:arr_contents[10] arr_imgs:arr_imgs And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"参数不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.option=41;
        Ovc.delegate =self;
        Ovc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Ovc animated:NO];
    }else if (indexPath.row <6 || indexPath.row==7) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==6 || indexPath.row==8 || indexPath.row==9)
    {
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
    }else if (indexPath.row==10)
    {
        FBTextvImgViewController  *IVvc =[[FBTextvImgViewController alloc]init];
        IVvc.indexPath =indexPath;
        IVvc.delegate =self;
        IVvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:IVvc animated:NO];
    }else
    {
    }
}
#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)text:(NSString *)text imgArr:(NSArray<UIImage *> *)imgArr indexPath:(NSIndexPath *)indexPath
{
    arr_imgs =imgArr;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}


@end
