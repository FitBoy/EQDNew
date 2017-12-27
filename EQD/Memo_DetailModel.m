//
//  Memo_DetailModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Memo_DetailModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation Memo_DetailModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)startDate
{
    return [[_startDate formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
-(NSString*)endDate
{
    return  [[_endDate formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
-(NSString*)startTime
{
    return [_startTime substringWithRange:NSMakeRange(0, 5)];
}
-(NSString*)endTime
{
    return [_endTime substringWithRange:NSMakeRange(0, 5)];
}
@end
