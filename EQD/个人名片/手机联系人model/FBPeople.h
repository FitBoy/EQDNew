//
//  FBPeople.h
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/*
 EQDNickname = "";
 headImage = "";
 isFriend = "-2";
 localNickname = "\U5f20\U677e";
 phone = 693231;
 userGuid = "";
 服务器与本地的联系人\
 ///根据userGuid是否是空来判断是否注册易企点
 */

#import <Foundation/Foundation.h>

@interface FBPeople : NSObject
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* number;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* message;
/// 0 未注册易企点 3 已加入其他企业 4 已被邀请  1 注册易企点 可以被邀请 2 已加入该企业
@property (nonatomic,copy) NSString* status;

@property (nonatomic,copy) NSString* EQDNickname;
@property (nonatomic,copy) NSString* headImage;
///-2：无申请记录  -1：拒绝过 0：待处理 1：已同意 11：我已同意  10：等待我处理  -11：我已拒绝
@property (nonatomic,copy) NSString* isFriend;
@property (nonatomic,copy) NSString* localNickname;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* isZhuCe;
-(NSString*)isZhuCe;

@property (nonatomic,assign) BOOL isChoose;

/// 推送的机制的code count 数量的计算
@property (nonatomic,copy) NSString* code;
@property (nonatomic,copy) NSString* count;

///部门
@property (nonatomic,copy) NSString* departId;
@property (nonatomic,copy) NSString*  department;
@property (nonatomic,copy) NSString* user;
@property (nonatomic,assign) float cellHeight;
@end
