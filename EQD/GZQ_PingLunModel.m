//
//  GZQ_PingLunModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GZQ_PingLunModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation GZQ_PingLunModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"list":@"GZQ_PingLunModel"};
}
-(NSString*)CreateTime
{
    return [_CreateTime datefromDatestring];
}
@end
