//
//  MEMo_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MEMo_DetailViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "DatePicer_AlertView.h"
#import "NSString+FBString.h"
@interface MEMo_DetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate>
{
    NSMutableArray *arr_names;
    UITableView *tableV;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView *date_alert;
    DatePicer_AlertView *date_alert1;
}

@end

@implementation MEMo_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    date_alert1 =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter1 =[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"HH:mm"];
    NSString *date_str1 = [formatter1 stringFromDate:[NSDate date]];
    [date_alert1 setDate2:date_str1];
    date_alert1.picker.datePickerMode =UIDatePickerModeTime;
    [date_alert1.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert1.two_btn.B_left addTarget:self action:@selector(leftClick1) forControlEvents:UIControlEventTouchUpInside];
    [date_alert1.two_btn.B_right addTarget:self action:@selector(rightClick1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title =@"备忘录详情";
    user = [WebRequest GetUserInfo];
    arr_names =[NSMutableArray arrayWithArray:@[@"备忘录编码",@"名称",@"类型",@"开始日期",@"结束日期",@"开始时分",@"结束时分",@"提醒",@"备注",@"地点"]];
    NSString *tstr =@" ";
    if ([_model.timeToRemind integerValue]==-1) {
        tstr = @"无提醒";
    }else
    {
        tstr = [NSString stringWithFormat:@"提前%@分钟",_model.timeToRemind];
    }
    arr_contents =[NSMutableArray arrayWithArray:@[_model.eventCode,_model.eventName,_model.eventType,_model.startDate,_model.endDate,_model.startTime,_model.endTime,tstr,_model.memoInfo,_model.place]];
        tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
        adjustsScrollViewInsets_NO(tableV, self);
        tableV.delegate=self;
        tableV.dataSource=self;
        [self.view addSubview:tableV];
        tableV.rowHeight=60;
       
}

-(void)leftClick1
{
    //取消
    [date_alert1 removeFromSuperview];
    
}
-(void)rightClick1
{
    //确定
    NSDateFormatter *formatter1 =[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"HH:mm"];
    NSString *date_str1 = [formatter1 stringFromDate:date_alert1.picker.date];
    [arr_contents replaceObjectAtIndex:date_alert1.two_btn.B_right.indexpath.row withObject:date_str1];
    [tableV reloadRowsAtIndexPaths:@[date_alert1.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [date_alert1 removeFromSuperview];
}
-(void)leftClick
{
    //取消
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    //时间确定
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    [arr_contents replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
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
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    if (indexPath.row==0) {
        cell.accessoryType= UITableViewCellAccessoryNone;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
if(indexPath.row==1 ||indexPath.row==9)
{
    //名称
    FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
    TFvc.delegate =self;
    TFvc.indexPath =indexPath;
    TFvc.content =arr_contents[indexPath.row];
    TFvc.contentTitle =arr_names[indexPath.row];
    [self.navigationController pushViewController:TFvc animated:NO];
}else if (indexPath.row==2)
{
    UIAlertController  *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"空闲" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"暂定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"忙碌" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"外出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}else if (indexPath.row==7)
{
    //提醒
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"不提醒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"提前10分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"提前20分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"提前30分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"提前60分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"提前90分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"提前120分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self xiugai];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}else if (indexPath.row==8){
    //备注
    FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
    TVvc.indexpath =indexPath;
    TVvc.contentTitle =arr_names[indexPath.row];
    TVvc.content= arr_contents[indexPath.row];
    TVvc.delegate =self;
    [self.navigationController pushViewController:TVvc animated:NO];
}else if (indexPath.row ==3 || indexPath.row==4){
    //日期
    date_alert.two_btn.B_right.indexpath=indexPath;
    [self.view addSubview:date_alert];
}else if (indexPath.row==5 || indexPath.row ==6){
    //时分
    date_alert1.two_btn.B_right.indexpath=indexPath;
    [self.view addSubview:date_alert1];
}
else
{
}
}
#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
   
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
     [self xiugai];
}

-(void)xiugai
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest memo_UpdateMemoWithmemoid:_model.ID eventName:arr_contents[1] startDate:arr_contents[3] endDate:arr_contents[4] startTime:arr_contents[5] endTime:arr_contents[6] memoInfo:arr_contents[8] eventType:arr_contents[2] timeToRemind:[NSString numberWithStr:arr_contents[7]] place:arr_contents[9] userGuid:user.Guid  And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            hud.label.text =@"修改成功";
        }else
        {
            hud.label.text =@"修改失败，请重试";
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
}

-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self xiugai];
}


@end
