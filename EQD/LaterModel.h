//
//  LaterModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"
#import "DaKaJiLu.h"
#import "TimeChild.h"
@interface LaterModel : FBBaseModel
@property (nonatomic,copy) NSString*  date;
@property (nonatomic,copy) NSString* ID;
-(NSString*)date;

/****迟到早退的详情****/
@property (nonatomic,copy) NSString* choseDate;
@property (nonatomic,strong) NSArray* choseTimes;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,copy) NSString* reason;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString*  witness;
@property (nonatomic,copy) NSString* witnessName;
@property (nonatomic,copy) NSString* witnessiphoto;
@property (nonatomic,copy) NSString* code;
-(NSString*)choseDate;
/****漏打卡新增字段 **/
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* createName;
@property (nonatomic,strong) NSArray* times;


@end


