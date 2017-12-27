//
//  QJCCModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QJCCModel.h"

@implementation QJCCModel
-(NSString*)left0
{
    return [NSString stringWithFormat:@"%@天数范围",self.type];
}
-(NSString*)left1
{
    return @"审批等级";
}
-(NSString*)right0
{
    return [NSString stringWithFormat:@"%@~%@天",self.minTime,self.maxTime];
}
-(NSString*)right1
{
    return [NSString stringWithFormat:@"%@级审批",self.approvalLevel];
}
@end
