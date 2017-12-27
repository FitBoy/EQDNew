//
//  Repair_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface Repair_ListModel : FBBaseModel
@property (nonatomic,copy) NSString* agent;
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* cost;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* plateNumber;
@property (nonatomic,strong)  NSArray *picAddr;
@property (nonatomic,copy) NSString* remark;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* vehicleId;
@property (nonatomic,copy) NSString* when;
@property (nonatomic,copy) NSString* where;
-(NSString*)createTime;
-(NSString*)when;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
-(NSString*)right1;
@end
