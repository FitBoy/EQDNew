//
//  GNmodel.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 前端用的一个基础模型 ，用于数据处理

#import <Foundation/Foundation.h>

@interface GNmodel : NSObject
@property (nonatomic,copy) NSString* img;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,assign) NSInteger  biaoji;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* number_red;
@property (nonatomic,strong)  NSArray *arr_imgs;
@end
