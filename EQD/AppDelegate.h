//
//  AppDelegate.h
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define iOS10_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.1f)
#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
static NSString *appKey = @"bf6b9fb37f1cd64ef457901c";
static NSString *channel = @"EQD";
static BOOL isProduction = TRUE;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
/*** 是否允许横屏的标记 */
@property (nonatomic,assign)BOOL allowRotation;
@property (strong, nonatomic) UIWindow *window;


@end

