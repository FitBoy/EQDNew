//
//  PXNeedModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PXNeedModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation PXNeedModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)lecturerSexdes
{
    NSArray *tarr = @[@"不限",@"男",@"女"];
    return tarr[[self.lecturerSex integerValue]];
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)thedateStart
{
    return [_thedateStart formatdateYearMonth];
}
-(NSString*)thedateEnd
{
    return [_thedateEnd formatdateYearMonth];
}
@end
