//
//  liZhiListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "liZhiListModel.h"
#import <MJExtension.h>
@implementation liZhiListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)left0
{
    return self.staffName;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"备注:%@",self.message];
}
-(NSString*)right0
{
    return @"已同意";
}
@end
