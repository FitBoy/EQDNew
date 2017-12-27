//
//  QunMember.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"
/*
 "iphoto": "0",
 "uname": "15286837836",
 "upname": "游客15286837836",
 "authen": 0,
 "Guid": "ad24c1f1a2b343cc94b80466fa18150e",
 "EQDCode": null,
 "addTime": null
 */
@interface QunMember : FBBaseModel
///群成员的头像
@property (nonatomic,copy) NSString* iphoto;
//手机号
@property (nonatomic,copy) NSString* uname;
///成员昵称
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,copy) NSString* authen;
///
@property (nonatomic,copy) NSString* Guid;
///易企点号
@property (nonatomic,copy) NSString* EQDCode;
@property (nonatomic,copy) NSString* addTime;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* departId;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* isAdmin;
@property (nonatomic,copy) NSString* isleader;
@property (nonatomic,copy) NSString* jobNumber;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* postId;
@property (nonatomic,copy) NSString* shiftId;
@property (nonatomic,copy) NSString* step;
@property (nonatomic,copy) NSString* username;
@property (nonatomic,copy) NSString* workImage;


-(NSString*)img_header;
-(NSString*)left0;

@end
