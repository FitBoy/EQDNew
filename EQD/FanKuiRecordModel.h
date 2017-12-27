//
//  FanKuiRecordModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface FanKuiRecordModel : FBBaseModel
@property (nonatomic,copy) NSString* addr;
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* cusid;
@property (nonatomic,copy) NSString* fbTime;
@property (nonatomic,copy) NSString* fbcontent;
@property (nonatomic,copy) NSString* fberName;
@property (nonatomic,copy) NSString* fberPhone;
@property (nonatomic,copy) NSString* fberid;
@property (nonatomic,copy) NSString* fbpicAddr;
@property (nonatomic,copy) NSString* fbtitle;
@property (nonatomic,copy) NSString* fbtype;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSArray* lpicAddr;
@property (nonatomic,copy) NSString* owner;
@property (nonatomic,copy) NSString* remindTime;
@property (nonatomic,copy) NSString* updateTime;
-(NSString*)createTime;
-(NSString*)fbTime;
-(NSString*)remindTime;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
@end
