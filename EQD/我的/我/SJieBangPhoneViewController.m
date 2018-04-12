//
//  SJieBangPhoneViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SJieBangPhoneViewController.h"
#import "FBOne_TextFieldTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
@interface SJieBangPhoneViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UserModel *user;
    UITableView *tableV;
    NSMutableArray *arr_jiebang;
    NSMutableArray *arr_contents;
}

@end

@implementation SJieBangPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"解绑手机";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    arr_jiebang =[NSMutableArray arrayWithArray:@[@"原手机",@"登录密码",@"新手机号",@"再次确认"]];
    arr_contents =[NSMutableArray arrayWithArray:@[user.uname,@"请输入登录密码",@"新手机号",@"重新输入新手机号"]];

}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_jiebang.count:1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        FBOne_TextFieldTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBOne_TextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        cell.L_name.text=arr_jiebang[indexPath.row];
        cell.TF_contents.placeholder=arr_contents[indexPath.row];
        cell.TF_contents.indexPath=indexPath;
        cell.TF_contents.delegate=self;
        cell.TF_contents.returnKeyType=UIReturnKeyDone;
        
        if (indexPath.row==0) {
            cell.TF_contents.text = user.uname;
            cell.TF_contents.enabled=NO;
        }
        else
        {
            cell.TF_contents.enabled=YES;
        }
        if (indexPath.row==1) {
            cell.TF_contents.secureTextEntry=YES;
        }
        else
        {
            cell.TF_contents.secureTextEntry=NO;
        }
        return cell;
    }
    else
    {
        UITableViewCell *cell =[[UITableViewCell alloc]init];
        cell.textLabel.text =@"解绑";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    return 10;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - 输入框的协议代理

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        [self.view endEditing:YES];
        
        if ([arr_contents[2] isEqualToString:arr_contents[3]]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在解绑";
            //解绑
            [WebRequest userashx_Update_loginphonenoWithuserGuid:user.Guid password:arr_contents[1] uname:arr_contents[2] And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    hud.label.text = @"解绑成功";
                }else
                {
                    hud.label.text = @"手机或密码有误";
                }
              
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
            }];

        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"两次输入的手机不一致";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
        
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    FBindexPathTextField *textF =(FBindexPathTextField*)textField;
    if (textF.indexPath.row==2 || textF.indexPath.row==3) {
       if( [RCKitUtility validateCellPhoneNumber:textF.text])
       {
           [arr_contents replaceObjectAtIndex:textF.indexPath.row withObject:textF.text];

       }
        else
        {
            MBFadeAlertView *alert =[[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"手机格式不正确"];
        }
    }
    
    else
    {
        [arr_contents replaceObjectAtIndex:textF.indexPath.row withObject:textF.text];
    }
    }


@end
