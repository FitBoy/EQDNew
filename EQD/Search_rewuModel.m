//
//  Search_rewuModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Search_rewuModel.h"
#import <MJExtension.h>
@implementation Search_rewuModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)left0
{
    return self.taskName;
}
-(NSString*)right0
{
    return [NSString stringWithFormat:@"编码:%@",self.taskCode];
}
@end
