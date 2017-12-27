//
//  GangweiModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GangweiModel.h"
#import <MJExtension.h>
@implementation GangweiModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
}
-(void)setDeid:(NSString *)deid
{
    _deid=self.departid=deid;
}


@end
