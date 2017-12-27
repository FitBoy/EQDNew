//
//  AccidentModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/6.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "AccidentModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation AccidentModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}


-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)theTime
{
    return [_theTime formatDateString];
}
-(NSString*)left0
{
    return self.plateNumber;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"费用(元):%@",self.cost];
}
-(NSString*)right0
{
    return [NSString stringWithFormat:@"责任人:%@",self.personLiableName];
}
-(NSString*)right1
{
    return [NSString stringWithFormat:@"事故时间:%@",self.theTime];
}
@end
