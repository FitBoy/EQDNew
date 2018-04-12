//
//  TX_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TX_AddViewController.h"
#import "FBThree_noimg122TableViewCell.h"
#import "TX_DetailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBTextFieldViewController.h"
#import "DatePicer_AlertView.h"
#import "NSString+FBString.h"
@interface TX_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    DatePicer_AlertView *picker_alert;
    BOOL canTijiao;
}

@end

@implementation TX_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =[NSString stringWithFormat:@"%@的调休申请",user.company];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    arr_names =[NSMutableArray arrayWithArray:@[@"时段1开始时间",@"时段1结束时间",@"时段2开始时间",@"时段2结束时间",@"调休天数(天)"]];
    arr_contents =[NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请选择",@"请选择",@"请输入"]];
    picker_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:picker_alert];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str =[formatter stringFromDate:[NSDate date]];
    [picker_alert setDate:date_str];
    [picker_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [picker_alert.two_btn.B_left addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [picker_alert.two_btn.B_right addTarget:self action:@selector(queDingClick:) forControlEvents:UIControlEventTouchUpInside];
    picker_alert.picker.datePickerMode = UIDatePickerModeDateAndTime;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    [WebRequest  Get_User_LeaderWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        [arr_names addObject:@"审批人"];
        
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSString *Tstr = dic[Y_ITEMS];
            if(Tstr.length!=0)
            {
                canTijiao = YES;
            [arr_contents addObject:dic[Y_ITEMS]];
        }else
        {
            canTijiao = NO;
            [arr_contents addObject:@"无审批人，请联系管理员"];
        }
        }
          [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
    
}
-(void)tijiaoClick
{
    //提交调休
    NSInteger temp=0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请选择"] || [arr_contents[i] isEqualToString:@"请输入"] ) {
            temp=1;
        }
    }
    if (temp==1 || canTijiao ==NO) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"参数不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Add_OffWithuserGuid:user.Guid companyId:user.companyId planStartTime:arr_contents[0] planEndTime:arr_contents[1] offStartTime:arr_contents[2] offEndTime:arr_contents[3] offTimes:arr_contents[4] And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==200)
            {
                hud.label.text =@"提交成功，等待审核";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }
    
}
#pragma  mark - 时间框的确定或取消
-(void)quxiaoClick
{
    [picker_alert removeFromSuperview];
}
-(void)queDingClick:(FBButton*)tbtn
{
    NSDateFormatter *formattor =[[NSDateFormatter alloc]init];
    [formattor setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *tstr =[formattor stringFromDate:picker_alert.picker.date];
    
    [arr_contents replaceObjectAtIndex:tbtn.indexpath.row withObject:tstr];
    if(!([arr_contents[0] isEqualToString:@"请选择"] || [arr_contents[1] isEqualToString:@"请选择"]))
    {
        NSDateFormatter *formattor1 =[[NSDateFormatter alloc]init];
        [formattor1 setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date1 =[formattor1 dateFromString:arr_contents[0]];
        
        NSDateFormatter *formattor2 =[[NSDateFormatter alloc]init];
        [formattor2 setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date2 =[formattor2 dateFromString:arr_contents[1]];
        float day= [NSString day_numberWithdate1:date1 date2:date2 Withweeks:nil];
        NSString *tstr =[NSString stringWithFormat:@"%.1f",day];
        [arr_contents replaceObjectAtIndex:4 withObject:tstr];
    }
    
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    [picker_alert removeFromSuperview];
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 20;
    }
    else
    {
        return 10;
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return @"计划将“时段1”调休至“时段2”";
    }
    else
    {
        return nil;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?1:arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        FBThree_noimg122TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBThree_noimg122TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.L_left.text =user.username;
        cell.L_right0.text =[NSString stringWithFormat:@"%@-%@",user.department,user.post];
        cell.L_right1.text =[NSString stringWithFormat:@"工号:%@",user.jobNumber];
        return cell;
    }else
    {
        static NSString *cellId=@"cellID";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_right0.text =arr_contents[indexPath.row];
        return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==4) {
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =arr_contents[indexPath.row];
            TFvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
        }else
        {
            picker_alert.two_btn.B_right.indexpath =indexPath;
            picker_alert.two_btn.B_left.indexpath =indexPath;
            [self.view addSubview:picker_alert];
        }
    }
}
#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
}



@end
