//
//  RuZhiSPModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RuZhiSPModel.h"
#import "NSString+FBString.h"
@implementation RuZhiSPModel
-(NSString*)left0
{
    return self.uname;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"%@-%@",self.departName,self.postName];
}
-(NSString*)img_header
{
    return self.uiphoto;
}
-(NSString*)right1
{
    return [NSString stringWithFormat:@"入职:%@",self.signEntryTime];
}
-(NSString*)right0
{
    return self.userPhone;
}
-(NSString*)signEntryTime
{
    if (_signEntryTime ==nil) {
        return @"未签订劳动合同";
    }else
    {
        return [_signEntryTime formatdateYearMonth];
    }
}
@end
