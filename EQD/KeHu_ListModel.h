//
//  KeHu_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface KeHu_ListModel : FBBaseModel

@property (nonatomic,copy) NSString*  createTime;
@property (nonatomic,copy) NSString*  cusName;
@property (nonatomic,copy) NSString* cusType;
@property (nonatomic,copy) NSString*  ID;
@property (nonatomic,copy) NSString* updateTime;
@property (nonatomic,copy) NSString* cusCall;
@property (nonatomic,copy) NSString* salesTerritory;

@property (nonatomic,assign) float cell_height;

///客户详情
@property (nonatomic,copy) NSString* cusCode;
@property (nonatomic,copy) NSString* address;
@property (nonatomic,copy) NSString* addrlat;
@property (nonatomic,copy) NSString* addrlong;
@property (nonatomic,strong) NSArray* lpicAddr;
@property (nonatomic,strong) NSArray *assList;
@property (nonatomic,copy) NSString* owner;
@property (nonatomic,copy) NSString* remark;
@property (nonatomic,copy) NSString* url;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
-(NSString*)right1;
-(NSString*)createTime;
@end
