//
//  EQDM_ArticleModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/24.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDM_ArticleModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* beClosed;
/// 评论数
@property (nonatomic,copy) NSString* commentCount;
@property (nonatomic,copy) NSString* matchedTrade;
@property (nonatomic,copy) NSString* pageviews;
@property (nonatomic,copy) NSString* picUrl;
///发布时间
@property (nonatomic,copy) NSString* postTime;
///点赞数
@property (nonatomic,copy) NSString* praiseCount;
@property (nonatomic,copy) NSString* source;
@property (nonatomic,copy) NSString* splendidContent;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,assign) float cellHeight;
///用户头像
@property (nonatomic,copy) NSString* avatar;
@property (nonatomic,copy) NSString* nickname;
@property (nonatomic,copy) NSString* userGuid;
///文章的内容详情
@property (nonatomic,copy) NSString* ArticleContent;
///
@property (nonatomic,copy) NSString* categoryId;
@property (nonatomic,copy) NSString* categoryName;
///收藏数
@property (nonatomic,copy) NSString* collectedCount;
///转发量
@property (nonatomic,copy) NSString* forwardedCount;
@property (nonatomic,copy) NSString* isAttention;
@property (nonatomic,copy) NSString* isPraised;
-(NSString*)postTime;
@end
