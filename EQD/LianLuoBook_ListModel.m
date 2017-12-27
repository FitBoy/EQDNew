//
//  LianLuoBook_ListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LianLuoBook_ListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation LianLuoBook_ListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)checkTime
{
    if (_checkTime==nil) {
        return @"未审阅";
    }
    return [_checkTime formatDateString];
}
-(NSString*)checkMessage
{
    if(_checkMessage==nil)
    {
       return @" ";
    }
    return _checkMessage;
}
-(NSString*)checkStatus
{
    if (_checkStatus==nil) {
        return @" ";
    }
    return _checkStatus;
}
@end
