//
//  SC_needModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_needModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation SC_needModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"indexList":@"SC_maiMaiModel"
             };
}
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
-(NSString*)EndTime
{
    return [_EndTime formatdateYearMonth];
}
-(NSString*)end_status
{
    NSDateFormatter  *dateforMatter = [[NSDateFormatter alloc]init];
    [dateforMatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateforMatter dateFromString:self.EndTime];
    if ( [[date earlierDate:[NSDate date]] isEqualToDate:date]) {
        return @"进行中";
    }else
    {
        return @"已结束";
    }
    
    
}
@end
