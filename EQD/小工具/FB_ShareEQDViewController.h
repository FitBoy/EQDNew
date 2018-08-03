//
//  FB_ShareEQDViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/* *
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
/// 收藏字段  type Stitle url source sourceOwner articleId 收藏连接需要的字段
#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
typedef NS_ENUM(NSInteger,EQD_ShareType)
{
    EQD_ShareTypeText=0,
    EQD_ShareTypeImage,
    EQD_ShareTypeLink,
    EQD_ShareTypeFile,
    EQD_ShareTypeVideo,
    EQD_ShareTypeImage2,  //本地图片
    EQD_ShareTypeGerenCard,
    EQD_ShareTypeVoice
};
@interface FB_ShareEQDViewController : UIViewController

@property (nonatomic,strong)  RCMessageContent *content;
@property (nonatomic,assign) NSInteger EQD_ShareType;
///文本需要的字段
@property (nonatomic,copy) NSString* text;
///分享图片需要的字段
@property (nonatomic,copy) NSString* imageURL;
///分享链接需要的字段 url text Stitle imageURL type articleId (source sourceOwner是本应用需要的字段)
@property (nonatomic,copy) NSString* url;
@property (nonatomic,copy) NSString* Stitle;
@property (nonatomic,copy) NSString* articleId;
@property (nonatomic,copy) NSString* source; // 收藏中也可以用
@property (nonatomic,copy) NSString* sourceOwner; //收藏中也可以用

///收藏的链接的type说明  10 易企阅  12 易企创  11 易企学  ......13?企业空间
@property (nonatomic,assign) NSInteger type;
///0:工作圈   1:网页连接，2：视频，3：音乐，9：广告 网页链接多出来的字段
@property (nonatomic,assign) NSInteger type2;
/*
 
 分享 音乐需要的字段 url text Stitle
 分享视频 url text Stitle
 分享文件 必须是本地的  url, fileExt  Stitle
 url是视频的网络地址
 */
@property (nonatomic,copy) NSString* filePath;
@property (nonatomic,copy) NSString* fileExt;

/**分享一张图片的字段*/
@property (nonatomic,strong)  UIImage *image_local;

/**
 个人名片
 dic2 = @{
 @"imgurl":model.iphoto,
 @"name":model.pname,
 @"bumen":dic1[@"postname"],
 @"gangwei":dic1[@"careername"],
 @"company":@"公司名称",
 @"uid":model.uname,
 @"comid":dic1[@"cid"]
 */
@property (nonatomic,copy) NSString* imgurl;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* bumen;
@property (nonatomic,copy) NSString* gangwei;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* uid;
@property (nonatomic,copy) NSString* comid;

/**
 文件
 只支持本地路径
 */
@property (nonatomic,copy) NSString* fileLocalPath;

@end
