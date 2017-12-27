//
//  DaKaJiLuModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "DaKaJiLuModel.h"
#import <MJExtension.h>
@implementation DaKaJiLuModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"list":@"DaKaJiLu"};
}
-(NSString*)date
{
    NSMutableString *date2 =[[NSMutableString alloc]initWithString:_date];
  NSString *date3=[date2 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    return date3;
    
}
@end
