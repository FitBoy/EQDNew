//
//  JiaBan_DetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface JiaBan_DetailModel : FBBaseModel
@property (nonatomic,copy) NSString* HR;
@property (nonatomic,copy) NSString* HRName;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* checker;
@property (nonatomic,copy) NSString* checkerName;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* endOverTime;
@property (nonatomic,copy) NSString* overTimeCode;
@property (nonatomic,copy) NSString* overTimeReason;
@property (nonatomic,copy) NSString* overTimeType;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* startOverTime;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* step;
@property (nonatomic,copy) NSString* times;
-(NSString*)createTime;
-(NSString*)startOverTime;
-(NSString*)endOverTime;
@end
