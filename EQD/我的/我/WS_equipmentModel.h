//
//  WS_equipmentModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/2.
//  Copyright © 2018年 FitBoy. All rights reserved.
//设备信息

#import <Foundation/Foundation.h>

@interface WS_equipmentModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* EquipmentName;
@property (nonatomic,copy) NSString* image;
///设备厂商
@property (nonatomic,copy) NSString* Manufactor;
/// 购买日期
@property (nonatomic,copy) NSString* DateOfPurchase;

@property (nonatomic,assign) float  cell_height;

@property (nonatomic,copy) NSString* EquipmentMsg;
@property (nonatomic,strong)  NSArray *images;
@end
