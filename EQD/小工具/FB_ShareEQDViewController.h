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
 
 只支持 文字  图片  链接 这3种分享
 分享 音乐视频 需要的字段 url text title
 */

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
typedef NS_ENUM(NSInteger,EQD_ShareType)
{
    EQD_ShareTypeText=0,
    EQD_ShareTypeImage,
    EQD_ShareTypeLink,
    EQD_ShareTypeFile,
    EQD_ShareTypeVideo
};
@interface FB_ShareEQDViewController : UIViewController

@property (nonatomic,strong)  RCMessageContent *content;
@property (nonatomic,assign) NSInteger EQD_ShareType;
///文本需要的字段
@property (nonatomic,copy) NSString* text;
///分享图片需要的字段
@property (nonatomic,copy) NSString* imageURL;
///分享链接需要的字段 url text title imageURL
@property (nonatomic,copy) NSString* url;
@property (nonatomic,copy) NSString* Stitle;
/*
 分享 音乐需要的字段 url text title
 分享视频 url text title
 分享文件 必须是本地的 
 */

@end
