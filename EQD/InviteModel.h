//
//  InviteModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface InviteModel : FBBaseModel
///邀约人
@property (nonatomic,copy) NSString* Inviter;
///邀约人职务
@property (nonatomic,copy) NSString* admin;
///公司
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* date;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* status;
///部门
@property (nonatomic,copy) NSString* udepartment;
///职务
@property (nonatomic,copy) NSString* upost;
-(void)setCompany:(NSString *)company;
-(NSString*)left1;
@end
