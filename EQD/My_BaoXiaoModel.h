//
//  My_BaoXiaoModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 报销审批model

#import <Foundation/Foundation.h>
#import "BaoXiaoListDetailModel.h"
@interface My_BaoXiaoModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* checker;
@property (nonatomic,copy) NSString* checkerName;
@property (nonatomic,copy) NSString* code;
@property (nonatomic,copy) NSString* createName;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* remibursetitle;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* totalMoney;
@property (nonatomic,assign) float cellHeight;
-(NSString*)createTime;

/*详情多出来的字段*/
@property (nonatomic,copy) NSString* companyId;
///报销明细的数量
@property (nonatomic,copy) NSString* detailCount;
@property (nonatomic,copy) NSString* detailIds;
@property (nonatomic,strong) NSArray *detailList;
@property (nonatomic,copy) NSString* remarks;

@end
