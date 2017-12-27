//
//  FBHaoYouModel.h
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {"iphoto":"0","uname":"15286837836","name":"0","sex":0,"nation":"0","birth":"1900-01-01T00:00:00","bplace":"0","email":"0","authen":0}
 
 */
@interface FBHaoYouModel : NSObject
///是否被选择
@property (nonatomic,assign)BOOL ischoose;
///个人头像url
@property (nonatomic,copy) NSString* iphoto;

///注册时间
@property (nonatomic,copy) NSString* AddTime;
///请求的附加信息
@property (nonatomic,copy) NSString* Message;
///user 表示不是自己添加好友  friend 表示是对方添加你为好友
@property (nonatomic,copy) NSString* ORD;
/// -1 拒绝 0 等待处理  1 已同意
@property (nonatomic,copy) NSString* Sign;
///昵称
@property (nonatomic,copy) NSString* upname;

/*****个人的基本信息*****/
///易企点号
@property (nonatomic,copy) NSString* EQDCode;
/// token
@property (nonatomic,copy) NSString* Guid;
///是否删除
@property (nonatomic,copy) NSString* Isdel;
///密码
@property (nonatomic,copy) NSString* Password;
///注册时间
@property (nonatomic,copy) NSString* addTime;
///0 未实名 1 已实名
@property (nonatomic,copy) NSString* authen;
///登录地
@property (nonatomic,copy) NSString* loginLocation;
///手机号
@property (nonatomic,copy) NSString* uname;
/// 判断是否是 好友 0 不是 1 是
@property (nonatomic,copy) NSString* type;
@end
