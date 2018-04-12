//
//  My_BaoXiaoModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "My_BaoXiaoModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation My_BaoXiaoModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"detailList":@"BaoXiaoListDetailModel"};
}
@end
