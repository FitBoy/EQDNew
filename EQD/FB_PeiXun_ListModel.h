//
//  FB_PeiXun_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FB_PeiXun_ListModel : NSObject
@property (nonatomic,copy) NSString* applicantGuid;
@property (nonatomic,copy) NSString* applicantName;
@property (nonatomic,copy) NSString* budgetedExpense;
@property (nonatomic,copy) NSString* depName;
@property (nonatomic,copy) NSString*  ID;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* recoDocentGuid;
@property (nonatomic,copy) NSString* recoDocentName;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* theCategory;
@property (nonatomic,copy) NSString*theTheme;
@property (nonatomic,copy) NSString* thedateEnd;
@property (nonatomic,copy) NSString*thedateStart;
@property (nonatomic,copy) NSString*trainees;
-(NSString*)thedateStart;
-(NSString*)thedateEnd;

/*******培训详情******/

@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* applyReason;
@property (nonatomic,copy) NSString* code;
@property (nonatomic,strong) NSArray  *checkList;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* depid;
@property (nonatomic,copy) NSString* postid;
@property (nonatomic,copy) NSString* theDemand;

-(NSString*)createTime;
@end
