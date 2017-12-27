//
//  WorkExprience_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "WorkExprience_AddViewController.h"
#import "FBTextVViewController.h"
#import "FBTextFieldViewController.h"
#import "FBOptionViewController.h"
#import "DatePicer_AlertView.h"
#import "FBHangYeViewController.h"
@interface WorkExprience_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FBOptionViewControllerDelegate,FBHangYeViewControllerDelegate>
{
    NSMutableArray *arr_names;
    UITableView *tableV;
    NSMutableArray *arr_contents;
    DatePicer_AlertView *date_alert;
    NSString *isOn;
    UserModel *user;
    NSString *hangye_code;
}

@end

@implementation WorkExprience_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    arr_names =[NSMutableArray arrayWithArray:@[@"企业名称",@"企业规模",@"企业性质",@"所在部门",@"担任职位",@"薪资范围",@"工作行业",@"工作开始时间",@"工作结束时间",@"工作描述",@"是否公开"]];
    if(self.model==nil)
    {
    arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请选择",@"请输入",@"请输入",@"请选择",@"请选择",@"请选择",@"请选择",@"请输入",@"请选择"]];
        self.navigationItem.title =@"工作经历填写";
    }else
    {
        arr_contents = [NSMutableArray arrayWithArray:@[_model.company,_model.enterpriseScale,_model.enterpriseNature,_model.department,_model.post,_model.monthlySalary,_model.induCategoryName,_model.startTime,_model.endTime,_model.jobDescri,[_model.isOvert integerValue]==0?@"不公开":@"公开" ]];
        self.navigationItem.title= @"工作经历详情";
        right.title =@"保存";
    }
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.maximumDate =[NSDate date];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    isOn =@"1";
}
-(void)tijiaoCLick
{
    NSInteger temp = 0;
    for(int i=0;i<arr_contents.count;i++)
    {
        if([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"青训则"])
        {
            temp =1;
            break;
        }
    }
    if(temp ==0)
    {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
    if(self.model==nil)
    {
    [WebRequest userashx_Add_workExperienceWithuserGuid:user.Guid startTime:arr_contents[7] endTime:arr_contents[8] company:arr_contents[0] induCategoryCode:hangye_code induCategoryName:arr_contents[6] enterpriseNature:arr_contents[2] enterpriseScale:arr_contents[1] monthlySalary:arr_contents[5] department:arr_contents[3] post:arr_contents[4] jobDescri:arr_contents[9] isOvert:isOn And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
            
        });
    }];
    }else
    {
        [WebRequest userashx_Update_workExperienceWithuserGuid:user.Guid workepid:self.model.ID startTime:arr_contents[7] endTime:arr_contents[8] company:arr_contents[0] induCategoryCode:hangye_code==nil?_model.induCategoryCode:hangye_code induCategoryName:arr_contents[6] enterpriseNature:arr_contents[2] enterpriseScale:arr_contents[1] monthlySalary:arr_contents[5] department:arr_contents[3] post:arr_contents[4] jobDescri:arr_contents[9] And:^(NSDictionary *dic) {
             hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
                
            });
        }];
        
    }
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"字段不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
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
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
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
    if(self.model==nil)
    {
        
    }else
    {
        if(indexPath.row==10)
        {
             cell.accessoryType = UITableViewCellAccessoryNone;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   if(indexPath.row==0 || indexPath.row==3 || indexPath.row==4)
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath =indexPath;
        TFvc.delegate =self;
        TFvc.content = arr_contents[indexPath.row];
        TFvc.contentTitle = arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
        
    }else if (indexPath.row==2)
    {
        //企业性质
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.option=6;
        Ovc.delegate =self;
        Ovc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Ovc animated:NO];
    }
    else if (indexPath.row==1)
    {
        //企业规模
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.option=4;
        Ovc.delegate =self;
        Ovc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Ovc animated:NO];
        
    }else if (indexPath.row==6)
    {
        //工作行业
        FBHangYeViewController *HYvc =[[FBHangYeViewController alloc]init];
        HYvc.delegate =self;
        HYvc.indexPath =indexPath;
        [self.navigationController pushViewController:HYvc animated:NO];
        
    }else if (indexPath.row==7 || indexPath.row==8)
    {
        //时间
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
        
    }else if (indexPath.row==9)
    {
        //工作描述
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.delegate =self;
        TVvc.S_maxnum =@"500";
        TVvc.indexpath =indexPath;
        TVvc.contentTitle =arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row==10)
    {
        
        if(self.model==nil)
        {
    //是否公开
        UIAlertController *alert = [[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"公开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            isOn =@"1";
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"不公开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            isOn=@"0";
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
        }else
        {
            
        }
    }else if (indexPath.row==5)
    {
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.option=36;
        Ovc.delegate =self;
        Ovc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Ovc animated:NO];
    }
    
    else
    {
        
    }
}

#pragma  mark - 自定义的协议代理
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)hangye:(NSString *)hangye Withindexpath:(NSIndexPath *)indexpath
{
    NSArray *tarr = [hangye componentsSeparatedByString:@"-"];
    hangye_code =tarr[1];
    [arr_contents replaceObjectAtIndex:indexpath.row withObject:tarr[0]];
    [tableV reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
