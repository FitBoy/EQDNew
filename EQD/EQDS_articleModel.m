//
//  EQDS_articleModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/27.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_articleModel.h"
#import "NSString+FBString.h"
@implementation EQDS_articleModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
