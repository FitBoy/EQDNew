//
//  CK_huoDongModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_huoDongModel.h"
#import "NSString+FBString.h"
@implementation CK_huoDongModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
