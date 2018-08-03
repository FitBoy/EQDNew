//
//  Com_dongTanModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Com_dongTanModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation Com_dongTanModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"Comment":@"GZQ_PingLunModel",
             @"UserZan":@"ZanModel",
             @"taskComment":@"GZQ_PingLunModel"
             };
}
@end
