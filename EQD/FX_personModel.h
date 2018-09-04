//
//  FX_personModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
/*
 {
 "Id": 1,
 "type": 0,
 "objectGuid": "4f47e8c7e40541d4a2f03c3c72304252",
 "companyId": 46,
 "staffName": "梁新帅",
 "company": "郑州易企点信息科技有限公司",
 "post": "ios 负责人",
 "department": "技术部",
 "departId": 432,
 "postId": 162
 }
 */
#import <Foundation/Foundation.h>

@interface FX_personModel : NSObject
@property (nonatomic,copy) NSString* postId;
@property (nonatomic,copy) NSString* departId;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString*post;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString*staffName;
@property (nonatomic,copy) NSString*companyId;
@property (nonatomic,copy) NSString*objectGuid;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* iphoto;
@end
