//
//  GangweiModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GangweiModel : NSObject
///职位的名称  入职邀请
@property (nonatomic,copy) NSString* name;
///企业的id
@property (nonatomic,copy) NSString*companyid;
///职位描述
@property (nonatomic,copy) NSString* desc;
///职位的类型
@property (nonatomic,copy) NSString* type;
///部门的id
@property (nonatomic,copy) NSString* departid;
///是否是审批人
@property (nonatomic,copy) NSString* isleader;
///职位id 入职邀请也有
@property (nonatomic,copy) NSString* ID;

@property (nonatomic,assign) BOOL isChoose;

/*******专门为入职邀请添加的字段*********/
/// 部门名称
@property (nonatomic,copy) NSString* dename;
///部门id
@property (nonatomic,copy) NSString* deid;
-(void)setDeid:(NSString *)deid;
@end
