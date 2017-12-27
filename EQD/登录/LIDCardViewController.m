//
//  LIDCardViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LIDCardViewController.h"
#import "NSString+FBString.h"
@interface LIDCardViewController ()
{
    UITextField *TF_email;
}

@end

@implementation LIDCardViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份证号找回密码";
    TF_email = [[UITextField alloc]initWithFrame:CGRectMake(15,DEVICE_TABBAR_Height , DEVICE_WIDTH-30, 45)];
    [self.view addSubview:TF_email];
    TF_email.placeholder =@"请输入您实名认证的身份证号";
    TF_email.borderStyle= UITextBorderStyleRoundedRect;
    TF_email.clearButtonMode = UITextFieldViewModeAlways;
    [TF_email becomeFirstResponder];
    UIButton *tbtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:tbtn];
    tbtn.frame = CGRectMake(15, 180-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45);
    tbtn.layer.masksToBounds =YES;
    tbtn.layer.cornerRadius =6;
    [tbtn setBackgroundColor:YQDCOLOR];
    [tbtn setTitle:@"确定" forState:UIControlStateNormal];
    [tbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tbtn addTarget:self action:@selector(tbtnClcik) forControlEvents:UIControlEventTouchUpInside];
    tbtn.titleLabel.font = [UIFont  systemFontOfSize:27];
    
    
}
-(void)tbtnClcik{
    NSLog(@"发送");
    if (![TF_email.text judgeIdentityStringValid]) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"身份证号输入有误"];
    }
    else
    {
        
    }
    
}


@end
