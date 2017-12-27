//
//  FanKuiRecordModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FanKuiRecordModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation FanKuiRecordModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)fbTime
{
    return [_fbTime formatDateString];
}
-(NSString*)remindTime
{
    return [_remindTime formatDateString];
}
-(NSString*)left0
{
    return self.fbtitle;
}
-(NSString*)left1
{
    return self.fbTime;
}
-(NSString*)right0
{
    return self.fberName;
}
@end
