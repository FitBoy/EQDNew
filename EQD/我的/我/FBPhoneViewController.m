//
//  FBPhoneViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBPhoneViewController.h"
#import "WebRequest.h"
#import "FBOne_TextFieldTableViewCell.h"
@interface FBPhoneViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
}

@end

@implementation FBPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"修改密码";
    arr_names=[NSMutableArray arrayWithArray:@[@"原密码:",@"新密码:",@"确认密码:"]];
    arr_contents=[NSMutableArray arrayWithArray:@[@"请输入原密码",@"请输入新密码",@"请再次确认密码"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_names.count:1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        FBOne_TextFieldTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBOne_TextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.L_name.text=arr_names[indexPath.row];
        cell.TF_contents.placeholder=arr_contents[indexPath.row];
        cell.TF_contents.indexPath=indexPath;
        cell.TF_contents.delegate=self;
        cell.TF_contents.returnKeyType=UIReturnKeyDone;
        cell.TF_contents.secureTextEntry=YES;
        return cell;
    }
    else
    {
        UITableViewCell *cell =[[UITableViewCell alloc]init];
        cell.textLabel.text=@"修改";
        cell.textLabel.font=[UIFont systemFontOfSize:18];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        return cell;
    }
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        //修改
        [self.view endEditing:YES];
        if ([arr_contents[1] isEqualToString:arr_contents[2] ]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在修改";
            [WebRequest User_updatePasswordWithuserGuid:user.Guid oldPassword:arr_contents[0] newPasswor:arr_contents[2] And:^(NSDictionary *dic) {
                hud.label.text= dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popToRootViewControllerAnimated:NO];
                });
            }];
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"两次密码不一致";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
    }
    else
    {
        
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
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    FBindexPathTextField *textF =(FBindexPathTextField*)textField;
    [arr_contents replaceObjectAtIndex:textF.indexPath.row withObject:textF.text];
}
@end
