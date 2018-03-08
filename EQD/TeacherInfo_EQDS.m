//
//  TeacherInfo_EQDS.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "TeacherInfo_EQDS.h"
#import "NSString+FBString.h"
@implementation TeacherInfo_EQDS
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)updateTime
{
    return [_updateTime formatDateString];
}
@end
