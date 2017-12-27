//
//  LiZhiModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LiZhiModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation LiZhiModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)left0
{
    return self.creater;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"离职时间:%@",self.quitTime];
}
-(NSString*)right0
{
    return [NSString stringWithFormat:@"%@-%@",self.department,self.post];
}
-(NSString*)right1
{
    return [NSString stringWithFormat:@"离职时间:%@",self.quitTime];
}
-(NSString*)quitTime
{
    return [_quitTime formatdateYearMonth];
}
-(NSString*)joinTime
{
    return [_joinTime formatdateYearMonth];
}

@end
