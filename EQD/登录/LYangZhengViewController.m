//
//  LYangZhengViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#import "LYangZhengViewController.h"
#import "NSString+FBString.h"
#import "MimaRegisterViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface LYangZhengViewController ()<UITextFieldDelegate>
{
    UITextField *TF_phone;
    UITextField *TF_yanzhengma;
    UIButton *yanzhengmaBtn;
    UILabel *L_tishi;
    UIButton *nextbtn;
    NSString *messageId;
    dispatch_source_t  timer;
}

@end

@implementation LYangZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    TF_phone = [[UITextField alloc]initWithFrame:CGRectMake(15, 70-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-130, 45)];
    [self.view addSubview:TF_phone];
    TF_phone.placeholder= @"请输入手机号";
    TF_phone.borderStyle= UITextBorderStyleRoundedRect;
    TF_phone.clearButtonMode = UITextFieldViewModeAlways;
    TF_phone.delegate =self;
    [TF_phone becomeFirstResponder];
    
    TF_yanzhengma = [[UITextField alloc]initWithFrame:CGRectMake(15, 120-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    TF_yanzhengma.placeholder= @"请输入验证码";
    TF_yanzhengma.borderStyle= UITextBorderStyleRoundedRect;
    TF_yanzhengma.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:TF_yanzhengma];
    
    nextbtn  =[UIButton buttonWithType:UIButtonTypeSystem];
    [nextbtn setBackgroundColor:YQDCOLOR];
    [nextbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextbtn setTintColor:[UIColor whiteColor]];
    nextbtn.frame = CGRectMake(15, 210-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 50);
    nextbtn.layer.masksToBounds=YES;
    nextbtn.layer.cornerRadius =5;
    [self.view addSubview:nextbtn];
    nextbtn.titleLabel.font=[UIFont systemFontOfSize:30];
    [nextbtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    nextbtn.enabled=NO;
    
    yanzhengmaBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    yanzhengmaBtn.frame = CGRectMake(DEVICE_WIDTH-100, 10+70-64+DEVICE_TABBAR_Height, 83, 31);
    [yanzhengmaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [yanzhengmaBtn setBackgroundColor:YQDCOLOR];
    [yanzhengmaBtn addTarget:self action:@selector(fasongyanClick) forControlEvents:UIControlEventTouchUpInside];
    yanzhengmaBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [yanzhengmaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:yanzhengmaBtn];
    
    //提示框
    L_tishi =[[UILabel alloc]initWithFrame:CGRectMake(15, 170-64+DEVICE_TABBAR_Height, 200, 25)];
    [self.view addSubview:L_tishi];
    L_tishi.textColor = [UIColor redColor];
    L_tishi.font=[UIFont systemFontOfSize:20];
    L_tishi.hidden=YES;
    messageId = @"0";
}

-(void)nextClick{
    NSLog(@"下一步");
    
    FBLoadingEffectView *effectV =[[FBLoadingEffectView alloc]init];
    effectV.L_title.text=@"正在验证";
    [self.view addSubview:effectV];
    if (TF_yanzhengma.text.length>0&& TF_phone.text>0) {
        
        [WebRequest jsms_ValidcodeWithmsgid:messageId code:TF_yanzhengma.text And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==200 )
            {
          
                dispatch_async(dispatch_get_main_queue(), ^{
                    MimaRegisterViewController *MMvc =[[MimaRegisterViewController alloc]init];
                    MMvc.phoneNumber =TF_phone.text;
                    [self.navigationController pushViewController:MMvc animated:NO];
                    
                });
            
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"验证失败，重新验证";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
        }];
        
        
        
       
        
    }

    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == TF_phone) {
        if([textField.text isMobileNumber]){
            L_tishi.hidden=YES;
            //        L_tishi.text =@"手机号格式正确";
            nextbtn.enabled=YES;
        }
        else{
            L_tishi.hidden=NO;
            L_tishi.text = @"手机号格式不正确";
            nextbtn.enabled=NO;
        }
    }
}


-(void)fasongyanClick{
    NSLog(@"发送验证码");
    
    if([RCKitUtility validateCellPhoneNumber:TF_phone.text]){
        L_tishi.hidden=YES;
        nextbtn.enabled=YES;
        
        [WebRequest jsms_JSendMessagesWithtel:TF_phone.text And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==200)
            {
            NSString *tstr1 =dic[@"msg"];
                NSData *data = [tstr1 dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                messageId =dic1[@"msg_id"];
            }
            
        }];
        
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
                    yanzhengmaBtn.enabled=NO;
                    [yanzhengmaBtn setTitle:[NSString stringWithFormat:@"倒计时(%lds)",(long)total] forState:UIControlStateNormal];
                    [yanzhengmaBtn setBackgroundColor:[UIColor lightGrayColor]];
                    total = total-1;
                    
                });
                
            }
        });
        dispatch_source_set_cancel_handler(timer, ^{
            NSLog(@"Cancel Handler");
            dispatch_async(mainQueue, ^{
                [yanzhengmaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [yanzhengmaBtn setBackgroundColor:YQDCOLOR];
                yanzhengmaBtn.enabled=YES;
            });
            
        });
        dispatch_resume(timer);

        
        
    }
    else{
        L_tishi.hidden=NO;
        L_tishi.text = @"手机号格式不正确";
        nextbtn.enabled=NO;
    }

    
    }
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (timer) {
        dispatch_source_cancel(timer);
    }
}
@end
