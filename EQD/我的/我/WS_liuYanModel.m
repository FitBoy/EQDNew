//
//  WS_liuYanModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "WS_liuYanModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation WS_liuYanModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"childList":@"WS_liuYanModel"
             };
}
@end
