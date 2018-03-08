//
//  EQD_HtmlTool.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQD_HtmlTool.h"

@implementation EQD_HtmlTool
+(NSString*)getEQDR_ArticleDetailWithId:(NSString*)Id
{
    return [NSString stringWithFormat:@"https://www.eqidd.com/chuangkeApace/html/circleDetails.html?id=%@",Id];
}
+(NSString*)getEQDM_ArticleDetailWithId:(NSString*)Id
{
 return [NSString stringWithFormat:@"https://www.eqidd.com/chuangkeApace/html/circleDetails.html?id=%@",Id];
}
+(NSString*)getEQD_TrainJiLv
{
    return @"https://www.eqidd.com/html/peixun.html";
}
@end
