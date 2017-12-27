//
//  ChanceSaleModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ChanceSaleModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation ChanceSaleModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)remindTime
{
    return [_remindTime formatDateString];
}
-(NSString*)left0
{
    return self.chanceName;
}
-(NSString*)left1
{
    return self.chanceClassify;
}
-(NSString*)right0
{
    return self.contactsName;
}
@end
