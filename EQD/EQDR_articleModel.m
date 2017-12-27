//
//  EQDR_articleModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_articleModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation EQDR_articleModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return  @{@"ID":@"id"};
}
-(NSString*)createrTime
{
    return [_createrTime formatDateString];
}

-(NSString*)left0
{
    return self.title;
}
-(NSString*)right1
{
    return self.createrTime;
}
@end
