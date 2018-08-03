//
//  SC_fangKeModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_fangKeModel.h"
#import "NSString+FBString.h"
#import "WebRequest.h"
@implementation SC_fangKeModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
-(NSString*)iphoto
{
    return [NSString stringWithFormat:@"%@%@",HTTP_PATH,_iphoto];
}
@end
