//
//  QingJiaListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QingJiaListModel.h"
#import <MJExtension.h>
#import "NSString+FBString.h"
@implementation QingJiaListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
            @"ID":@"id"
             };
}

-(NSString*)left0
{
    return self.leaveType;
}
-(NSString*)right0
{
    return [self.createTime formatDateString];
}


@end
