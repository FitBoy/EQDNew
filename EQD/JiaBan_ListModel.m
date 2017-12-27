//
//  JiaBan_ListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "JiaBan_ListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation JiaBan_ListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)createTime
{
   return  [_createTime formatDateString];
}
-(NSString*)endTime
{
   return  [_endTime formatDateStringWithoutYear];
}
-(NSString*)startTime
{
    return [_startTime formatDateStringWithoutYear];
}
@end
