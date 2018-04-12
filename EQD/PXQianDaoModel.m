//
//  PXQianDaoModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/31.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PXQianDaoModel.h"
#import "NSString+FBString.h"
@implementation PXQianDaoModel
-(NSArray*)getStartTimeAndEndTime
{
    NSArray  *tarr = [self.theTrainTime componentsSeparatedByString:@" "];
    if (tarr.count==2) {
        NSArray  *tarr2 =[tarr[1] componentsSeparatedByString:@"~"];
        return @[[NSString stringWithFormat:@"%@ %@",tarr[0],tarr2[0]],[NSString stringWithFormat:@"%@ %@",tarr[0],tarr2[1]]];
    }else
    {
        return @[@"2017-01-01 00:00",@"2018-02-01 00:00"];
    }
}
-(NSString*)courseEndTime
{
    return [_courseEndTime formatDateString];
}
-(NSString*)courseStartTime
{
    return [_courseStartTime formatDateString];
}
-(NSString*)signStartTime
{
    return [_signStartTime formatDateString];
}
-(NSString*)signLaunchTime
{
    return [_signLaunchTime formatDateString];
}
@end
