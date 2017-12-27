//
//  QingJiaDetailModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QingJiaDetailModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation QingJiaDetailModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"QJ_newImages":@"newImages"
             };
}
-(NSString*)leaveStartTime
{
    return [_leaveStartTime formatDateStringWithoutYear];
}
-(NSString*)leaveEndTime
{
    return [_leaveEndTime formatDateStringWithoutYear];
}
@end
