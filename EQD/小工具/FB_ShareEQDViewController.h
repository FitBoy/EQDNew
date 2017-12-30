//
//  FB_ShareEQDViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/*
 LYvc.providesPresentationContextTransitionStyle = YES;
 LYvc.definesPresentationContext = YES;
 LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
 
 10 发送到朋友  11 工作圈  12 复制（暂不要）  13 我的收藏  14 保存到手机(暂不要) 15 复制链接  16用safri打开
  20 微信  21 微信收藏  22 朋友圈
 30 QQ  31 qq空间
 40 新浪微博
 */

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,EQD_ShareType)
{
    EQD_ShareTypeText=0,
    EQD_ShareTypeImage,
    EQD_ShareTypeLink,
    EQD_ShareTypeFile,
    EQD_ShareTypeVideo
};
@interface FB_ShareEQDViewController : UIViewController
@property (nonatomic,assign) NSInteger EQD_ShareType;

@end
