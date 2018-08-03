//
//  SQChuChaAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQChuChaAddViewController.h"
#import "FBTextFieldViewController.h"

#import "FBAddressViewController.h"
#import "FBSearchMapViewController.h"

#import "FBThree_noimg122TableViewCell.h"
#import "FBTwo_noimg12TableViewCell.h"

#import "DatePicer_AlertView.h"
#import "FBTextVViewController.h"
#import "NSString+FBString.h"
@interface SQChuChaAddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBAddressViewControllerDelegate,FBSearchMapViewControllerDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView *picker_alert;
    NSString *str_jing_wei;
    BOOL canTijiao;
}

@end

@implementation SQChuChaAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =[NSString stringWithFormat:@"%@出差申请单",user.company];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    arr_names =[NSMutableArray arrayWithArray:@[@"出差开始时间",@"出差结束时间",@"出差时长(天)",@"出差地点",@"出差原因",@"审批人"]];
    
    str_jing_wei =[USERDEFAULTS objectForKey:@"SQChuChaAdd_jingwei"];
    
    [WebRequest Get_User_LeaderWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =[USERDEFAULTS objectForKey:@"SQChuChaAdd"];
            if (tarr.count==0) {
                NSString *Tstr = dic[Y_ITEMS];
                if (Tstr.length !=0) {
                arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请输入",@"请选择",@"请输入", dic[Y_ITEMS] ]];
                }else
                {
                    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请输入",@"请选择",@"请输入", @"您是最高领导人" ]];
                }
                
            }
            else
            {
                arr_contents = [NSMutableArray arrayWithArray:tarr];
            }
            [tableV reloadData];
        }else
        {
            arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请输入",@"请选择",@"请输入", @"您是最高领导人"]];
        }
        
    }];
    
  
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(shenqingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    picker_alert=[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    picker_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [picker_alert setDate:[formatter stringFromDate:[NSDate date]]];
    [picker_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [picker_alert.two_btn.B_left addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [picker_alert.two_btn.B_right addTarget:self action:@selector(queDingClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)quxiaoClick
{

    [picker_alert removeFromSuperview];
    
}
-(void)queDingClick:(FBButton*)tbtn
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *tstr =[formatter stringFromDate:picker_alert.picker.date];
    [arr_contents replaceObjectAtIndex:tbtn.indexpath.row withObject:tstr];
    if (![arr_contents[0] isEqualToString:@"请选择"] &&![arr_contents[1] isEqualToString:@"请选择"] ) {
        NSDateFormatter *formatter1 =[[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDateFormatter *formatter2 =[[NSDateFormatter alloc]init];
        [formatter2 setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date1 =[formatter1 dateFromString:arr_contents[0]];
        NSDate *date2 =[formatter2 dateFromString:arr_contents[1]];
        float day =[NSString day_numberWithdate1:date1 date2:date2 Withweeks:nil];
        [arr_contents replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.1f",day]];
    }
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
    [picker_alert removeFromSuperview];
}

-(void)shenqingClick
{
    //提交
    if ([arr_contents containsObject:@"请输入"] || [arr_contents containsObject:@"请选择"]) {
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
    [WebRequest travel_Add_TravelWithuserGuid:user.Guid companyId:user.companyId travelStartTime:arr_contents[0] travelEndTime:arr_contents[1] travelTimes:arr_contents[2] travelReason:arr_contents[4] travelAddress:arr_contents[3] mapAddress:str_jing_wei And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
        
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [USERDEFAULTS setObject:arr_contents forKey:@"SQChuChaAdd"];
    [USERDEFAULTS setObject:str_jing_wei forKey:@"SQChuChaAdd_jingwei"];
    [USERDEFAULTS synchronize];
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?1:arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID0";
        FBThree_noimg122TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBThree_noimg122TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.L_left.text =user.username;
        cell.L_right0.text =[NSString stringWithFormat:@"%@-%@",user.department,user.post];
        cell.L_right1.text =[NSString stringWithFormat:@"工号:%@",user.jobNumber];
        return cell;
    }else
    {
        static NSString *cellId=@"cellID1";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==5) {
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
    if (indexPath.row==0 ||indexPath.row==1) {
        //出差开始时间
        picker_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:picker_alert];
        
    }else if (indexPath.row==2)
    {
        //出差时长
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath =indexPath;
        TFvc.delegate =self;
        TFvc.content=arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==3)
    {
        
        //详细地址 （此地址视为打卡地址，如果有偏差，则视为打卡异常）
        FBSearchMapViewController *picker =[[FBSearchMapViewController alloc]init];
        picker.delegate =self;
        [self.navigationController pushViewController:picker animated:NO];
        
    }
   else if(indexPath.row==4)
    {
        //出差原因
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.content =arr_contents[indexPath.row];
        TVvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
        
    }else
    {
        
    }
}
#pragma mark - 自定义的协议代理

-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:address];
    [tableV reloadData];
}
-(void)mapAddress:(NSString *)mapadress location:(CLLocationCoordinate2D)coor2d
{
    str_jing_wei = [NSString stringWithFormat:@"%f,%f",coor2d.latitude,coor2d.longitude];
    [arr_contents replaceObjectAtIndex:3 withObject:mapadress];
    [tableV reloadData];

}

-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
}
@end
