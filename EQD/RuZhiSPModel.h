//
//  RuZhiSPModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface RuZhiSPModel : FBBaseModel
@property (nonatomic,copy) NSString* InviteTime;
@property (nonatomic,copy) NSString* Inviter;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* companyName;
///部门名称
@property (nonatomic,copy) NSString* departName;
@property (nonatomic,copy) NSString* departmentId;
@property (nonatomic,copy) NSString* entryId;
@property (nonatomic,copy) NSString* postId;
///职位名称
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* udate;
@property (nonatomic,copy) NSString* uedu;
///户籍地址
@property (nonatomic,copy) NSString* uhouseadress;
@property (nonatomic,copy) NSString* uhousetype;
///身份证号
@property (nonatomic,copy) NSString* uidnum;
@property (nonatomic,copy) NSString* uidumbackphoto;
@property (nonatomic,copy) NSString* uidumfrontphoto;
@property (nonatomic,copy) NSString* uiphoto;
///职业资格
@property (nonatomic,copy) NSString* umajor;
@property (nonatomic,copy) NSString* umarry;
///名字
@property (nonatomic,copy) NSString* uname;
///民族
@property (nonatomic,copy) NSString* unation;
@property (nonatomic,copy) NSString* upoliticstate;
@property (nonatomic,copy) NSString* userPhone;
@property (nonatomic,copy) NSString* usex;
@property (nonatomic,copy) NSString* uwithidumphoto;
///当前人的标志guid
@property (nonatomic,copy) NSString* u1;

///劳动合同上的入职时间
@property (nonatomic,copy) NSString* signEntryTime;
@property (nonatomic,copy) NSString* JobNumber;

-(NSString*)left0;
-(NSString*)left1;
-(NSString*)img_header;
-(NSString*)right1;
-(NSString*)right0;
-(NSString*)signEntryTime;


@end
