//
//  HeTong_DetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface HeTong_DetailModel : FBBaseModel
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* companyName;
@property (nonatomic,copy) NSString* checkerName;
@property (nonatomic,copy) NSString* contractCode;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* signatoryName;
@property (nonatomic,copy) NSString* signatory;
@property (nonatomic,copy) NSString* signDepartId;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* signPostId;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* signEntryTime;
@property (nonatomic,copy) NSString* contractType;
@property (nonatomic,copy) NSString* contractNature;
@property (nonatomic,copy) NSString* signedNumber;
@property (nonatomic,copy) NSString* lastReason;
@property (nonatomic,copy) NSString* contractForm;
@property (nonatomic,copy) NSString* contractStartTime;
@property (nonatomic,copy) NSString* contractEndTime;
@property (nonatomic,copy) NSString* probation;
@property (nonatomic,copy) NSString* bank;
@property (nonatomic,copy) NSString* bankCard;
@property (nonatomic,copy) NSString* openBank;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* step;
@property (nonatomic,copy) NSString* checker;
///试用期工资
@property (nonatomic,copy) NSString* ProbationSalary;
-(NSString*)signEntryTime;
-(NSString*)contractStartTime;
-(NSString*)contractEndTime;
-(NSString*)createTime;
@end
