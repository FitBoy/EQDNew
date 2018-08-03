//
//  Com_UserModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface Com_UserModel : FBBaseModel
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* departmentId;
@property (nonatomic,copy) NSString* postId;
/// 签名
@property (nonatomic,copy) NSString* Signature;
@property (nonatomic,copy) NSString* EQDCode;
///手机号
@property (nonatomic,copy) NSString* uname;
@property (nonatomic,copy) NSString* photo;
///昵称
@property (nonatomic,copy) NSString* upname;
///登陆地
@property (nonatomic,copy) NSString* location;
///真实姓名
@property (nonatomic,copy) NSString* username;
@property (nonatomic,copy) NSString* isFriend;
@property (nonatomic,copy) NSString* jobNumber;
@property (nonatomic,assign) BOOL isSelected;
-(BOOL)ischoose;
-(NSString*)img_header;
-(NSString*)left0;
-(NSString*)left1;

/*******联络书搜索使用该model   :***
 EQDCode,company,companyId,department,departmentId,guid,headImage,id,name,nickName,phone,post,postId
 
 */
@property (nonatomic,copy) NSString* guid;
@property (nonatomic,copy) NSString* headImage;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* nickName;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* ID;

-(NSString*)right0;
-(NSString*)right1;
@end
