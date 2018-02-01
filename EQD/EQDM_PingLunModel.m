//
//  EQDM_PingLunModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDM_PingLunModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation EQDM_PingLunModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"SonCmets":@"EQDM_PingLunModel"};
}
@end
