//
//  MyShouCangModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MyShouCangModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation MyShouCangModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"sourceOwner2":@"sourceOwner"};
}
@end
