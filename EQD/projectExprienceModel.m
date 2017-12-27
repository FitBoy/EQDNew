//
//  projectExprienceModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "projectExprienceModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation projectExprienceModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)startTime
{
    return [[_startTime formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
-(NSString*)endTime
{
    return [[_endTime formatDateString] substringWithRange:NSMakeRange(0, 10)];
}
-(NSString*)left0
{
    return self.projectName;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"%@~%@",self.startTime,self.endTime];
}
-(BOOL)ischoose
{
    return [self.isOvert integerValue]==0?NO:YES;
}
@end
