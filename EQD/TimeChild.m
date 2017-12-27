//
//  TimeChild.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TimeChild.h"

@implementation TimeChild
-(NSString*)time_type
{
    return [NSString stringWithFormat:@"%@:%@  ",[self.type integerValue]==0?@"上班":@"下班",self.time];
}
@end
