//
//  FBBaseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define YYISiPhoneX [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f&& YYIS_IPHONE
#define YYIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//状态栏高度
#define kStatusBarHeight    (CGFloat)(YYISiPhoneX?(44):(20))
// 导航栏高度
#define kNavBarHBelow7      (44)
// 状态栏和导航栏总高度
#define kNavBarHAbove7      (CGFloat)(YYISiPhoneX?(88):(64))
// TabBar高度
#define kTabBarHeight       (CGFloat)(YYISiPhoneX?(49+34):(49))
// 顶部安全区域远离高度
#define kTopBarSafeHeight   (CGFloat)(YYISiPhoneX?(44):(0))
// 底部安全区域远离高度
#define kBottomSafeHeight   (CGFloat)(YYISiPhoneX?(34):(0))
// iPhoneX的状态栏高度差值
#define kTopBarDifHeight    (CGFloat)(YYISiPhoneX?(24):(0))


#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import <Photos/Photos.h>
@interface FBBaseViewController : UIViewController
- (void)viewDidLoad;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
-(void)mainJiemian;
-(UIAlertController *)alertWithTitle:(NSString*)title message:(NSString*)msg alertControllerStyle:(UIAlertControllerStyle)style;
-(void)kuaijiefangshi;
- (NSString*)ageWithDateOfBirth:(NSString *)s_date;
///判断字符串是否是纯数字
- (BOOL)isPureNumandCharacters:(NSString *)string;
-(void)editCancelClick;
///把数字转成字符串  number=0  返回nil
-(NSString*)changeWithnumber:(NSInteger)number;
- (BOOL)prefersHomeIndicatorAutoHidden ;
@end
