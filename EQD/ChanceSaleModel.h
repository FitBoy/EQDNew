//
//  ChanceSaleModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface ChanceSaleModel : FBBaseModel
@property (nonatomic,copy) NSString* chanceClassify;
@property (nonatomic,copy) NSString* chanceName;
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* contacts;
@property (nonatomic,copy) NSString* contactsName;
@property (nonatomic,copy) NSString* contactsPhone;
@property (nonatomic,copy) NSString* createDate;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* cusid;
@property (nonatomic,copy) NSString* exdateofcompletion;
@property (nonatomic,copy) NSString* expectmoney;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* interestproducts;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* owner;
@property (nonatomic,copy) NSString* productsalesmoney;
@property (nonatomic,copy) NSString* remark;
@property (nonatomic,copy) NSString* remindTime;
@property (nonatomic,copy) NSString* updateTime;
-(NSString*)createTime;
-(NSString*)remindTime;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
@end
