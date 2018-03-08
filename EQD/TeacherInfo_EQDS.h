//
//  TeacherInfo_EQDS.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherInfo_EQDS : NSObject
///助理
@property (nonatomic,copy) NSString* Assistant;
///助理手机
@property (nonatomic,copy) NSString* AssistantPhone;
///讲师价格
@property (nonatomic,copy) NSString* CooperativePrice;
/// 客户案例
@property (nonatomic,copy) NSString* CustCase;
@property (nonatomic,copy) NSString* Id;
///讲师介绍
@property (nonatomic,copy) NSString* LecturerBackground;
@property (nonatomic,copy) NSString* QQ;
///资质 用;分割的图片地址
@property (nonatomic,copy) NSString* Qualifications;
///研究领域
@property (nonatomic,copy) NSString* ResearchField;
///服务过的企业
@property (nonatomic,copy) NSString* ServiceCom;
/// 授课风格
@property (nonatomic,copy) NSString* TeachStyle;
///工作方法
@property (nonatomic,copy) NSString* WorkingMethod;
@property (nonatomic,copy) NSString* address;
@property (nonatomic,copy) NSString* checker;
@property (nonatomic,copy) NSString* city;
@property (nonatomic,copy) NSString* companyId;
///主讲课程
@property (nonatomic,copy) NSString* courses;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* email;
@property (nonatomic,copy) NSString* headimage;
@property (nonatomic,copy) NSString* isDel;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* province;
@property (nonatomic,copy) NSString* realname;
@property (nonatomic,copy) NSString* sex;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* updateTime;
@property (nonatomic,copy) NSString* updater;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* wechat;
-(NSString*)createTime;
-(NSString*)updateTime;
@end
