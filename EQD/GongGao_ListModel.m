//
//  GongGao_ListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GongGao_ListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation GongGao_ListModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)checkTime
{
    if (_checkTime==nil) {
        return @"未审核";
    }
    return [_checkTime formatDateString];
}
-(NSString*)checkMessage
{
    if (_checkMessage==nil) {
        return @" ";
    }
    return _checkMessage;
}
-(NSString*)noticeName
{
    return [_noticeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(NSString*)newsName
{
   return [_newsName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
