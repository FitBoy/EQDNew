//
//  ProjectExproence_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ProjectExproence_AddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "DatePicer_AlertView.h"
@interface ProjectExproence_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    DatePicer_AlertView *date_alert;
    NSString *Iskai;
}

@end

@implementation ProjectExproence_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    user =[WebRequest GetUserInfo];
    arr_names =[NSMutableArray arrayWithArray:@[@"项目名称",@"所在企业",@"项目开始时间",@"项目结束时间",@"项目URL地址",@"项目职责",@"项目描述",@"是否公开"]];
  
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    date_alert.picker.maximumDate = [NSDate date];
    Iskai =@"0";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    if(self.model==nil)
    {
        self.navigationItem.title =@"项目经验填写";
        right.title=@"提交";
          arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请输入",@"请选择",@"请选择",@"请输入",@"请输入",@"请输入",@"请选择"]];
    }else
    {
        self.navigationItem.title =@"项目经验详情";
        right.title=@"保存";
        //@[@"项目名称",@"所在企业",@"项目开始时间",@"项目结束时间",@"项目URL地址",@"项目职责",@"项目描述",@"是否公开"
        arr_contents= [NSMutableArray arrayWithArray:@[_model.projectName,_model.ownedCompany,_model.startTime,_model.endTime,_model.projectURL,_model.duty,_model.projectDescription,[_model.isOvert integerValue]==0?@"不公开":@"公开"]];
    }

}
-(void)tijiaoClick
{
    NSInteger temp =0;
   if([arr_contents containsObject:@"请输入"] || [arr_contents containsObject:@"请选择"] )
    {
        temp=1;
    }
    if(temp ==0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在处理";

        if(self.model==nil)
        {
       
        [WebRequest userashx_Add_projectExperienceWithuserGuid:user.Guid ownedCompany:arr_contents[1] projectName:arr_contents[0] startTime:arr_contents[2] endTime:arr_contents[3] duty:arr_contents[5] projectDescription:arr_contents[6] projectURL:arr_contents[4] isOvert:Iskai And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        }else
        {
            [WebRequest  userashx_Update_projectExperienceWithuserGuid:user.Guid projectepid:self.model.ID ownedCompany:arr_contents[1] projectName:arr_contents[0] startTime:arr_contents[2] endTime:arr_contents[3] duty:arr_contents[5] projectDescription:arr_contents[6] projectURL:arr_contents[4] And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
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
        hud.label.text =@"参数填写不完整";
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
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if(indexPath.row==0 || indexPath.row==1 || indexPath.row==4)
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.contentTitle =arr_names[indexPath.row];
        TFvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
        
    }else if (indexPath.row==2 || indexPath.row==3)
    {
        date_alert.two_btn.B_right.indexpath = indexPath;
        [self.view addSubview:date_alert];
    }else if (indexPath.row==5 || indexPath.row==6)
    {
        FBTextVViewController  *TVvc =[[FBTextVViewController alloc]init];
        TVvc.S_maxnum =indexPath.row==5?@"300":@"500";
        TVvc.delegate =self;
        TVvc.indexpath =indexPath;
        TVvc.contentTitle = arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row==7)
    {
        UIAlertController  *alert =[[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"公开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            Iskai =@"1";
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"不公开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:action.title];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            Iskai =@"0";
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
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
