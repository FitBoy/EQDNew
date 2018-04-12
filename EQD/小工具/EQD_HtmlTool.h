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
@end
