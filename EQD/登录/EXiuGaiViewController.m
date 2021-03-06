//
//  EXiuGaiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EXiuGaiViewController.h"

@interface EXiuGaiViewController ()
{
    UILabel *L_phone;
    UITextField *TF_mima;
    UITextField *TF_reMima;
    UITextField *TF_yanzhengma;
}

@end

@implementation EXiuGaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    L_phone = [[UILabel alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 40)];
    L_phone.text=[NSString stringWithFormat:@"账号：%@",self.phone];
    [self.view addSubview:L_phone];
    
    TF_mima = [[UITextField alloc]initWithFrame:CGRectMake(15, 105-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    [self.view addSubview:TF_mima];
    TF_mima.placeholder= @"请输入密码";
    TF_mima.borderStyle = UITextBorderStyleRoundedRect;
    TF_mima.secureTextEntry =YES;
    
    
    TF_reMima = [[UITextField alloc]initWithFrame:CGRectMake(15, 150-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    [self.view addSubview:TF_reMima];
    TF_reMima.placeholder= @"请重新输入密码";
    TF_reMima.borderStyle = UITextBorderStyleRoundedRect;
    TF_reMima.secureTextEntry =YES;
    
    
    TF_yanzhengma = [[UITextField alloc]initWithFrame:CGRectMake(15, 200-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    [self.view addSubview:TF_yanzhengma];
    TF_yanzhengma.placeholder= @"请输入邮箱验证码";
    TF_yanzhengma.borderStyle = UITextBorderStyleRoundedRect;
    
    UIButton *tbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    tbtn.frame = CGRectMake(15, 260-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45);
    [self.view addSubview:tbtn];
    tbtn.layer.masksToBounds=YES;
    tbtn.layer.cornerRadius=6;
    [tbtn setTitle:@"确定修改" forState:UIControlStateNormal];
    [tbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tbtn setBackgroundColor:YQDCOLOR];
    [tbtn addTarget:self action:@selector(xiugaiClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)xiugaiClick{
    if ([TF_mima.text isEqualToString:TF_reMima.text]) {
        FBLoadingEffectView *effectV =[[FBLoadingEffectView alloc]init];
        [self.view addSubview:effectV];
        effectV.L_title.text =@"正在修改";
        
    }
    else
    {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"两次密码不一致"];
    }
}


@end
