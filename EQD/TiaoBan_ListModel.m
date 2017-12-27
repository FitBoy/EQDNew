//
//  TiaoBan_ListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TiaoBan_ListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation TiaoBan_ListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

-(NSString*)left0
{
    return self.changeShiftName;
}
-(NSString*)right0
{
    return [self.createTime formatDateString];
}
@end
