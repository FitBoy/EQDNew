//
//  InsuranceModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "InsuranceModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation InsuranceModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)theDate
{
    return [_theDate formatdateYearMonth];
}
-(NSString*)left0
{
    return self.plateNumber;
}
-(NSString*)left1
{
    return self.InsuranceCompany;
}
-(NSString*)right0
{
    return [NSString stringWithFormat:@"经办人:%@",self.agent];
}
@end
