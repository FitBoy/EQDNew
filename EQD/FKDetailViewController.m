//
//  FKDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FKDetailViewController.h"
#import "FBTextFieldViewController.h"
#import "DatePicer_AlertView.h"
#import "FBShowImg_TextViewController.h"
#import "EventCalendar.h"
@interface FKDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contens;
    UserModel *user;
    DatePicer_AlertView *date_alert;
}
@end

@implementation FKDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"反馈记录详情";
    arr_names =[NSMutableArray arrayWithArray:@[@"反馈标题",@"反馈类型",@"反馈人",@"反馈时间",@"反馈内容",@"提醒时间(处理反馈信息)",@"反馈地点",@"创建时间"]];
    arr_contens =[NSMutableArray arrayWithArray:@[self.model.fbtitle,_model.fbtype,_model.fberName,_model.fbTime,_model.fbcontent,_model.remindTime,_model.addr,_model.createTime]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
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
    [WebRequest crmModule_Update_cusfbRecordWithowner:user.Guid cusfbRecordid:self.model.ID data:data And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            hud.label.text =dic[Y_MSG];
            [[EventCalendar sharedEventCalendar] createEventCalendarTitle:_model.fbtitle location:_model.addr startDate:date_alert.picker.date endDate:date_alert.picker.date allDay:NO alarmArray:@[@"-5"]];
            [arr_contens replaceObjectAtIndex:5 withObject:date_str];
            [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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
    return arr_contens.count;
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
    if (indexPath.row==5) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text = arr_contens[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row==5)
  {
      [self.view addSubview:date_alert];
  }else if (indexPath.row==4)
  {
      FBShowImg_TextViewController *Svc =[[FBShowImg_TextViewController alloc]init];
      Svc.contents = _model.fbcontent;
      Svc.contentTitle = @"反馈信息";
      Svc.arr_imgs = _model.lpicAddr;
      [self.navigationController pushViewController:Svc animated:NO];
  }
  else
  {
  }
}



@end
