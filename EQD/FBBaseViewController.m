//
//  FBBaseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import <Photos/Photos.h>
#import "FBOneViewController.h"
#import "FBTwoViewController.h"
#import "FBThreeViewController.h"
#import "FBFourViewController.h"
#import "FBFiveViewController.h"
#import "FBTabBarViewController.h"
#import <Masonry.h>
#import "ASearchViewController.h"
#import "ExActivity.h"
#import "FBActivityViewController.h"
@interface FBBaseViewController ()
{
    UserModel *user;
}

@end

@implementation FBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)mainJiemian{
    FBTabBarViewController *tabBar =[[FBTabBarViewController alloc]init];
    self.view.window.rootViewController = tabBar;
}

-(UIAlertController *)alertWithTitle:(NSString*)title message:(NSString*)msg alertControllerStyle:(UIAlertControllerStyle)style
{
    UIAlertController *alert ;
    if (title==nil) {
        alert = [[UIAlertController alloc]init];
    }
    else
    {
        alert =[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:style];
    }
    return alert;
}


-(void)kuaijiefangshi
{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"加好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ASearchViewController *Svc =[[ASearchViewController alloc]init];
        Svc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Svc animated:NO];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"扫一扫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 1、 获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if (device) {
            // 判断授权状态
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
            } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.detailsLabel.text =@"请到设置->易企点->修改访问权限";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view.window animated:YES];
                });
            } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
                FBScanViewController *Svc =[[FBScanViewController alloc]init];
                Svc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:Svc animated:NO];
            } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
                // 弹框请求用户授权
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                        FBScanViewController *Svc =[[FBScanViewController alloc]init];
                        Svc.hidesBottomBarWhenPushed=YES;
                        [self.navigationController pushViewController:Svc animated:NO];
                        
                    }
                }];
            }
            
        } else {
            
            //模拟器
        }

        
        
       
        
        
        
    }]];
    
    //    [alert addAction:[UIAlertAction actionWithTitle:@"易企点FAQ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //            TFAQViewController *FAQvc =[[TFAQViewController alloc]init];
    //            FAQvc.hidesBottomBarWhenPushed=YES;
    //            [self.navigationController pushViewController:FAQvc animated:NO];
    //
    //
    //
    //
    //    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"邀请朋友注册易企点" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString  *Tstr = @"";
        if (user.username.length>1) {
            Tstr =[NSString stringWithFormat:@"%@(%@)",user.uname,user.username];
        }else
        {
            Tstr =user.uname;
        }
        //邀请好友注册易企点
        ExActivity *activity=[[ExActivity alloc]init];
        activity.messageContent = [RCTextMessage messageWithContent:[NSString stringWithFormat:@"【易企点】您的朋友:%@邀请您注册易企点,点击 https://www.eqidd.com/relatedLink/related.html 注册",Tstr]];
        
        FBActivityViewController *ACvc =[[FBActivityViewController alloc]initWithActivityItems:@[[NSString stringWithFormat:@"【易企点】您的朋友:<%@>邀请您注册易企点,点击 https://www.eqidd.com/relatedLink/related.html 注册",Tstr]] applicationActivities:@[activity]];
        
        [self  presentViewController:ACvc animated:NO completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}

- (NSString*)ageWithDateOfBirth:(NSString *)s_date
{
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:s_date];
    // 出生日期转换 年月日
    
    if (date==nil) {
        return @"请选择";
    }
    else
    {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return [NSString stringWithFormat:@"%ld",(long)iAge];
    }
}
///判断字符串是否是数字
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}
///把数字转成字符串  number=0  返回nil
-(NSString*)changeWithnumber:(NSInteger)number
{
    return number==0?nil:[NSString stringWithFormat:@"%ld",number];
}
-(void)editCancelClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您确定退出此次编辑？信息将不会保留" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

@end
