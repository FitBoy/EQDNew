//
//  EQDLoginViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDLoginViewController.h"
#import "LYangZhengViewController.h"
#import "NSString+FBString.h"
#import "LEmailViewController.h"
#import "LIDCardViewController.h"
#import <RongIMKit/RCKitUtility.h>
#import "MyAboutUsViewController.h"
#import "LTrueNameViewController.h"
#import <JPUSHService.h>
#import "FBButton.h"
#import "LQiYeQianViewController.h"
#import "NSString+FBString.h"
#import "FBForgetViewController.h"
#import "UITextField+Tool.h"
@interface EQDLoginViewController ()<UITextFieldDelegate>
{
    UITextField *TF_zhanghao;
    UITextField *TF_mima;
    UIButton *tbtn_login;
    FBButton *B_renshi;
    FBButton *B_qiye;
}

@end

@implementation EQDLoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    tbtn_login.enabled =YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [JPUSHService  cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:2017];
    
   
    self.navigationItem.title =@"登录";
    UIButton *tbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    tbtn.frame = CGRectMake((DEVICE_WIDTH-210)/2.0, DEVICE_TABBAR_Height+5, 210, 70);
    [tbtn setBackgroundImage:[UIImage imageNamed:@"yiqidian"] forState:UIControlStateNormal];
    [self.view addSubview:tbtn];
    [tbtn addTarget:self action:@selector(aboutUsClick) forControlEvents:UIControlEventTouchUpInside];
    
    TF_zhanghao = [[UITextField alloc]initWithFrame:CGRectMake(15, 150-65+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    [self.view addSubview:TF_zhanghao];
    TF_zhanghao.placeholder= @"请输入手机号/易企点号";
    TF_zhanghao.borderStyle= UITextBorderStyleRoundedRect;
    TF_zhanghao.clearButtonMode = UITextFieldViewModeAlways;
    TF_zhanghao.delegate=self;
    [TF_zhanghao setTextFieldInputAccessoryView];
    NSString *tstr =[USERDEFAULTS objectForKey:Y_zhanghao];
    if (tstr!=nil) {
        TF_zhanghao.text =tstr;
    }else
    {
    }
    
    TF_mima = [[UITextField alloc]initWithFrame:CGRectMake(15, 150+50-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    TF_mima.placeholder= @"请输入密码";
    TF_mima.borderStyle= UITextBorderStyleRoundedRect;
    TF_mima.clearButtonMode = UITextFieldViewModeAlways;
    TF_mima.secureTextEntry=YES;
    [self.view addSubview:TF_mima];
    [TF_mima setTextFieldInputAccessoryView];
  tbtn_login =[UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:tbtn_login];
    tbtn_login.frame = CGRectMake(15, 270-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45);
    [tbtn_login setBackgroundColor:EQDCOLOR];
    [tbtn_login setTitle:@"登录" forState:UIControlStateNormal];
    [tbtn_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tbtn_login.titleLabel.font = [UIFont systemFontOfSize:27];
    [tbtn_login addTarget:self action:@selector(logingCLick) forControlEvents:UIControlEventTouchUpInside];
    tbtn_login.layer.masksToBounds = YES;
    tbtn_login.layer.cornerRadius = 6;
    
    tbtn_login.enabled =YES;
    
   
    
    
    UIButton *tbtn_zhuce = [UIButton buttonWithType:UIButtonTypeSystem];
    tbtn_zhuce.frame = CGRectMake(15, 330-64+DEVICE_TABBAR_Height, 80, 20);
    [tbtn_zhuce setTitle:@"个人注册" forState:UIControlStateNormal];
    [self.view addSubview:tbtn_zhuce];
    [tbtn_zhuce addTarget:self action:@selector(zhuceClick) forControlEvents:UIControlEventTouchUpInside];
    tbtn_zhuce.titleLabel.font = [UIFont systemFontOfSize:17];
    
    
    B_qiye =[FBButton buttonWithType:UIButtonTypeSystem];
    [B_qiye setTitle:@"企业注册" titleColor:nil backgroundColor:nil font:nil];
    [self.view addSubview:B_qiye];
    B_qiye.frame =CGRectMake(DEVICE_WIDTH-95, 330-64+DEVICE_TABBAR_Height, 80, 20);
    [B_qiye addTarget:self action:@selector(qiyezhuceClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *tbtn_findMima = [UIButton buttonWithType:UIButtonTypeSystem];
    tbtn_findMima.frame = CGRectMake((DEVICE_WIDTH-80)/2.0, DEVICE_HEIGHT-40-kBottomSafeHeight, 80, 20);
    [tbtn_findMima setTitle:@"找回密码" forState:UIControlStateNormal];
    [self.view addSubview:tbtn_findMima];
    [tbtn_findMima addTarget:self action:@selector(findMimaCLick) forControlEvents:UIControlEventTouchUpInside];
    tbtn_findMima.titleLabel.font =[UIFont systemFontOfSize:17];
    
    [TF_zhanghao becomeFirstResponder];
    
    
    
}
-(void)qiyezhuceClick
{
    //企业注册
    LQiYeQianViewController *Rvc =[[LQiYeQianViewController alloc]init];
    [self.navigationController pushViewController:Rvc animated:NO];
}


-(void)findMimaCLick{
    NSLog(@"找回密码");
        FBForgetViewController  *YZvc =[[FBForgetViewController alloc]init];
        [self.navigationController pushViewController:YZvc animated:NO];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField ==TF_zhanghao) {
        
       if( [RCKitUtility validateCellPhoneNumber:textField.text])
       {
           tbtn_login.enabled =YES;
           [tbtn_login setTitle:@"手机号登录" forState:UIControlStateNormal];
           
        }
        else if ([TF_zhanghao.text zhanghaoJudge]==NO)
        {
            ///对于新手机号 可能判断不准确
            tbtn_login.enabled =YES;
           /* MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });*/
        }
        else
        {
            tbtn_login.enabled =YES;
           [tbtn_login setTitle:@"易企点号登录" forState:UIControlStateNormal];
        }

    }
    
    }
-(void)zhuceClick{
   NSLog(@"注册");
    [self.view endEditing:YES];
    LYangZhengViewController *YZvc =[[LYangZhengViewController alloc]init];
    [self.navigationController pushViewController:YZvc animated:NO];
    
}
-(void)aboutUsClick{
    NSLog(@"关于我们");
    [self.view endEditing:YES];
    MyAboutUsViewController *MAvc =[[MyAboutUsViewController alloc]init];
    [self.navigationController pushViewController:MAvc animated:NO];
}

-(void)logingCLick{
    NSLog(@"登录");
    tbtn_login.enabled =NO;
    [self.view endEditing:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"正在登录";
       [WebRequest user_enterWithu1:TF_zhanghao.text u2:TF_mima.text And:^(NSDictionary *dic) {
           tbtn_login.enabled =YES;
           NSDictionary *items = dic[Y_ITEMS];
           NSString *msg = dic[@"msg"];
           hud.label.text =msg;
           NSNumber *number = dic[@"status"];
           if ([number integerValue]==200) {
               [JPUSHService setAlias:items[@"Guid"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                   NSLog(@"iResCode==%ld=iAlias==%@ seq==%ld",(long)iResCode,iAlias,(long)seq);
               } seq:2017];
               [USERDEFAULTS setObject:TF_mima.text forKey:Y_MIMA];
               [USERDEFAULTS setObject:TF_zhanghao.text forKey:Y_zhanghao];
               [USERDEFAULTS setObject:items forKey:Y_USERINFO];
               [USERDEFAULTS synchronize];
               if ([items[@"authen"] integerValue]==0) {
                   UIAlertController *alert =[[UIAlertController alloc]init];
                   [alert addAction:[UIAlertAction actionWithTitle:@"个人实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                       LTrueNameViewController *Tvc =[[LTrueNameViewController alloc]init];
                       Tvc.isFirst =1;
                       [self.navigationController pushViewController:Tvc animated:NO];
                       
                   }]];
                   [alert addAction:[UIAlertAction actionWithTitle:@"游客" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [self mainJiemian];
                   }]];
                   [self presentViewController:alert animated:NO completion:nil];
               }
               else{
               
               dispatch_async(dispatch_get_main_queue(), ^{
                   [self mainJiemian];
               });
               }
           }
           
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [hud hideAnimated:NO];
           });
           
       }];
    
   

}



@end
