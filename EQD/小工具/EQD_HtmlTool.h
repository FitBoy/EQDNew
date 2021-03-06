//
//  EQD_HtmlTool.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQD_HtmlTool : NSObject
/// 易企阅文章的详情
+(NSString*)getEQDR_ArticleDetailWithId:(NSString*)Id;
///易企创文章详情
+(NSString*)getEQDM_ArticleDetailWithId:(NSString*)Id;
///易企点培训纪律公约
+(NSString*)getEQD_TrainJiLv;
///工作圈的说说详情
+(NSString*)getEQD_ZoneWithid:(NSString*)Id AnduserGuid:(NSString*)userGuid;
/// 企业文化
+(NSString*)getCompanyCultrueWithGuid:(NSString*)guid;
/// 领导活动的连接
+(NSString*)getActiveFromLingdaoWithId:(NSString*)Id;
/// 产品信息详情
+(NSString*)getProductDetailWithId:(NSString*)Id;
///先进事迹详情
+(NSString*)getEventDetailWithId:(NSString*)Id;
/// 企业空间的连接
+(NSString*)getComLinkWithComId:(NSString*)comId;
///活动的详情
+(NSString*)getHuodongDetailWithId:(NSString*)Id;
///获取app的下载地址
+(NSString*)getAppDownload;
@end
