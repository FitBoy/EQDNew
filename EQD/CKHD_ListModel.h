//
//  CKHD_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/10/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 报名的人，签到的人

#import <Foundation/Foundation.h>

@interface CKHD_ListModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* username;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* ischeck;

@end
