//
//  RuleTime4Model.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RuleTime4Model.h"
#import "NSString+FBString.h"
@implementation RuleTime4Model
-(NSString*)timeWithdate:(NSString*)time
{
    NSArray *tarr =[time componentsSeparatedByString:@":"];
    NSString *tstr =nil;
    if (tarr.count>1) {
        tstr =[NSString stringWithFormat:@"%@:%@",tarr[0],tarr[1]];
    }
    return tstr;
}
-(NSString*)StartTime1
{
    return [self timeWithdate:_StartTime1];
}
-(NSString*)StartTime2
{
    return [self timeWithdate:_StartTime2];
}
-(NSString*)StartTime3
{
    return [self timeWithdate:_StartTime3];
}
-(NSString*)StartTime4
{
    return [self timeWithdate:_StartTime4];
}
-(NSString*)EndTime1
{
    return [self timeWithdate:_EndTime1];
}
-(NSString*)EndTime2
{
    return [self timeWithdate:_EndTime2];
}
-(NSString*)EndTime3
{
    return [self timeWithdate:_EndTime3];
}
-(NSString*)EndTime4
{
    return [self timeWithdate:_EndTime3];
}
@end
