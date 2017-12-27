//
//  ShenPiListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ShenPiListModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation ShenPiListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)left0
{
    return self.uname==nil?self.username:self.uname;
}
-(NSString*)right0
{
    if ([self.status integerValue]==-1) {
        return @"未审批";
    }
    else
    {
    return [self.status integerValue]==1?@"已拒绝":@"已同意";
    }
}
-(NSString*)left1
{
    return self.message;
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
