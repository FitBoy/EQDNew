//
//  RSCW_baoXiaoModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RSCW_baoXiaoModel.h"
#import "NSString+FBString.h"
@implementation RSCW_baoXiaoModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
