//
//  LEmailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LEmailViewController.h"
#import "NSString+FBString.h"
#import <RongIMKit/RCKitUtility.h>
@interface LEmailViewController ()
{
    UITextField *TF_email;
    UITextField *TF_phone;
}

@end

@implementation LEmailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"邮箱找回密码";
    TF_phone = [[UITextField alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    TF_phone.placeholder = @"请输入以前注册的手机号";
    TF_phone.clearButtonMode = UITextFieldViewModeAlways;
    TF_phone.borderStyle =UITextBorderStyleRoundedRect;
    [self.view addSubview:TF_phone];
    [TF_phone becomeFirstResponder];
    
    TF_email = [[UITextField alloc]initWithFrame:CGRectMake(15, 115-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    [self.view addSubview:TF_email];
    
    TF_email.placeholder =@"请输入实名认证的邮箱";
    TF_email.borderStyle= UITextBorderStyleRoundedRect;
    TF_email.clearButtonMode = UITextFieldViewModeAlways;
    
   
    
    UIButton *tbtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:tbtn];
    tbtn.frame = CGRectMake(15, 180-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45);
    tbtn.layer.masksToBounds =YES;
    tbtn.layer.cornerRadius =6;
    [tbtn setBackgroundColor:YQDCOLOR];
    [tbtn setTitle:@"验证码发邮箱" forState:UIControlStateNormal];
    [tbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tbtn.titleLabel.font = [UIFont  systemFontOfSize:27];
    [tbtn addTarget:self action:@selector(tbtnClcik) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 275-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 30)];
    tlabel.text = @"此功能主要是为了忘记密码但记得账号的，可以通过预留的邮箱找回";
    tlabel.numberOfLines=2;
    tlabel.textColor = [UIColor redColor];
    tlabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:tlabel];
    
}

-(void)tbtnClcik{
    //服务器要返回该邮箱所在的用户名
    
    NSLog(@"发送邮件");
    if (![RCKitUtility validateEmail:TF_email.text] || ![RCKitUtility validateCellPhoneNumber:TF_phone.text]) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"输入的邮箱或手机号不正确"];
    }
    else
    {
        
        FBLoadingEffectView *effectV =[[FBLoadingEffectView alloc]init];
        [self.view addSubview:effectV];
        effectV.L_title.text = @"正在发送";
        
        [WebRequest user_backpassWithtemail:TF_email.text aname:TF_phone.text And:^(NSDictionary *dic) {
            
            
        }];
        
        
    }
}




@end
