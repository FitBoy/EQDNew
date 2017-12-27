//
//  BC_addViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BC_addViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBButton.h"
#import "DatePicer_AlertView.h"
#import "FBindexpathLongPressGestureRecognizer.h"
@interface BC_addViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_times;
    NSMutableArray *arr_contents;
    NSMutableArray *arr_time_contens;
    UserModel *user;
    DatePicer_AlertView *alert_view;
}

@end

@implementation BC_addViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"班次设置";
    arr_names =[NSMutableArray arrayWithArray:@[@"班次名称",@"+添加时间段"]];
    
    arr_contents =[NSMutableArray arrayWithArray:@[@"请输入",@""]];
    
    NSString *name =[USERDEFAULTS objectForKey:@"BC_name"];
    if (name) {
        [arr_contents replaceObjectAtIndex:0 withObject:name];
    }
    arr_times =[NSMutableArray arrayWithArray:@[@"上班时间",@"下班时间"]];
    NSArray *tarr = [USERDEFAULTS objectForKey:@"BC_add"];
    arr_time_contens=tarr.count==0?[NSMutableArray arrayWithArray:@[@"请选择",@"请选择"]]:[NSMutableArray arrayWithArray:tarr];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(baocunClick)];
    [self.navigationItem setRightBarButtonItem:right];
   
    alert_view =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    alert_view.picker.datePickerMode =UIDatePickerModeTime;
    
    [alert_view.two_btn.B_left addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [alert_view.two_btn.B_right addTarget:self action:@selector(qudingCick:) forControlEvents:UIControlEventTouchUpInside];

}
#pragma  mark - 时间的确定
-(void)qudingCick:(FBButton*)tbtn
{
    NSMutableArray *tarr =[NSMutableArray arrayWithArray:arr_time_contens[tbtn.indexpath.section-1]];
    NSDateFormatter *formator =[[NSDateFormatter alloc]init];
    [formator setDateFormat:@"HH:mm"];
    NSString *date_str =[formator stringFromDate:alert_view.picker.date];
    [tarr replaceObjectAtIndex:tbtn.indexpath.row withObject:date_str];
    [arr_time_contens replaceObjectAtIndex:tbtn.indexpath.section-1 withObject:tarr];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:tbtn.indexpath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [alert_view removeFromSuperview];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  section==arr_time_contens.count?40:1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1+arr_time_contens.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
    {
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
        cell.accessoryType=indexPath.row==0?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_right0.text=arr_contents[indexPath.row];
    return cell;
    }else
    {
        static NSString *cellId=@"cellID1";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        FBindexpathLongPressGestureRecognizer *longprss =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longprss.indexPath=indexPath;
        [cell addGestureRecognizer:longprss];
        
        NSArray *tarr2 =arr_time_contens[indexPath.section-1];
        cell.L_left0.text =arr_times[indexPath.row];
        cell.L_right0.text=tarr2[indexPath.row];
        return cell;
    }
}
#pragma  mark - 长按cell
-(void)longPress:(FBindexpathLongPressGestureRecognizer*)longpress
{
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (arr_time_contens.count>1) {
            [arr_time_contens removeObjectAtIndex:longpress.indexPath.section-1];
            [tableV reloadData];

        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"至少一个时间段，不能删除";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
    
    }

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==arr_time_contens.count) {
        FBButton *tbtn =[FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn setTitle:@"保存" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:24]];
        [tbtn addTarget:self action:@selector(baocunClick) forControlEvents:UIControlEventTouchUpInside];
        return tbtn;

       
    }
    else
    {
       return nil;
    }
}
-(void)baocunClick
{
    
    if (![arr_contents[0] isEqualToString:@"请输入"] &&arr_time_contens.count>0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在保存";
        //保存
        [WebRequest Add_ShiftWithuserGuid:user.Guid companyId:user.companyId shiftName:arr_contents[0] Arr:arr_time_contens And:^(NSDictionary *dic) {
            [arr_time_contens removeAllObjects];
            [USERDEFAULTS removeObjectForKey:@"BC_add"];
            [USERDEFAULTS removeObjectForKey:@"BC_name"];
            [USERDEFAULTS synchronize];
            hud.label.text =@"保存成功";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
    }
    else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"名称或时间段有误";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate=self;
            TFvc.indexPath=indexPath;
            TFvc.contentTitle =arr_names[indexPath.row];
            TFvc.content=arr_contents[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }
        else
        {
            //添加时间段
            if (arr_time_contens.count>3) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"最多只能添加4个时间段";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            else
            {
                 NSArray *tarr2 =@[@"请选择",@"请选择"];
                [arr_time_contens addObject:tarr2];
                [tableV reloadData];
            }
        }
    }
    else
    {
        if (indexPath.row==0) {
          [alert_view setDate2:@"09:00"];
        }
        else
        {
           [alert_view setDate2:@"18:00"];
        }
        
        alert_view.two_btn.B_right.indexpath=indexPath;
        [self.view addSubview:alert_view];
    
    }
}
-(void)quxiaoClick
{
    [alert_view removeFromSuperview];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        [arr_time_contens removeObjectAtIndex:indexPath.section-1];
        [tableV reloadData];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


#pragma  mark - 自定义的 输入的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (arr_time_contens.count) {
        [USERDEFAULTS setObject:arr_time_contens forKey:@"BC_add"];
        [USERDEFAULTS setObject:arr_contents[0] forKey:@"BC_name"];
        [USERDEFAULTS synchronize];
    }
    [super viewWillDisappear:animated];
    
}



@end
