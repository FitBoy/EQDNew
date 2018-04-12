//
//  JB_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "JB_AddViewController.h"
#import "FBThree_noimg122TableViewCell.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "DatePicer_AlertView.h"
#import "FBTextVViewController.h"
#import "FBOptionViewController.h"
#import "FBTextFieldViewController.h"
#import "NSString+FBString.h"
@interface JB_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBOptionViewControllerDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView *picker_alert;
    BOOL canTijiao;
}
@end

@implementation JB_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"加班申请";
    arr_names =[NSMutableArray arrayWithArray:@[@"加班开始时间",@"加班结束时间",@"加班时长",@"加班类型",@"加班原因",@"审批人"]];
    user =[WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
 
    tableV.contentInset=UIEdgeInsetsMake(15, 0, 0, 0);
    arr_contents =[NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请输入",@"请选择",@"请输入"]];
    [WebRequest Get_User_LeaderWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSString *tstr = dic[Y_ITEMS];
            if (tstr.length!=0) {
             [arr_contents addObject:dic[Y_ITEMS]];
            }
           else
        {
            [arr_contents addObject:@"您是最高领导人"];
        }
        
        [tableV reloadData];
        }
        
    }];
    picker_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    picker_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *tstr =[formatter stringFromDate:[NSDate date]];
    [picker_alert setDate:tstr];
    [picker_alert.two_btn.B_left addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [picker_alert.two_btn.B_right addTarget:self action:@selector(qudingClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    

}

-(void)tijiaoClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
    [WebRequest OverTimes_Add_OverTimeWithuserGuid:user.Guid companyId:user.companyId startOverTime:arr_contents[0] endOverTime:arr_contents[1] times:arr_contents[2] overTimeReason:arr_contents[4] overTimeType:arr_contents[3] And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
}

-(void)qudingClick:(FBButton*)tbtn
{
    //确定
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *tstr =[formatter stringFromDate:picker_alert.picker.date];
    [arr_contents replaceObjectAtIndex:tbtn.indexpath.row withObject:tstr];
    if (!([arr_contents[0] isEqualToString:@"请选择"] &&[arr_contents[0] isEqualToString:@"请选择"])) {
        NSDateFormatter *formatter1 =[[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date1 =[formatter1 dateFromString:arr_contents[0]];
        NSDateFormatter *formatter2 =[[NSDateFormatter alloc]init];
        [formatter2 setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date2 =[formatter2 dateFromString:arr_contents[1]];
        float day =[NSString hourWithDate1:date1 date2:date2];
        NSString *tstr1 =[NSString stringWithFormat:@"%.1f",day];
        
        [arr_contents replaceObjectAtIndex:2 withObject:tstr1];
        
    }
    [picker_alert removeFromSuperview];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
    
}
-(void)quxiaoClick
{
    [picker_alert removeFromSuperview];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return section==0?1:arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
    {
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
        if(indexPath.row==arr_contents.count-1)
        {
           cell.accessoryType = UITableViewCellAccessoryNone;
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
        if (indexPath.row==0) {
            //加班开始时间
            picker_alert.two_btn.B_right.indexpath =indexPath;
            [self.view addSubview:picker_alert];
            
        }else if(indexPath.row==1)
        {
            //加班结束时间
            picker_alert.two_btn.B_right.indexpath =indexPath;
            [self.view addSubview:picker_alert];
        }else if (indexPath.row==2)
        {
            //加班时长
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate=self;
            TFvc.indexPath =indexPath;
            TFvc.content=arr_contents[indexPath.row];
            TFvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
        }else if (indexPath.row==3)
        {
            //加班类型
            FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
            Ovc.delegate =self;
            Ovc.indexPath =indexPath;
            Ovc.option =34;
            Ovc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:Ovc animated:NO];
        }else if (indexPath.row==4)
        {
            //加班原因
            FBTextVViewController *Tvvc =[[FBTextVViewController alloc]init];
            Tvvc.indexpath =indexPath;
            Tvvc.delegate =self;
            Tvvc.contentTitle =arr_names[indexPath.row];
            Tvvc.content =arr_contents[indexPath.row];
            [self.navigationController pushViewController:Tvvc animated:NO];
        }else
        {
            
        }
    }else
    {
        
    }
}

#pragma  mark -自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
   
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

@end
