//
//  SQQingJiaAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQQingJiaAddViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "DatePicer_AlertView.h"
#import "NSString+FBString.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBOptionViewController.h"
@interface SQQingJiaAddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,FBOptionViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView *alert_view;
    NSArray *arr_weeks;
    UIImage *image_other;
    BOOL  canTijiao;
}

@end

@implementation SQQingJiaAddViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    image_other =[USERDEFAULTS objectForKey:@"SQQingJiaAdd_img"];
    self.navigationItem.title =[NSString stringWithFormat:@"%@请假申请单",user.company];
    
    arr_names = [NSMutableArray arrayWithArray:@[@"姓名",@"工号",@"部门",@"职位",@"请假开始时间",@"请假结束时间",@"请假天数(天)",@"请假类型",@"请假原因",@"审核人"]];
    

    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];

    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    alert_view =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    [alert_view.two_btn.B_left addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [alert_view.two_btn.B_right addTarget:self action:@selector(quedingClick:) forControlEvents:UIControlEventTouchUpInside];
  NSArray *tarr = [USERDEFAULTS objectForKey:@"SQQingJiaAdd"];
    if (tarr==nil) {
        [WebRequest Get_User_LeaderWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
          
            arr_contents =[NSMutableArray arrayWithArray:@[user.username,user.jobNumber,user.department,user.post,@"请选择",@"请选择",@"请输入",@"请选择",@"请输入"]];
            if([dic[Y_STATUS] integerValue]==200)
            {
                NSString *tstr = dic[Y_ITEMS];
                if (tstr.length!=0) {
                    canTijiao = YES;
                    [arr_contents addObject:dic[Y_ITEMS]];
                }else
            {
                canTijiao =NO;
                  [arr_contents addObject:@"无审批人，请联系管理员"];
            }
            }
            
            [tableV reloadData];
        }];
    }
    else
    {
        arr_contents =[NSMutableArray arrayWithArray:tarr];
        
    }
    
   
 ///排班的工作日
    [WebRequest Get_User_ShiftWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            NSString *tstr =dic2[@"weeks"];
            arr_weeks =[tstr componentsSeparatedByString:@","];
        }
    }];
}
#pragma  mark - 确定 取消
-(void)quxiaoClick
{
    [alert_view removeFromSuperview];
}
-(void)quedingClick:(FBButton*)tbtn
{
    NSDateFormatter *formattor =[[NSDateFormatter alloc]init];
    [formattor setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str =[formattor stringFromDate:alert_view.picker.date];
    [arr_contents replaceObjectAtIndex:tbtn.indexpath.row withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[tbtn.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [alert_view removeFromSuperview];
    
    if (![arr_contents[4] isEqualToString:@"请选择"]&&![arr_contents[5] isEqualToString:@"请选择"]) {
        NSDate *date1 =[formattor dateFromString:arr_contents[4]];
        NSDate *date2 =[formattor dateFromString:arr_contents[5]];
        
     float  day = [NSString day_numberWithdate1:date1 date2:date2 Withweeks:arr_weeks];
        [arr_contents replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%.1f",day]];
        [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    
}
-(void)backClick
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否保存填写过的信息" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [USERDEFAULTS setObject:arr_contents forKey:@"SQQingJiaAdd"];
        [USERDEFAULTS setObject:image_other forKey:@"SQQingJiaAdd_img"];
        [USERDEFAULTS synchronize];
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];

    });
    
    
}
-(void)tijiaoClick
{
    [USERDEFAULTS removeObjectForKey:@"SQQingJiaAdd"];
    NSInteger flag=0;
    for (NSString *str in arr_contents) {
        if ([str isEqualToString:@"请输入"]|| [str isEqualToString:@"请选择"]) {
            flag=1;
            break;
        }
    }
    
    if (flag ==0 && canTijiao==YES) {
        ////@"0姓名",@"1工号",@"2部门",@"3职位",@"4请假开始时间",@5"请假结束时间",@6"请假天数",@"7请假类型",@"8请假原因",@"9审核人"
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Add_LeaveWithuserGuid:user.Guid companyId:user.companyId leadvStartTime:arr_contents[4] leaveEndTime:arr_contents[5] leaveTime:arr_contents[6] leaveType:arr_contents[7] leaveReason:arr_contents[8] img:image_other And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                [USERDEFAULTS removeObjectForKey:@"SQQingJiaAdd_img"];
                [USERDEFAULTS removeObjectForKey:@"SQQingJiaAdd"];
                [USERDEFAULTS synchronize];
                hud.label.text =@"提交成功";
            }
            else
            {
                hud.label.text =@"未知错误";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"您暂时不能提交申请";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.row>3 &&indexPath.row<9) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.L_left0.text =arr_names[indexPath.row];
    cell.L_right0.text =arr_contents[indexPath.row];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==4||indexPath.row==5)
    {
        //选择请假时间
        alert_view.picker.datePickerMode =UIDatePickerModeDateAndTime;
        
        alert_view.two_btn.B_right.indexpath=indexPath;
         [self.view addSubview:alert_view];
        
    }
    else if(indexPath.row==7)
    {
        //选择请假类型
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.delegate =self;
        Ovc.contentTitle =arr_names[indexPath.row];
        Ovc.option =33;
        [self.navigationController pushViewController:Ovc animated:NO];
    }
    
    else if(indexPath.row==8)
    {
        //输入请假原因
        FBTextVViewController  *TVvc =[[FBTextVViewController alloc]init];
        TVvc.delegate =self;
        TVvc.content =arr_contents[indexPath.row];
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.indexpath =indexPath;
        [self.navigationController pushViewController:TVvc animated:NO];
        
    }
    else if(indexPath.row==6)
    {
        //请假天数
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.contentTitle =arr_names[indexPath.row];
        TFvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }
    else
    {
        
    }
}
#pragma mark - 自定义的协议代理
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    if ([option isEqualToString:@"婚假"] || [option isEqualToString:@"工伤假"]) {
        
        UIAlertController  *alert =[UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"请上传与%@相关的证明照片",option] preferredStyle:UIAlertControllerStyleActionSheet];
        UIImagePickerController *picker =[[UIImagePickerController alloc]init];
        picker.delegate =self;
        picker.allowsEditing=YES;
        [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:picker animated:NO completion:nil];

                });
            }
            else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"请到设置->隐私-> 照片修改权限";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType =UIImagePickerControllerSourceTypeCamera;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:picker animated:NO completion:nil];

                });
            }
            else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"请到设置->隐私-> 相机修改权限";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
        }]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];

        });
        
    }
   
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    image_other =[info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:NO completion:^{
       [self.navigationController popViewControllerAnimated:NO];
    }];
    
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [USERDEFAULTS setObject:arr_contents forKey:@"SQQingJiaAdd"];
//    [USERDEFAULTS synchronize];
}
@end
