//
//  RIZhiListModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/4/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RiZhiModel.h"
#import "ZanModel.h"
#import "GZQ_PingLunModel.h"
@interface RIZhiListModel : NSObject
@property (nonatomic,copy) NSString* Audience;
@property (nonatomic,copy) NSString* Feeling;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* PostId;
@property (nonatomic,strong)  NSArray *UserZan;
@property (nonatomic,copy) NSString* com_name;
@property (nonatomic,copy) NSString* commentCount;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* departName;
@property (nonatomic,copy) NSString* departmentId;
@property (nonatomic,copy) NSString* displayType;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* isZan;
@property (nonatomic,copy) NSString* location;
@property (nonatomic,strong)  NSArray *matter;
@property (nonatomic,strong) NSArray* plan;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,strong)  NSArray *tomorrowMatter;
@property (nonatomic,copy) NSString* zanCount;
@property (nonatomic,strong)  NSArray *comment;

@property (nonatomic,strong)  NSIndexPath *indexPath_model;
-(NSString*)createTime;
@property (nonatomic,assign) float cellHeight;
@end
