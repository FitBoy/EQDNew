//
//  MimaRegisterViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MimaRegisterViewController.h"
#import "EQDLoginViewController.h"
#import "WebRequest.h"
#import  <YYText.h>
#import "FBWebUrlViewController.h"
@interface MimaRegisterViewController ()
{
    UITextField *TF_mima;
}

@end

@implementation MimaRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.automaticallyAdjustsScrollViewInsets = NO;
    TF_mima =[[UITextField alloc]initWithFrame:CGRectMake(15, 70-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 40)];
    [self.view addSubview:TF_mima];
    TF_mima.borderStyle = UITextBorderStyleRoundedRect;
    TF_mima.placeholder = @"请输入密码";
    TF_mima.secureTextEntry=YES;
    [TF_mima becomeFirstResponder];
    UILabel *tlabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 120-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 30)];
    
    [self.view addSubview:tlabel];
    tlabel.textColor =[UIColor redColor];
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.text = @"密码最少8位数，最多18位数";
    tlabel.font = [UIFont systemFontOfSize:15];
    UIButton *zhuce_B =[UIButton buttonWithType:UIButtonTypeSystem];
    zhuce_B.frame = CGRectMake(15, 170-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 50);
    [self.view addSubview:zhuce_B];
    [zhuce_B setTitle:@"注 册" forState:UIControlStateNormal];
    [zhuce_B setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhuce_B setBackgroundColor:YQDCOLOR];
    zhuce_B.titleLabel.font =[UIFont systemFontOfSize:25];
    [zhuce_B addTarget:self action:@selector(zhuceClcik) forControlEvents:UIControlEventTouchUpInside];
    zhuce_B.layer.masksToBounds = YES;
    zhuce_B.layer.cornerRadius = 6;
    
    
    
    
    
    YYLabel *tlabel1 = [[YYLabel alloc]initWithFrame:CGRectMake(15, 240-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 15)];
    [self.view addSubview:tlabel1];
    
    NSMutableAttributedString  *shuoming = [[NSMutableAttributedString alloc]initWithString:@"注册表示你同意易企点" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    
    NSMutableAttributedString  *xieyi = [[NSMutableAttributedString alloc]initWithString:@"服务使用协议" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [xieyi yy_setTextHighlightRange:xieyi.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //使用协议
        FBWebUrlViewController  *Url = [[FBWebUrlViewController alloc]init];
        Url.url =@"https://www.eqidd.com/html/agreement.html";
        Url.contentTitle =@"服务使用协议";
        [self.navigationController pushViewController:Url animated:NO];
    }];
    
    [shuoming appendAttributedString:xieyi];
    NSAttributedString *sand = [[NSAttributedString alloc]initWithString:@"和" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [shuoming appendAttributedString:sand];
    
    NSMutableAttributedString  *tiaoKuan = [[NSMutableAttributedString alloc]initWithString:@"隐私条款" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [tiaoKuan yy_setTextHighlightRange:tiaoKuan.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //隐私条款
        FBWebUrlViewController  *Url = [[FBWebUrlViewController alloc]init];
        Url.url =@"https://www.eqidd.com/html/PrivacyPolicy.html";
        Url.contentTitle =@"隐私条款";
        [self.navigationController pushViewController:Url animated:NO];
    }];
    [shuoming appendAttributedString:tiaoKuan];
    tlabel1.attributedText =shuoming;
    tlabel1.textAlignment =NSTextAlignmentCenter;
    
    
    
}


-(void)zhuceClcik{
    NSLog(@"注册");
    [self.view endEditing:YES];
    if(TF_mima.text.length>7 && TF_mima.text.length<19)
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在注册";
        
        [WebRequest user_loginWithu1:self.phoneNumber password:TF_mima.text  And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popToRootViewControllerAnimated:NO];
            });
          
        }];
        
       
        
    }
    
    else
    {
        MBFadeAlertView  *alert =[[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"密码最少8位数，最多18位数"];
    }
    
}

@end
