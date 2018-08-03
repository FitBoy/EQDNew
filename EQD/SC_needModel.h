//
//  SC_needModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SC_maiMaiModel.h"
@interface SC_needModel : NSObject
@property (nonatomic,copy) NSString* DemandAddress;
@property (nonatomic,copy) NSString* DemandName;
@property (nonatomic,copy) NSString* DemandNum;
@property (nonatomic,copy) NSString* DemandPrice;
@property (nonatomic,copy) NSString* DemandType;
@property (nonatomic,copy) NSString* EndTime;
-(NSString*)EndTime;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* CompanyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* isShow;
@property (nonatomic,assign) float cell_height;
@property (nonatomic,copy) NSString* ContactWay;
@property (nonatomic,copy) NSString* Contacts;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* end_status;
@property (nonatomic,copy) NSString* DemandDescribe;
@property (nonatomic,copy) NSString* GuoBiaoCode;

@property (nonatomic,copy) NSString* ProductDesc;
@property (nonatomic,copy) NSString* ProductId;
@property (nonatomic,copy) NSString* ProductName;
@property (nonatomic,copy) NSString* ProductType;

@property (nonatomic,strong) NSArray* indexList;
-(NSString*)end_status;
-(NSString*)createTime;

@end
