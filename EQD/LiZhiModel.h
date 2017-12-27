//
//  LiZhiModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface LiZhiModel : FBBaseModel
///离职编码
@property (nonatomic,copy) NSString* code;
@property (nonatomic,copy) NSString* Code;
@property (nonatomic,copy) NSString* quitcode;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* departId;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* jobNumber;
@property (nonatomic,copy) NSString* joinTime;
@property (nonatomic,copy) NSString* nextStep;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* postId;
@property (nonatomic,copy) NSString* quitId;
@property (nonatomic,copy) NSString* quitReason;
@property (nonatomic,copy) NSString* quitTime;
@property (nonatomic,copy) NSString* quitType;
@property (nonatomic,copy) NSString* startStep;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* uname;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* ApprovedChecker;
@property (nonatomic,copy) NSString* allStep;
@property (nonatomic,copy) NSString* checker;
@property (nonatomic,copy) NSString* nextChecker;
@property (nonatomic,copy) NSString* nextCheckerName;

/*****离职审批新增****/
-(NSString*)quitTime;
-(NSString*)joinTime;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
-(NSString*)right1;
@end
