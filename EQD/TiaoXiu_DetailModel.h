//
//  TiaoXiu_DetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface TiaoXiu_DetailModel : FBBaseModel
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
@property (nonatomic,copy) NSString* offCode;
@property (nonatomic,copy) NSString* offEndTime;
@property (nonatomic,copy) NSString* offStartTime;
@property (nonatomic,copy) NSString* offTimes;
@property (nonatomic,copy) NSString* planEndTime;
@property (nonatomic,copy) NSString* planStartTime;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* step;
-(NSString*)planStartTime;
-(NSString*)planEndTime;
-(NSString*)offStartTime;
-(NSString*)offEndTime;
-(NSString*)createTime;
@end
