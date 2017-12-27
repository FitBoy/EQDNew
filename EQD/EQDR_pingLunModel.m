//
//  EQDR_pingLunModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_pingLunModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation EQDR_pingLunModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"list":@"EQDR_pingLunModel"};
}
-(NSString*)createTime{
    return [_createTime datefromDatestring];
}
-(NSMutableArray*)arr_muList
{
    return [NSMutableArray arrayWithArray:self.list];
}
@end
