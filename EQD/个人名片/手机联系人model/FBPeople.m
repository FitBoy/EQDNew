//
//  FBPeople.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBPeople.h"

@implementation FBPeople
-(NSString*)isZhuCe
{
    if (_userGuid.length==0) {
        return @"0";
    }else
    {
        return @"1";
    }
}


@end
