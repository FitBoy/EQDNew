//
//  GLRecord_detailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GLRecord_detailViewController.h"
#import "GLRecodeModel.h"
#import "DatePicer_AlertView.h"
#import "FBShowImg_TextViewController.h"
#import "EventCalendar.h"
@interface GLRecord_detailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    GLRecodeModel *model_detail;
    NSArray *arr_imgAddr;
    DatePicer_AlertView *date_alert;
}

@end

@implementation GLRecord_detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回访记录详情";
    user =[WebRequest GetUserInfo];
    arr_names =[NSMutableArray arrayWithArray:@[@"回访标题",@"联系人",@"回访类型",@"回访日期",@"回访内容",@"提醒(再次回访)",@"创建时间"]];
    [WebRequest  crmModule_Get_revisitRecordInfoWithowner:user.Guid recordId:_model.ID And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [GLRecodeModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            arr_imgAddr = dic[@"picturesAddr"];
            arr_contents =[NSMutableArray arrayWithArray:@[model_detail.revisitTitle,model_detail.contactsName,model_detail.revisitType,model_detail.revisitDate,model_detail.revisitcontent,model_detail.remindTime,model_detail.createTime]];
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
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
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
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    NSString *data = [NSString stringWithFormat:@"{'remindTime':'%@'}",date_str];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest crmModule_Update_revisitRecordWithowner:user.Guid revisitRecordid:self.model.ID data:data And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
           [arr_contents replaceObjectAtIndex:5 withObject:date_str];
            [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            //@[@"回访标题",@"联系人",@"回访类型",@"回访日期",@"回访内容",@"提醒(再次回访)",@"创建时间"]
            [[EventCalendar sharedEventCalendar] createEventCalendarTitle:arr_contents[0] location:@" " startDate:date_alert.picker.date endDate:date_alert.picker.date allDay:NO alarmArray:@[@"-5"]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    if (indexPath.row==4 || indexPath.row==5) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==4) {
        FBShowImg_TextViewController  *TIvc=[[FBShowImg_TextViewController alloc]init];
        TIvc.contents = model_detail.revisitcontent;
        TIvc.arr_imgs = arr_imgAddr;
        TIvc.contentTitle =@"回访内容";
        [self.navigationController pushViewController:TIvc animated:NO];
    }else if (indexPath.row==5)
    {
        [self.view addSubview:date_alert];
    }else
    {
    }
}




@end
