//
//  TiaoXiu_listModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TiaoXiu_listModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation TiaoXiu_listModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)planEndTime
{
    return [_planEndTime formatDateStringWithoutYear];
}
-(NSString*)planStartTime
{
    return [_planStartTime formatDateStringWithoutYear];
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
