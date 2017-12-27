//
//  BanCiModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface BanCiModel : FBBaseModel
@property (nonatomic,copy) NSString*  Id;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* endTime1;
@property (nonatomic,copy) NSString* endTime2;
@property (nonatomic,copy) NSString* endTime3;
@property (nonatomic,copy) NSString* endTime4;
@property (nonatomic,copy) NSString* isDel;
@property (nonatomic,copy) NSString* shiftName;
@property (nonatomic,copy) NSString*startTime1;
@property (nonatomic,copy) NSString* startTime2;
@property (nonatomic,copy) NSString* startTime3;
@property (nonatomic,copy) NSString* startTime4;
@property (nonatomic,copy) NSString* updateTime;
@property (nonatomic,copy) NSString* updater;
-(NSString*)left0;
-(NSString*)left1;
@end
