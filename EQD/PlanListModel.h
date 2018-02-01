//
//  PlanListModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanListModel : NSObject
@property (nonatomic,copy) NSString* completionRate;
@property (nonatomic,copy) NSString* finishTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString*publishTime;
@property (nonatomic,copy) NSString* theCategory;
@property (nonatomic,copy) NSString* theTheme;
@property (nonatomic,copy) NSString* courseId;
-(NSString*)finishTime;
-(NSString*)publishTime;
/**详情增加字段***/
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* budgetedExpense;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* learningModality;
@property (nonatomic,copy) NSString* numOfReceivePerson;
@property (nonatomic,copy) NSString* perCapitaCost;
@property (nonatomic,copy) NSString* personNumber;
@property (nonatomic,copy) NSString* receTrainDepId;
@property (nonatomic,copy) NSString* receTrainDepName;
@property (nonatomic,copy) NSString* teacherGuid;
@property (nonatomic,copy) NSString* teacherName;
@property (nonatomic,copy) NSString* theTrainTime;
@property (nonatomic,copy) NSString* trainees;

@end
