//
//  CarUseModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CarUseModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation CarUseModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)startTime
{
    return [_startTime formatDateString];
}
-(NSString*)endTime
{
    return [_endTime formatDateString];
}
-(NSString*)left0
{
    return self.plateNumber;
}
-(NSString*)left1
{
    return self.applyerName;
}
-(NSString*)right0{
    return self.destination;
}
-(NSString*)right1
{
    return self.createTime;
}
@end
