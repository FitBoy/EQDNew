//
//  RuleTime4Model.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface RuleTime4Model : FBBaseModel
@property (nonatomic,copy) NSString* EndTime1;
@property (nonatomic,copy) NSString* EndTime2;
@property (nonatomic,copy) NSString* EndTime3;
@property (nonatomic,copy) NSString* EndTime4;
@property (nonatomic,copy) NSString* Rule;
@property (nonatomic,copy) NSString* StartTime1;
@property (nonatomic,copy) NSString* StartTime2;
@property (nonatomic,copy) NSString* StartTime3;
@property (nonatomic,copy) NSString* StartTime4;
-(NSString*)StartTime1;
-(NSString*)StartTime2;
-(NSString*)StartTime3;
-(NSString*)StartTime4;
-(NSString*)EndTime1;
-(NSString*)EndTime2;
-(NSString*)EndTime3;
-(NSString*)EndTime4;
@end
