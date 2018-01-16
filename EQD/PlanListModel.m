//
//  PlanListModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PlanListModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation PlanListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)finishTime
{
    return [_finishTime formatDateString];
}
-(NSString*)publishTime
{
    return [_publishTime formatDateString];
}
@end
