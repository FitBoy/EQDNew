//
//  FBPingJia_trainModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/14.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 培训评价用的课程详情

#import <Foundation/Foundation.h>
@interface FBPingJia_trainModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* hostdepId;
@property (nonatomic,copy) NSString* hostdepName;
@property (nonatomic,copy) NSString* respoPerson;
@property (nonatomic,copy) NSString* respoPersonName;
@property (nonatomic,copy) NSString* teacherGuid;
@property (nonatomic,copy) NSString* teacherName;
@property (nonatomic,copy) NSString* theTheme;
@property (nonatomic,copy) NSArray*  trainTimes;
-(NSString*)createTime;

@end
