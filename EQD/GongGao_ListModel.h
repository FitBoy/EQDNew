//
//  GongGao_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface GongGao_ListModel : FBBaseModel
@property (nonatomic,copy) NSString*  createTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* theme;
@property (nonatomic,assign) float cellHeight;
-(NSString*)createTime;

/*******公告详情***/
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* checkMessage;
@property (nonatomic,copy) NSString* checkStatus;
@property (nonatomic,copy) NSString* checkTime;
@property (nonatomic,copy) NSString* checker;
@property (nonatomic,copy) NSString* checkerName;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* duty;
@property (nonatomic,copy) NSString* noticeCode;
@property (nonatomic,copy) NSString* noticeContent;
@property (nonatomic,copy) NSString* noticeCycle;
@property (nonatomic,copy) NSString* noticeName;
@property (nonatomic,copy) NSString* noticeTheme;
@property (nonatomic,copy) NSString* objectDepartId;
@property (nonatomic,copy) NSString* objectType;
@property (nonatomic,copy) NSString* status;
-(NSString*)noticeName;
-(NSString*)checkTime;
-(NSString*)checkMessage;
/****通知详情***/
@property (nonatomic,copy) NSString* createName;
@property (nonatomic,copy) NSString* createType;
@property (nonatomic,copy) NSString* createrDepartId;
@property (nonatomic,copy) NSString* departName;
@property (nonatomic,copy) NSString* newsCode;
@property (nonatomic,copy) NSString* newsContent;
@property (nonatomic,copy) NSString* newsCycle;
@property (nonatomic,copy) NSString* newsName;
@property (nonatomic,copy) NSString* newsTheme;
@property (nonatomic,copy) NSString* checkName;
//企业简称
@property (nonatomic,copy) NSString* simpleCompanyName;
-(NSString*)newsName;
@end
