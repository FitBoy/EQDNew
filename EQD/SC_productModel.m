//
//  SC_productModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_productModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation SC_productModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"indexList":@"SC_maiMaiModel"
             };
}
@end
