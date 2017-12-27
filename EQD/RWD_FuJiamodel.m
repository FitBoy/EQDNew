//
//  RWD_FuJiamodel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RWD_FuJiamodel.h"
#import <MJExtension.h>

@implementation RWD_FuJiamodel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)img_header
{
    return self.headImage;
}
-(NSString*)left0
{
    return self.name;
}
-(NSString*)left1
{
    return [NSString stringWithFormat:@"%@-%@",self.department,self.post];
}
@end
