//
//  PX_courseManageModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PX_courseManageModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation PX_courseManageModel
-(NSString*)createTime
{
    return  [_createTime formatDateString];
}
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"posts2":@"posts"};
}
@end
