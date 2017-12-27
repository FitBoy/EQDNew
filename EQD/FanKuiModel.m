//
//  FanKuiModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FanKuiModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation FanKuiModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)createTime
{
    return  [_createTime formatDateString];
}
@end
