//
//  RecordListModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RecordListModel.h"
#import "NSString+FBString.h"
@implementation RecordListModel
-(NSString*)CreateTime
{
    return [_CreateTime formatDateString];
}
@end
