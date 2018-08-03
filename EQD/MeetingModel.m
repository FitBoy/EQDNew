//
//  MeetingModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/24.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "MeetingModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation MeetingModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"attendees":@"HeadPersonModel"
             };
}

-(NSString*)startTime
{
    if (_startTime.length >10) {
        return [_startTime formatDateString];
    }else
    {
    return [_startTime substringWithRange:NSMakeRange(0, 5)];
    }
}

-(NSString*)endTime
{
    if (_endTime.length >10) {
        return [_endTime formatDateString];
    }else
    {
    return [_endTime substringWithRange:NSMakeRange(0, 5)];
    }
}
-(NSString*)frequency
{
    NSArray *tarr = @[@"每周",@"每月",@"每日",@"一次"];
    return tarr[[_frequency integerValue]-1];
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
