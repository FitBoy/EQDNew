//
//  BanbieModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface BanbieModel : FBBaseModel
@property (nonatomic,copy) NSString* Holidays;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* ShiftId;
@property (nonatomic,copy) NSString* comanyId;
@property (nonatomic,copy) NSString* objectType;
@property (nonatomic,copy) NSString* ruleDescribe;
@property (nonatomic,copy) NSString* ruleName;
@property (nonatomic,copy) NSString* shiftName;
@property (nonatomic,copy) NSString* weeks;

-(NSString*)left0;
-(NSString*)left1;
@end
