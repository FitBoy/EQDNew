//
//  Tiaoban_DetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"
#import "RuleTime4Model.h"
@interface Tiaoban_DetailModel : FBBaseModel
@property (nonatomic,copy) NSString* HR;
@property (nonatomic,copy) NSString* HRName;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,strong) RuleTime4Model* changeRule;
@property (nonatomic,strong) RuleTime4Model* nowRule;
@property (nonatomic,copy) NSString* changeShiftCode;
@property (nonatomic,copy) NSString* changeShiftId;
@property (nonatomic,copy) NSString* changeShiftReason;
@property (nonatomic,copy) NSString* checker;
@property (nonatomic,copy) NSString* checkerName;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* nowShiftId;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* ruleName;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* step;

@end


