//
//  LaterModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LaterModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation LaterModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"choseTimes":@"DaKaJiLu",
             @"times":@"TimeChild"
             };
}
-(NSString*)createTime
{
    return  [[_createTime formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
-(NSString*)date
{
    return  [[_date formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
-(NSString*)choseDate
{
   return  [[_choseDate formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
@end
