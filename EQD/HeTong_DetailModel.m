//
//  HeTong_DetailModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "HeTong_DetailModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation HeTong_DetailModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

-(NSString*)signEntryTime
{
    return [[_signEntryTime formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
-(NSString*)contractStartTime
{
    return [[_contractStartTime formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
-(NSString*)contractEndTime
{
    return [[_contractEndTime formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
