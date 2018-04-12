//
//  commonRenwuModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "commonRenwuModel.h"
#import "NSString+FBString.h"
@implementation commonRenwuModel

-(NSString*)left0
{
    return self.name;
}
-(NSString*)right0
{
    NSMutableString *str =[NSMutableString stringWithString:self.time];
   NSString *tstr= [str stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString *tstr2 =[tstr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSArray *tarr=[tstr2 componentsSeparatedByString:@"."];
    return [NSString stringWithFormat:@"%@ %@",tarr[0],self.status];
}
-(NSString*)left1
{
    
    return [NSString stringWithFormat:@"备注：%@",self.contents];
}
@end
