//
//  BanbieModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BanbieModel.h"

@implementation BanbieModel
-(NSString*)left0
{
    return [NSString stringWithFormat:@"%@-%@",self.ruleName,self.shiftName];
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"工作日:%@-%@",self.Holidays,self.weeks];
}

@end
