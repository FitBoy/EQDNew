//
//  LQiYeQianViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LQiYeQianViewController.h"
#import "FBTextField.h"
#import "FBButton.h"
#import "GSRegisterViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "FBButton.h"
@interface LQiYeQianViewController ()<UITextFieldDelegate>
{
    FBTextField *TF_phone;
    FBButton *B_next;
    FBTextField *TF_yanzhengma;
    FBButton *B_yanzheng;
    NSString *messageId;
    dispatch_source_t  timer;
}

@end

@implementation LQiYeQianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"企业注册前验证手机号";
    self.navigationController.navigationBarHidden=NO;
    
    UILabel *tlabel =[[UILabel alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 20)];
    [self.view addSubview:tlabel];
    tlabel.textColor =[UIColor redColor];
    tlabel.font =[UIFont systemFontOfSize:12];
    tlabel.text = @"*企业注册*前必须验证手机号是否在易企点实名认证";
    
    TF_phone =[[FBTextField alloc]initWithFrame:CGRectMake(15, 90+DEVICE_TABBAR_Height-64, DEVICE_WIDTH-30, 40)];
    [self.view addSubview:TF_phone];
    TF_phone.placeholder =@"请输入手机号";
    [TF_phone becomeFirstResponder];
    
    TF_yanzhengma =[[FBTextField alloc]initWithFrame:CGRectMake(15, 135-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-140, 40)];
    [self.view addSubview:TF_yanzhengma];
    TF_yanzhengma.placeholder =@"请输入验证码";
    
    B_yanzheng =[FBButton buttonWithType:UIButtonTypeSystem];
    [B_yanzheng setTitle:@"获取验证码" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:17]];
    [self.view addSubview:B_yanzheng];
    B_yanzheng.frame = CGRectMake(DEVICE_WIDTH-115, 140, 100, 30);
    [B_yanzheng addTarget:self action:@selector(fasongyanzhengClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    B_next =[FBButton buttonWithType:UIButtonTypeSystem];
    [B_next setTitle:@"下一步" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:24]];
    B_next.frame = CGRectMake(15, 190-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45);
    [B_next addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:B_next];
    
    messageId =@"0";
}
-(void)fasongyanzhengClick
{
    //发送验证码
//   if([RCKitUtility validateCellPhoneNumber:TF_phone.text])
//   {
       [WebRequest jsms_JSendMessagesWithtel:TF_phone.text  And:^(NSDictionary *dic) {
           NSString *tstr =dic[Y_MSG];
           NSData *data = [tstr dataUsingEncoding:NSUTF8StringEncoding];
           NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
           messageId = dic1[@"msg_id"];
       }];
       
       dispatch_async(dispatch_get_main_queue(), ^{
           __block  NSInteger  total = 60;
           //全局并发队列
           dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
           //主队列；属于串行队列
           dispatch_queue_t mainQueue = dispatch_get_main_queue();
           //定时循环执行事件
             timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
           dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
           dispatch_source_set_event_handler(timer, ^{
               if(total<=0){
                   dispatch_source_cancel(timer);
               }
               else{
                   dispatch_async(mainQueue, ^{
                       B_yanzheng.enabled=NO;
                       [B_yanzheng setTitle:[NSString stringWithFormat:@"倒计时(%lds)",(long)total] forState:UIControlStateNormal];
                       [B_yanzheng setBackgroundColor:[UIColor lightGrayColor]];
                       total = total-1;
                       
                   });
                   
               }
           });
           dispatch_source_set_cancel_handler(timer, ^{
               NSLog(@"Cancel Handler");
               dispatch_async(mainQueue, ^{
                   [B_yanzheng setTitle:@"获取验证码" forState:UIControlStateNormal];
                   [B_yanzheng setBackgroundColor:EQDCOLOR];
                   B_yanzheng.enabled=YES;
               });
               
           });
           dispatch_resume(timer);
           
       });
   
  /* }
   else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"手机号格式错误";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    */
}
-(void)nextClick
{
    //下一步
     [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在验证手机号";
//    if ([RCKitUtility validateCellPhoneNumber:TF_phone.text]) {
        [WebRequest jsms_ValidcodeWithmsgid:messageId code:TF_yanzhengma.text And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==200)
            {
            
            [WebRequest User_JudgeExistWithuid:TF_phone.text And:^(NSDictionary *dic) {
                [hud hideAnimated:NO];
                NSNumber *number =dic[Y_STATUS];
                NSString *msg =dic[Y_MSG];
                if ([number integerValue]==200) {
                    [USERDEFAULTS setObject:dic[Y_ITEMS] forKey:Y_USERINFO];
                    [USERDEFAULTS synchronize];
                    
                    GSRegisterViewController *Rvc =[[GSRegisterViewController alloc]init];
                    Rvc.phonenumber = TF_phone.text;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController pushViewController:Rvc animated:NO];
                    });
                    
                }
                else
                {
                    hud.label.text =msg;
                }
        }];
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"验证码错误，请重试";
            }
        }];
//    }
//else
//{
//    hud.label.text =@"你的手机格式不正确";
//}
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [hud hideAnimated:NO];
    });
   
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (timer) {
        dispatch_source_cancel(timer);
    }
}



@end
