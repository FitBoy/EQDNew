//
//  PXKaoQinListModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/2.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PXKaoQinListModel.h"
#import "NSString+FBString.h"
@implementation PXKaoQinListModel
-(NSString*)signInTime
{
    return [_signInTime formatDateString];
}
@end
