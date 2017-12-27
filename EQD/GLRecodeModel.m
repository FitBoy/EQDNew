//
//  GLRecodeModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GLRecodeModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation GLRecodeModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

-(NSString*)left0
{
    return self.revisitTitle;
}
-(NSString*)left1
{
    return self.revisitDate;
}
-(NSString*)right0
{
    return self.contactsName;
}
-(NSString*)remindTime
{
    return [_remindTime formatDateString];
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
