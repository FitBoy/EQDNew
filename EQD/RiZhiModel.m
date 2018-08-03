//
//  RiZhiModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RiZhiModel.h"
#import "NSString+FBString.h"
@implementation RiZhiModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
