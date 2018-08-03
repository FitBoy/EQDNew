//
//  GongGao_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GongGao_AddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "Bumen_ChooseViewController.h"
#import "FBone_SwitchTableViewCell.h"
#import "DatePicer_AlertView.h"
@interface GongGao_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,Bumen_ChooseViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contens;
    ZuZhiModel *bumen_model;
    UserModel *user;
    DatePicer_AlertView *date_alert;
    NSString *time;
}

@end

@implementation GongGao_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    time = @" ";
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"发布公告";
    arr_names =[NSMutableArray arrayWithArray:@[@"公文类型",@"发布对象",@"公文主题",@"公文内容",@"处理时限",@"是否定时发送"]];
    NSString *tstr = @"请选择";
    if ([self.gongwen isEqualToString:@"通知"]) {
        tstr = user.department;
        bumen_model = [[ZuZhiModel alloc]init];
        bumen_model.type = @"1";
        bumen_model.departId = user.departId;
    }
    arr_contens =[NSMutableArray arrayWithArray:@[self.gongwen,tstr,@"请输入",@"请输入",@"请选择",@"定时"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    //设置发送时间
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    date_alert.L_title.text = @"设置发送时间";
}
-(void)tijiaoClick{
    NSInteger  temp =0;
   
    NSString *isadmin = nil;
    if ([user.isAdmin integerValue]>0) {
        isadmin = @"1";
    }else if([user.isleader integerValue]>0)
    {
        isadmin = @"0";
    }else
    {
        temp =1;
    }
    if (temp==0) {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
        
        NSString *isTimer = @"false";
        if ([time isEqualToString:@" "]) {
            isTimer =@"true";
        }
        
    [WebRequest Notices_Add_NoticeWithcompanyId:user.companyId noticeName:arr_contens[0] objectType:bumen_model.type objectDepartId:bumen_model.departId noticeTheme:arr_contens[2] noticeContent:arr_contens[3] userGuid:user.Guid noticeCycle:arr_contens[4] createDepartId:user.departId isAdmin:isadmin isTimer:isTimer noticeTime:time  And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
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
        hud.label.text =@"参数不完整或您无此权限";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contens.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==arr_contens.count-1) {
        static NSString *cellId=@"cellID";
        FBone_SwitchTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBone_SwitchTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
         
        }
        cell.L_left0.text = arr_names[indexPath.row];
        [cell.S_kaiguan addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }else
    {
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contens[indexPath.row];
    return cell;
    }
}

-(void)chooseClick:(UISwitch*)S_kaiguan
{
    if (S_kaiguan.isOn==YES) {
         [self.view addSubview:date_alert];
       
    }else
    {
        FBone_SwitchTableViewCell  *cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:arr_contens.count-1 inSection:0]];
        cell.L_left0.text = @"是否设置定时";
        time = @" ";
    }
}
-(void)leftClick{
    FBone_SwitchTableViewCell  *cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:arr_contens.count-1 inSection:0]];
    cell.L_left0.text = @"是否设置定时";
    [cell.S_kaiguan setOn:NO];
    time = @" ";
    [date_alert removeFromSuperview];
}
-(void)rightClick{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    time = date_str;
    FBone_SwitchTableViewCell  *cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:arr_contens.count-1 inSection:0]];
    cell.L_left0.text = [NSString stringWithFormat:@"定时:%@",time];
   [date_alert removeFromSuperview];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if ([self.gongwen isEqualToString:@"通知"]) {
            
        }else
        {
        UIAlertController  *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"公告",@"通知",@"通告"];
        for(int i=0;i <tarr.count;i++)
        {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [arr_contens replaceObjectAtIndex:indexPath.row withObject:tarr[i]];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
        }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self  presentViewController:alert animated:NO completion:nil];
            });
        }
        
    }else  if (indexPath.row==2) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.contentTitle =arr_names[indexPath.row];
        TFvc.content =arr_contens[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==3 )
    {
        //公告内容
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content=arr_contens[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if ( indexPath.row==1)
    {
        //发布对象
        if ([self.gongwen isEqualToString:@"通知"]) {
            
        }else{
        Bumen_ChooseViewController *Cvc =[[Bumen_ChooseViewController alloc]init];
        Cvc.delegate =self;
        Cvc.indexPath =indexPath;
        [self.navigationController pushViewController:Cvc animated:NO];
        }
    }else if(indexPath.row==4)
    {
        //处理时限
        UIAlertController *alert =[[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"1小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"2小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"4小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"8小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"24小时内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"两个工作日内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"三个工作日内" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contens replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
       
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    }else
    {
        
    }
}
#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contens replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contens replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getBumenModel:(ZuZhiModel *)model indexPath:(NSIndexPath *)indexPath
{
    bumen_model = model;
    [arr_contens replaceObjectAtIndex:indexPath.row withObject:model.departName];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
