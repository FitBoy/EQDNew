//
//  TongShiModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "TongShiModel.h"
#import <MJExtension.h>
@implementation TongShiModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"UserInfo":@"Com_UserModel",
             @"childs":@"TongShiModel"
             };
}
@end
