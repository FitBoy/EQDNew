//
//  EQDR_pingLunModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDR_pingLunModel : NSObject
@property (nonatomic,copy) NSString* isZan;
@property (nonatomic,copy) NSString* Id;
/// 举报次数
@property (nonatomic,copy) NSString* ReportCount;
@property (nonatomic,copy) NSString* articleId;
/*@property (nonatomic,copy) NSString* before;
@property (nonatomic,copy) NSString* beforeImage;
@property (nonatomic,copy) NSString* beforeName;*/
//评论数
@property (nonatomic,copy) NSString* commentCount;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* parentId;
//0：已公开，1：被成功举报，2：精品推荐
@property (nonatomic,copy) NSString* status;
@property (nonatomic,strong)  NSArray *list;
@property (nonatomic,strong)  NSMutableArray *arr_muList;
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,copy) NSString* userGuid;
//点赞的人数
@property (nonatomic,copy) NSString* zanCount;
@property (nonatomic,copy) NSString* firstComment;
@property (nonatomic,copy) NSString* firstCommentId;
@property (nonatomic,copy) NSString* parentUPname;
@property (nonatomic,copy) NSString* parentUserGuid;
@property (nonatomic,copy) NSString* parentUserPhoto;


@property (nonatomic,assign) float cellHeight;
-(NSMutableArray*)arr_muList;
-(NSString*)createTime;

@end
