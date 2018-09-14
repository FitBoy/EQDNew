//
//  NearbyModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/9/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 附近的客户的model

#import <Foundation/Foundation.h>

@interface NearbyModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* customer;
@property (nonatomic,copy) NSString* address;
@property (nonatomic,copy) NSString* cusCode;
@property (nonatomic,copy) NSString* distance;
@property (nonatomic,assign) float  cell_height;
@end
