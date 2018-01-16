//
//  PX_NotificationListModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PX_NotificationListModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation PX_NotificationListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
