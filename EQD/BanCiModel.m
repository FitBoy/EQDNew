//
//  BanCiModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BanCiModel.h"

@implementation BanCiModel
-(NSString*)left0
{
    return self.shiftName;
}
-(NSString*)left1
{
    NSMutableString  *tsrt =[NSMutableString stringWithFormat:@"%@-%@",self.startTime1,self.endTime1];
    if (![self.startTime2 isEqualToString:@"00:00"] && ![self.endTime2 isEqualToString:@"00:00"]) {
        [tsrt appendFormat:@"    %@-%@",self.startTime2,self.endTime2];
    }
    if (![self.startTime3 isEqualToString:@"00:00"] && ![self.endTime3 isEqualToString:@"00:00"]) {
        [tsrt appendFormat:@"    %@-%@",self.startTime3,self.endTime3];
    }
    if (![self.startTime4 isEqualToString:@"00:00"] && ![self.endTime4 isEqualToString:@"00:00"]) {
        [tsrt appendFormat:@"    %@-%@",self.startTime4,self.endTime4];
    }
    return tsrt;
}
-(NSString*)timeWithdate:(NSString*)time
{
    NSArray *tarr =[time componentsSeparatedByString:@":"];
    NSString *tstr =nil;
    if (tarr.count>1) {
        tstr =[NSString stringWithFormat:@"%@:%@",tarr[0],tarr[1]];
    }
    return tstr;
}
-(NSString*)startTime1
{
   return [self timeWithdate:_startTime1];
}
-(NSString*)startTime2
{
    return [self timeWithdate:_startTime2];
}
-(NSString*)startTime3
{
    return [self timeWithdate:_startTime3];
}
-(NSString*)startTime4
{
    return [self timeWithdate:_startTime4];
}
-(NSString*)endTime1
{
    return [self timeWithdate:_endTime1];
}-(NSString*)endTime2
{
    return [self timeWithdate:_endTime2];
}
-(NSString*)endTime3
{
    return [self timeWithdate:_endTime3];
}
-(NSString*)endTime4
{
    return [self timeWithdate:_endTime4];
}

@end
