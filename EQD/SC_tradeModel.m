//
//  SC_tradeModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_tradeModel.h"
#import "NSString+FBString.h"
@implementation SC_tradeModel
-(NSString*)status
{
    if ([_status integerValue]==-2) {
        return @"未付款";
    }else if ([_status integerValue] == 1 )
    {
        return @"已付款";
    }else
    {
        return @"订单";
    }
}
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
@end
