//
//  ComModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComModel : NSObject
///公司的创始人
@property (nonatomic,copy) NSString* creater;
///公司的联系方式
@property (nonatomic,copy) NSString* contact;
///负责人
@property (nonatomic,copy) NSString* dutyman;
///公司邮箱
@property (nonatomic,copy) NSString* email;
///公司id
@property (nonatomic,copy) NSString* idnum;
///公司名称
@property (nonatomic,copy) NSString* name;
///公司类型
@property (nonatomic,copy) NSString* type;
///公司地址
@property (nonatomic,copy) NSString* address;
///是否企业认证
@property (nonatomic,copy) NSString* isauthen;
///企业所属的行业
@property (nonatomic,copy) NSString* hangye;
///企业logo
@property (nonatomic,copy) NSString* logo;
///企业简称
@property (nonatomic,copy) NSString* simpleName;


@end
