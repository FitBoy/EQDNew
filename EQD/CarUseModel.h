//
//  CarUseModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//  用车申请

#import "FBBaseModel.h"

@interface CarUseModel : FBBaseModel
@property (nonatomic,copy) NSString* applyer;
@property (nonatomic,copy) NSString*  applyerDepName;
@property (nonatomic,copy) NSString* applyerName;
@property (nonatomic,strong)  NSArray *checkList;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* destination;
@property (nonatomic,copy) NSString* endTime;
@property (nonatomic,copy) NSString* code;
@property (nonatomic,copy) NSString* origin;
@property (nonatomic,copy) NSString* personCount;
@property (nonatomic,copy) NSString* plateNumber;
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* vehicleId;

@property (nonatomic,copy) NSString* theCustomer;
@property (nonatomic,copy) NSString* theDriverName;
@property (nonatomic,copy) NSString* theProject;
@property (nonatomic,copy) NSString* theReason;
-(NSString*)createTime;
-(NSString*)startTime;
-(NSString*)endTime;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
-(NSString*)right1;
@end
