//
//  EQDM_ArticleModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/24.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDM_ArticleModel.h"
#import "NSString+FBString.h"
@implementation EQDM_ArticleModel
-(NSString*)postTime
{
    return [_postTime formatDateString];
}
@end
