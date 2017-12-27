//
//  ChuChai_ListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ChuChai_ListModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation ChuChai_ListModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
