//
//  TiaoXiu_DetailModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TiaoXiu_DetailModel.h"
#import "NSString+FBString.h"
@implementation TiaoXiu_DetailModel
-(NSString*)planStartTime
{
    return [_planStartTime formatDateString];
}
-(NSString*)planEndTime
{
    return [_planEndTime formatDateString];
}
-(NSString*)offStartTime
{
    return [_offStartTime formatDateString];
}
-(NSString*)offEndTime
{
    return [_offEndTime formatDateString];
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
