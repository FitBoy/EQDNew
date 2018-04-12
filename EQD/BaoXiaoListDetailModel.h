//
//  BaoXiaoListDetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaoXiaoListDetailModel : NSObject
@property (nonatomic,copy) NSString* Enclosure;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* billImage;
///预算金额
@property (nonatomic,copy) NSString* budgetMoney;
@property (nonatomic,strong) NSArray *billImageList;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,strong) NSArray *enclosureList;
@property (nonatomic,copy) NSString* explain;
@property (nonatomic,copy) NSString* isBudget;
///报销金额
@property (nonatomic,copy) NSString* reimburseMoney;
@property (nonatomic,copy) NSString* reimburseType;
///剩余金额
@property (nonatomic,copy) NSString*remainderMoney;
@end
