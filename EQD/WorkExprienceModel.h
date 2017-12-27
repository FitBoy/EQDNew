//
//  WorkExprienceModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface WorkExprienceModel : FBBaseModel
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* endTime;
@property (nonatomic,copy) NSString* enterpriseNature;
@property (nonatomic,copy) NSString* enterpriseScale;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* induCategoryCode;
@property (nonatomic,copy) NSString* induCategoryName;
@property (nonatomic,copy) NSString* isDel;
@property (nonatomic,copy) NSString* isOvert;
@property (nonatomic,copy) NSString* jobDescri;
@property (nonatomic,copy) NSString* monthlySalary;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* updateTime;
@property (nonatomic,copy) NSString* userGuid;
-(NSString*)startTime;
-(NSString*)endTime;
-(NSString*)left0;
-(NSString*)left1;
-(BOOL)ischoose;

@end
