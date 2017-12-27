//
//  RenWu_DetailModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RenWu_DetailModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation RenWu_DetailModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"RS_newAssist":@"newAssist",
             @"RS_newChecker":@"newChecker",
             @"RS_newInitiator":@"newInitiator",
             @"RS_newNotify":@"newNotify",
             @"RS_newRecipient":@"newRecipient"
             };
    
}
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"RS_newAssist":@"RWD_FuJiamodel",
             @"RS_newNotify":@"RWD_FuJiamodel",
             };
    
}
-(NSString*)CompleteTime
{
    return [_CompleteTime formatDateString];
}
@end
