//
//  Memo_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Memo_AddViewController.h"
#import "FBTextVViewController.h"
#import "FBTextFieldViewController.h"
#import "DatePicer_AlertView.h"
#import "NSString+FBString.h"
#import "EventCalendar.h"
@interface Memo_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    DatePicer_AlertView *date_alert;
    DatePicer_AlertView *date_alert1;
    NSMutableArray *arr_contents;
    UserModel *user;
}

@end

@implementation Memo_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
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
    self.navigationItem.title = @"新增备忘录";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    arr_names =[NSMutableArray arrayWithArray:@[@"名称",@"备注(可选)",@"类型",@"地点（可选）",@"开始日期",@"结束日期",@"开始时分",@"结束时分",@"提醒"]];
    if (self.content.length==0) {
       arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请输入",@"请选择",@"请输入",self.date_selected,self.date_selected,@"请选择",@"请选择",@"请选择"]];
    }else
    {
         arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",self.content,@"请选择",@"请输入",self.date_selected,self.date_selected,@"请选择",@"请选择",@"请选择"]];
    }
   
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
-(void)tijiaoClick
{
    //提交
    NSInteger flag=0;
    for (int i=0; i<arr_contents.count; i++) {
        if (i==1 || i==3) {
            if([arr_contents[i] isEqualToString:@"请输入"])
            {
                arr_contents[i] = @" ";
            }
        }else
        {
            if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
                flag =1;
                break;
            }
        }
    }
    if (flag==1) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"参数不全";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest memo_AddMemoWithuserGuid:user.Guid eventName:arr_contents[0] startDate:arr_contents[4] endDate:arr_contents[5] startTime:arr_contents[6] endTime:arr_contents[7] memoInfo:arr_contents[1] eventType:arr_contents[2] timeToRemind:[NSString numberWithStr:arr_contents[8]] place:arr_contents[3] And:^(NSDictionary *dic) {
            NSArray *tarr=nil;
            NSString *time=nil;
            NSString *time0 =[NSString numberWithStr:arr_contents[8]];
            if ([time0 integerValue]>0) {
                time =[NSString stringWithFormat:@"%d",[time0 integerValue]*(-60)];
                tarr =@[time];
            }
            
            NSString *startTime0=[NSString stringWithFormat:@"%@ %@",arr_contents[4],arr_contents[6]];
            NSString *endTime0 = [NSString stringWithFormat:@"%@ %@",arr_contents[5],arr_contents[7]];
            NSDateFormatter  *famatter = [[NSDateFormatter alloc]init];
            [famatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date1 =[famatter dateFromString:startTime0];
            
            NSDate *date2 =[famatter dateFromString:endTime0];
            
            [[EventCalendar sharedEventCalendar] createEventCalendarTitle:arr_contents[0] location:arr_contents[3] startDate:date1 endDate:date2 allDay:NO alarmArray:tarr];
             
            
            
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
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
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:13];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==3) {
        //名称
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==1)
    {
    //备注
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.contentTitle =arr_names[indexPath.row];
        TVvc.content= arr_contents[indexPath.row];
        TVvc.delegate =self;
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row==2)
    {
        //类型
        UIAlertController  *alert =[[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"空闲" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"暂定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"忙碌" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"外出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
        
    }else if(indexPath.row==4 || indexPath.row ==5)
    {
        //日期
        date_alert.two_btn.B_right.indexpath=indexPath;
        [self.view addSubview:date_alert];
        
    }else if (indexPath.row==6 || indexPath.row==7)
        
    {
       //时分
        date_alert1.two_btn.B_right.indexpath=indexPath;
        [self.view addSubview:date_alert1];
    }
    else if (indexPath.row==8)
    {
        //提醒
        UIAlertController *alert =[[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"不提醒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"提前5分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"提前10分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"提前20分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"提前30分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"提前60分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"提前90分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"提前120分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
    }
}
#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}




@end
