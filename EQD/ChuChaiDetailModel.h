//
//  ChuChaiDetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface ChuChaiDetailModel : FBBaseModel
@property (nonatomic,copy) NSString*  Id;
@property (nonatomic,copy) NSString* JobNumber;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* mapAddress;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* travelAddress;
@property (nonatomic,copy) NSString* travelCode;
@property (nonatomic,copy) NSString* travelEndTime;
@property (nonatomic,copy) NSString* travelReason;
@property (nonatomic,copy) NSString* travelStartTime;
@property (nonatomic,copy) NSString* travelTimes;
@property (nonatomic,copy) NSString* uname;
-(NSString*)createTime;
-(NSString*)travelStartTime;
-(NSString*)travelEndTime;
@end
