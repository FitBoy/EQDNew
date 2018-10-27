//
//  FBGNHomeModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/16.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FBGNHomeModel : NSObject
@property (nonatomic,copy) NSString* text;
@property (nonatomic,copy) NSString* icon;

/// 标识符   区分功能
@property (nonatomic,copy) NSString* module;
@property (nonatomic,strong)  NSArray *children;
/// 小红点 消息的个数
@property (nonatomic,copy) NSString* number_red;
@end
