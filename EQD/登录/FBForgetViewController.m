//
//  FBForgetViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBForgetViewController.h"
#import "FBTextField.h"
#import "UITextField+Tool.h"
#import "FBButton.h"
#import <RongIMKit/RongIMKit.h>
@interface FBForgetViewController ()
{
    UITextField *TF_new;
    UITextField *TF_re;
    FBTextField *TF_phone;
    FBTextField *TF_code;
    FBButton *B_yanZ;
    NSString  *messageId;
    dispatch_source_t  timer;
}

@end

@implementation FBForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    TF_new = [[UITextField alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    TF_new.placeholder = @"请输入新密码";
    TF_new.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:TF_new];
    TF_new.secureTextEntry = YES;
    TF_new.borderStyle= UITextBorderStyleRoundedRect;
    [TF_new becomeFirstResponder];
    TF_re = [[UITextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(TF_new.frame)+10, DEVICE_WIDTH-30, 45)];
    TF_re.placeholder = @"请再次输入密码";
    TF_re.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:TF_re];
    TF_re.secureTextEntry = YES;
    TF_re.borderStyle= UITextBorderStyleRoundedRect;
    
    TF_phone = [[FBTextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(TF_re.frame)+10, DEVICE_WIDTH-30-85, 45)];
    TF_phone.placeholder =@"请输入手机号";
    TF_phone.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:TF_phone];
    
    B_yanZ  =[FBButton buttonWithType:UIButtonTypeSystem];
    [B_yanZ setTitle:@"获取验证码" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:15]];
    B_yanZ.frame = CGRectMake(CGRectGetMaxX(TF_phone.frame)+5, CGRectGetMidY(TF_phone.frame)-15, 85, 30);
    [B_yanZ addTarget:self action:@selector(yanzhengClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:B_yanZ];
    
    TF_code =[[FBTextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(TF_phone.frame)+10, DEVICE_WIDTH-30, 45)];
    TF_code.placeholder =@"请输入验证码";
    [self.view addSubview:TF_code];
    
    
    
    [TF_new setTextFieldInputAccessoryView];
    [TF_re setTextFieldInputAccessoryView];
    [TF_phone setTextFieldInputAccessoryView];
    [TF_code setTextFieldInputAccessoryView];
    
    UIButton *tbtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:tbtn];
    tbtn.frame = CGRectMake(15, CGRectGetMaxY(TF_code.frame)+30, DEVICE_WIDTH-30, 45);
    tbtn.layer.masksToBounds =YES;
    tbtn.layer.cornerRadius =6;
    [tbtn setBackgroundColor:YQDCOLOR];
    [tbtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [tbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tbtn addTarget:self action:@selector(tbtnClcik) forControlEvents:UIControlEventTouchUpInside];
    tbtn.titleLabel.font = [UIFont  systemFontOfSize:27];
    messageId =@"0";
    
}
-(void)yanzhengClick
{
     if([RCKitUtility validateCellPhoneNumber:TF_phone.text]){
         [WebRequest jsms_JSendMessagesWithtel:TF_phone.text And:^(NSDictionary *dic) {
             if([dic[Y_STATUS] integerValue]==200)
             {
                 NSDictionary *dic1 =dic[@"msg"];
                 messageId =dic1[@"msg_id"];
                 
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
                             B_yanZ.enabled=NO;
                             [B_yanZ setTitle:[NSString stringWithFormat:@"倒计时(%lds)",(long)total] forState:UIControlStateNormal];
                             [B_yanZ setBackgroundColor:[UIColor lightGrayColor]];
                             total = total-1;
                             
                         });
                         
                     }
                 });
                 dispatch_source_set_cancel_handler(timer, ^{
                     NSLog(@"Cancel Handler");
                     dispatch_async(mainQueue, ^{
                     [B_yanZ setTitle:@"获取验证码" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:15]];
                     });
                     
                 });
                 dispatch_resume(timer);
                 
             }else
             {
                 MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                 hud.mode = MBProgressHUDModeText;
                 hud.label.text =@"请联系易企点";
                 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                 dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                     [MBProgressHUD hideHUDForView:self.view  animated:YES];
                 });
             }
             
         }];
         
     }else{
         MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
         hud.mode = MBProgressHUDModeText;
         hud.label.text =@"手机号格式不正确";
         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC);
         dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
             [MBProgressHUD hideHUDForView:self.view  animated:YES];
         });
     }
    
}
-(void)tbtnClcik{
    [self.view endEditing:YES];
    NSLog(@"确认提交");
    if (![TF_new.text isEqualToString:TF_re.text]) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"两次密码不一致"];
    }
    else
    {
        if([RCKitUtility validateCellPhoneNumber:TF_phone.text] && TF_code.text.length >0)
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在处理";
            [WebRequest userashx_RetrievalPwdWithtel:TF_phone.text code:TF_code.text msgid:messageId password:TF_new.text And:^(NSDictionary *dic) {
                if([dic[Y_STATUS] integerValue] ==200)
                {
                    hud.label.text = @"新密码设置成功";
                }else{
                    hud.label.text=@"验证码有误，请重试";
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }];
            
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"验证码错误";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (timer) {
        dispatch_source_cancel(timer);
    }
}

@end
