//
//  UserModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/3/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/**更新**/
///易企点号
@property (nonatomic,copy) NSString* EQDCode;
/// 应用唯一标识符   token
@property (nonatomic,copy) NSString* Guid;
///注册时间
@property (nonatomic,copy) NSString* addTime;
///是否实名认证
@property (nonatomic,copy) NSString* authen;
/// 昵称
@property (nonatomic,copy) NSString* upname;
///企业id
@property (nonatomic,copy) NSString* companyId;
///部门id
@property (nonatomic,copy) NSString* departId;
///职位id
@property (nonatomic,copy) NSString* postId;
///头像 基本信息
@property (nonatomic,copy) NSString* iphoto;
///员工工号
@property (nonatomic,copy) NSString* jobNumber;
///所在企业的名称
@property (nonatomic,copy) NSString* company;
///部门
@property (nonatomic,copy) NSString* department;
///职位
@property (nonatomic,copy) NSString* post;
///
@property (nonatomic,copy) NSString* step;
///手机号
@property (nonatomic,copy) NSString* uname;
///真实姓名
@property (nonatomic,copy) NSString* username;
///是否是管理员
@property (nonatomic,copy) NSString* isAdmin;
///工作圈的图片
@property (nonatomic,copy) NSString* workImage;
///是否是领导
@property (nonatomic,copy) NSString* isleader;
///个性签名
@property (nonatomic,copy) NSString* Signature;
///入职时间
@property (nonatomic,copy) NSString* signEntryTime;

///朋友圈的图片
@property (nonatomic,copy) NSString* friendCircleImage;
@end
