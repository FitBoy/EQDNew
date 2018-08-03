//
//  SC_maiMaiModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_maiMaiModel.h"
#import "NSString+FBString.h"
@implementation SC_maiMaiModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
@end
