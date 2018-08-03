//
//  RIZhiListModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RIZhiListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation RIZhiListModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"UserZan":@"ZanModel",
             @"matter":@"RiZhiModel",
             @"plan":@"RiZhiModel",
             @"tomorrowMatter":@"RiZhiModel",
             @"comment":@"GZQ_PingLunModel"
             };
}
-(NSString*)createTime
{
   return  [_createTime datefromDatestring];
}
@end
