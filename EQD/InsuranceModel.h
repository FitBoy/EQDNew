//
//  InsuranceModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface InsuranceModel : FBBaseModel
@property (nonatomic,copy) NSString* InsuranceCompany;
@property (nonatomic,copy) NSString* InsuranceType;
@property (nonatomic,copy) NSString* agent;
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* mileageThen;
@property (nonatomic,copy) NSString* money;
@property (nonatomic,copy) NSString* plateNumber;
@property (nonatomic,copy) NSString* remark;
@property (nonatomic,copy) NSString* theDate;
@property (nonatomic,copy) NSString* vehicleId;
-(NSString*)createTime;
-(NSString*)theDate;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;

@end
