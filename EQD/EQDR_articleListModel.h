//
//  EQDR_articleListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDR_articleListModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* browseCount;
@property (nonatomic,copy) NSString* commentCount;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* image;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* lable;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* zanCount;
@property (nonatomic,copy) NSString* source;
@property (nonatomic,assign) float cellHeight;
@property (nonatomic,assign) NSInteger sourceNumber;
-(NSString*)source;
-(NSString*)createTime;

//文章详情 增加的字段
///收录数
@property (nonatomic,copy) NSString* IncludCount;
///是否精选
@property (nonatomic,copy) NSString* boutique;
///收藏数
@property (nonatomic,copy) NSString* collectionCount;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* homeImage;
///是否热门
@property (nonatomic,copy) NSString* hoot;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* menuId;
///举报的次数
@property (nonatomic,copy) NSString* reportCount;
///转载量
@property (nonatomic,copy) NSString* reprintCount;
@property (nonatomic,copy) NSString* score;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* textContent;
@property (nonatomic,copy) NSString* uname;
@property (nonatomic,copy) NSString* isZan;
@property (nonatomic,copy) NSString* isAttention;
-(NSString*)content;
@end
