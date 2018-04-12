//
//  FBPeople.h
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBPeople : NSObject
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* number;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* message;
/// 0 未注册易企点 3 已加入其他企业 4 已被邀请  1 注册易企点 可以被邀请 2 已加入该企业
@property (nonatomic,copy) NSString* status;

/// 推送的机制的code count 数量的计算
@property (nonatomic,copy) NSString* code;
@property (nonatomic,copy) NSString* count;

///部门
@property (nonatomic,copy) NSString* departId;
@property (nonatomic,copy) NSString*  department;
@property (nonatomic,copy) NSString* user;
@property (nonatomic,assign) float cellHeight;
@end
