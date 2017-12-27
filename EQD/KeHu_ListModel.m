//
//  KeHu_ListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "KeHu_ListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation KeHu_ListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

-(NSString*)left0
{
    return self.cusName;
}
-(NSString*)left1
{
    return self.cusType;
}
-(NSString*)right0
{
    return self.cusCall;
}
-(NSString*)right1
{
    return self.salesTerritory;
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
