//
//  Repair_ListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Repair_ListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation Repair_ListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)when
{
    return [_when formatDateString];
}

-(NSString*)left0
{
    return self.plateNumber;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"费用:%@元",self.cost];
}
-(NSString*)right0
{
    return  [NSString stringWithFormat:@"保养/维修人:%@",self.agent];
}
-(NSString*)right1
{
    return [NSString stringWithFormat:@"保养/维修时间:%@",self.when];
}
@end
