//
//  AccidentModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/6.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface AccidentModel : FBBaseModel
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* cost;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* dutyRatio;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* personLiableName;
@property (nonatomic,copy) NSString* plateNumber;
@property (nonatomic,strong)  NSArray *picAddr;
@property (nonatomic,copy) NSString* remark;
@property (nonatomic,copy) NSString* thePlace;
@property (nonatomic,copy) NSString* theTime;
@property (nonatomic,copy) NSString* vehicleId;
-(NSString*)createTime;
-(NSString*)theTime;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
-(NSString*)right1;

@end
