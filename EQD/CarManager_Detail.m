//
//  CarManager_Detail.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CarManager_Detail.h"
#import "NSString+FBString.h"
@implementation CarManager_Detail
-(NSString*)purchaseDate
{
    return [_purchaseDate formatdateYearMonth];
}
-(NSString*)insuranceEndDate
{
    return [_insuranceEndDate formatdateYearMonth];
}
-(NSString*)annInspectDate
{
    return [_annInspectDate formatdateYearMonth];
}
@end
