//
//  EQDR_articleListModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_articleListModel.h"
#import "NSString+FBString.h"
@implementation EQDR_articleListModel
-(NSString*)createTime
{
    return [_createTime datefromDatestring];
}
-(NSString*)content
{
    NSString *tstr =  [_content stringByReplacingOccurrencesOfString:@"<pre>" withString:@""];
    return [tstr stringByReplacingOccurrencesOfString:@"</pre>" withString:@""];
}
-(NSString*)source
{
    if ([_source integerValue]==0) {
        self.sourceNumber = 0;
        return @"创客空间";
    }else if ([_source integerValue]==1)
    {
        self.sourceNumber =1;
        return @"企业空间";
    }else
    {
        self.sourceNumber =9;
        return @"未知空间";
    }
}
@end
