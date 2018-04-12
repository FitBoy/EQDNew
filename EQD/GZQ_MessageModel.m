//
//  GZQ_MessageModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "GZQ_MessageModel.h"
#import "NSString+FBString.h"
@implementation GZQ_MessageModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
@end
