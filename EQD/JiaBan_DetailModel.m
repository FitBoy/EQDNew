//
//  JiaBan_DetailModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "JiaBan_DetailModel.h"
#import "NSString+FBString.h"
@implementation JiaBan_DetailModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)startOverTime
{
    return [_startOverTime formatDateString];
}
-(NSString*)endOverTime
{
    return [_endOverTime formatDateString];
}
@end
