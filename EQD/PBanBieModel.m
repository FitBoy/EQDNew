//
//  PBanBieModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PBanBieModel.h"
#import <MJExtension.h>
@implementation PBanBieModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"times":@"StartEndModel"};
}

@end
@implementation StartEndModel

-(NSString*)startTime
{
    return [_startTime substringWithRange:NSMakeRange(0, 5)];
}
-(NSString*)endTime
{
    return [_endTime substringWithRange:NSMakeRange(0, 5)];
}

@end
