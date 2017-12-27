//
//  EQDR_articleListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_articleListModel.h"
#import "NSString+FBString.h"
@implementation EQDR_articleListModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
-(NSString*)source
{
    if ([_source integerValue]==0) {
        return @"创客空间";
    }else if ([_source integerValue]==1)
    {
        return @"企业空间";
    }else
    {
        return @"未知空间";
    }
}
@end
