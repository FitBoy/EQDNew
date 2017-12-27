//
//  GLRecodeModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface GLRecodeModel : FBBaseModel
@property (nonatomic,copy) NSString* cusName;
@property (nonatomic,copy) NSString* revisitDate;
@property (nonatomic,copy) NSString* revisitTitle;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* contactsName;
@property (nonatomic,copy) NSString* contactsPhone;
///详情
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* contactsid;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* cusid;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* owner;
@property (nonatomic,copy) NSString* picAddr;
@property (nonatomic,copy) NSString* remindTime;
@property (nonatomic,copy) NSString* revisitType;
@property (nonatomic,copy) NSString* revisitcontent;
@property (nonatomic,copy) NSString* updateTime;
-(NSString*)remindTime;
-(NSString*)createTime;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
@end
