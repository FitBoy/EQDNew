//
//  CAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CAddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "DatePicer_AlertView.h"
#import "FBOptionViewController.h"
#import "GLLianXiRenViewController.h"
#import "EventCalendar.h"
@interface CAddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FBOptionViewControllerDelegate,GLLianXiRenViewControllerdelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contens;
    UserModel *user;
    DatePicer_AlertView *date_alert;
    GLLianXiModel *model_lianxi;
}

@end

@implementation CAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"添加销售机会";
    arr_names =[NSMutableArray arrayWithArray:@[@"*机会名称",@"*机会分类",@"客户",@"*联系人",@"*兴趣产品",@"预期成交日期",@"产品销售金额（元）",@"预期金额（元）",@"备注",@"提醒"]];

         arr_contens=[NSMutableArray arrayWithArray:@[@"请输入",@"请选择",[USERDEFAULTS objectForKey:Y_ManagerName],@"请选择",@"请输入",@"请选择",@"请输入",@"请输入",@"请输入",@"请选择"]];
   
   
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
   }

-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    if (date_alert.two_btn.B_right.indexpath.row==9) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else
    {
    [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    [arr_contens replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [date_alert removeFromSuperview];
}
-(void)tijiaoClick
{
    //@[@"*机会名称",@"*机会分类",@"客户",@"*联系人",@"*兴趣产品",@"预期成交日期",@"产品销售金额（元）",@"预期金额（元）",@"备注",@"提醒"]
    NSInteger temp =0;
    for (int i=0; i<arr_contens.count; i++) {
        if (i==0||i==1||i==3||i==4) {
            if ([arr_contens[i] isEqualToString:@"请输入"] || [arr_contens[i] isEqualToString:@"请选择"]) {
                temp=1;
                break;
            }
        }else
        {
            if ([arr_contens[i] isEqualToString:@"请输入"] || [arr_contens[i] isEqualToString:@"请选择"]) {
                arr_contens[i]=@" ";
            }
        }
    }
    if (temp==1) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"带*为必填项";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
    [WebRequest crmModule_Create_saleschanceWithowner:user.Guid comid:user.companyId chanceName:arr_contens[0] chanceClassify:arr_contens[1] cusid: [USERDEFAULTS objectForKey:Y_ManagerId] contacts:model_lianxi.ID interestproducts:arr_contens[4] createDate:@"1970-11-11" exdateofcompletion:arr_contens[5] productsalesmoney:arr_contens[6] expectmoney:arr_contens[7] remark:arr_contens[8] remindTime:arr_contens[9] And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if([dic[Y_STATUS] integerValue]==200)
        {
            if ([arr_contens[9] isEqualToString:@" "]) {
                
            }else
            {
            NSDateFormatter  *famatter = [[NSDateFormatter alloc]init];
            [famatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date1 =[famatter dateFromString:arr_contens[9]];
            [[EventCalendar sharedEventCalendar] createEventCalendarTitle:arr_contens[0] location:@" " startDate:date1 endDate:date1 allDay:NO alarmArray:@[@"-5"]];
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    }
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
    }
    cell.textLabel.text=arr_names[indexPath.row];
    cell.detailTextLabel.text=arr_contens[indexPath.row];
    if(indexPath.row==2)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0|| indexPath.row==4||indexPath.row==6 || indexPath.row==7) {
        // 机会名称  兴趣产品  销售金额 预期金额
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath=indexPath;
        TFvc.delegate=self;
        TFvc.contentTitle =arr_names[indexPath.row];
        TFvc.content =arr_contens[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
        
    }
    else if(indexPath.row==1)
    {
       //机会分类
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.delegate =self;
        Ovc.indexPath = indexPath;
        Ovc.contentTitle =arr_names[indexPath.row];
        Ovc.option=37;
        [self.navigationController pushViewController:Ovc animated:NO];
    }
    else if(indexPath.row==3)
    {
     //联系人
        GLLianXiRenViewController *Lvc =[[GLLianXiRenViewController alloc]init];
        Lvc.delegate =self;
        Lvc.ischoose=1;
        [self.navigationController pushViewController:Lvc animated:NO];
        
    }
    else if(indexPath.row==5)
    {
     //预期成交日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_str = [formatter stringFromDate:[NSDate date]];
        date_alert.picker.datePickerMode =UIDatePickerModeDate;
        [date_alert setDate3:date_str];
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
        
    }
    else if(indexPath.row==8)
    {
        //备注
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle =arr_names[indexPath.row];
        TVvc.content =arr_contens[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
        
    }
    else if(indexPath.row==9)
    {
        //提醒
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *date_str = [formatter stringFromDate:[NSDate date]];
        [date_alert setDate:date_str];
        date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
    }
    else
    {
        
    }
        
}

#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contens replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadData];
}

-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contens replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadData];
}
-(void)lianxiModel:(GLLianXiModel *)model
{
    model_lianxi =model;
    [arr_contens replaceObjectAtIndex:3 withObject:model.name];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [arr_contens replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
