//
//  TrafficListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/5.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface TrafficListModel : FBBaseModel
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* isdone;
@property (nonatomic,copy) NSString* personLiableName;
@property (nonatomic,strong) NSArray* picAddr;
@property (nonatomic,copy) NSString* plateNumber;
@property (nonatomic,copy) NSString* theDate;
@property (nonatomic,copy) NSString* theFine;
@property (nonatomic,copy) NSString* theReason;
@property (nonatomic,copy) NSString* vehicleId;

-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
-(NSString*)right1;
-(NSString*)createTime;
-(NSString*)theDate;
@end
