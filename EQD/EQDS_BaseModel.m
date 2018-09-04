//
//  EQDS_BaseModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_BaseModel.h"
#import "NSString+FBString.h"
@implementation EQDS_BaseModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
