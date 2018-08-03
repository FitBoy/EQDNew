//
//  TiaoGangListModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "TiaoGangListModel.h"
#import "NSString+FBString.h"
@implementation TiaoGangListModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
-(NSString*)implementTime
{
    return [_implementTime formatDateString];
}
@end
