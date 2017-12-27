//
//  HeTong_ListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "HeTong_ListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation HeTong_ListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)left0
{
    return [NSString stringWithFormat:@"签订人:%@",self.signatory];
}
-(NSString*)left1
{
    return [self.createTime formatDateString];
}
-(NSString*)right0
{
     return [NSString stringWithFormat:@"发起人:%@",self.creater];
}
-(NSString*)right1
{
   return [NSString stringWithFormat:@"编码:%@",self.contractCode];
}
@end
