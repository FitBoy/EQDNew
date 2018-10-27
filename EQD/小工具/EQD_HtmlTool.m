//
//  EQD_HtmlTool.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQD_HtmlTool.h"

@implementation EQD_HtmlTool

+(NSString*)getHuodongDetailWithId:(NSString*)Id
{
    return [NSString stringWithFormat:@"https://www.eqidd.com/qiyeSpace/html/acticityDetails.html?id=%@",Id];
}
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
+(NSString*)getEQD_ZoneWithid:(NSString*)Id AnduserGuid:(NSString*)userGuid
{
    return [NSString stringWithFormat:@"https://www.eqidd.com/Friend/friend.html?worId=%@&Guid=%@",Id,userGuid];
}

+(NSString*)getCompanyCultrueWithGuid:(NSString*)guid
{
    return [NSString  stringWithFormat:@"https://www.eqidd.com/Friend/html/comCulture.html?guid=%@",guid];
}
+(NSString*)getActiveFromLingdaoWithId:(NSString*)Id
{
    return [NSString stringWithFormat:@"https://www.eqidd.com/qiyeSpace/html/leaderDetdils.html?id=%@",Id];
}

+(NSString*)getProductDetailWithId:(NSString*)Id
{
    
    return [NSString stringWithFormat:@"https://www.eqidd.com/qiyeSpace/html/product.html?id=%@",Id];
}
+(NSString*)getEventDetailWithId:(NSString*)Id
{
    return [NSString stringWithFormat:@"https://www.eqidd.com/qiyeSpace/html/thingDetails.html?id=%@",Id];
}

+(NSString*)getComLinkWithComId:(NSString *)comId
{
    return [NSString stringWithFormat:@"https://www.eqidd.com/qiyeSpace/html/companyIndex.html?id=%@",comId];
}
@end
