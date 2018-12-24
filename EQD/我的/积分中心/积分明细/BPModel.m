//
//  BPModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/11/10.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "BPModel.h"
#import "NSString+FBString.h"
@implementation BPModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
