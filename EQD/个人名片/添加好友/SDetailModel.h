//
//  SDetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface SDetailModel : FBBaseModel
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,copy) NSString* EQDCode;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* uname;
@property (nonatomic,copy) NSString* authen;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* departId;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* jobNumber;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* postId;
@property (nonatomic,copy) NSString* step;
-(void)setUpname:(NSString *)upname;
-(void)setEQDCode:(NSString *)EQDCode;
-(void)setIphoto:(NSString *)iphoto;

///好友信息
@property (nonatomic,copy) NSString* Guid;
@property (nonatomic,copy) NSString* Message;
/// user 表示是当前用户发的好友申请    friend 表示对方发的好友申请
@property (nonatomic,copy) NSString* ORD;
@property (nonatomic,copy) NSString* Sign;
@property (nonatomic,copy) NSString* AddTime;
//好友登陆地
@property (nonatomic,copy) NSString* LoginLocation;
///好友所在的公司名称
@property (nonatomic,copy) NSString* com_name;
///好友所在的部门名称
@property (nonatomic,copy) NSString* departName;
///好友所在的职位
@property (nonatomic,copy) NSString* postName;

@end
