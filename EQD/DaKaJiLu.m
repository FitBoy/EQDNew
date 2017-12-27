//
//  DaKaJiLu.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "DaKaJiLu.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation DaKaJiLu

-(NSString*)clockTime
{
    return [_clockTime substringWithRange:NSMakeRange(0, 5)];
}
-(NSString*)createTime
{
    if (_createTime==nil) {
        return @"未打卡";
    }else
    {
        NSArray *tarr =[_createTime componentsSeparatedByString:@"."];
        NSString *tstr1 =tarr[0];
        NSArray *tarr2 =[tstr1 componentsSeparatedByString:@":"];
        NSString *time =[NSString stringWithFormat:@"%@:%@",tarr2[0],tarr2[1]];
        return time;
    }
}
@end
