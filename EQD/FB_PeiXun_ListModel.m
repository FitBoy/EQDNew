//
//  FB_PeiXun_ListModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_PeiXun_ListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation FB_PeiXun_ListModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"checkList":@"ShenPIList2Model"};
}
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

-(NSString*)thedateStart
{
    return [_thedateStart  formatdateYearMonth];
}
-(NSString*)thedateEnd
{
    return [_thedateEnd formatdateYearMonth];
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
