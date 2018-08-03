//
//  WS_ArticleComModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/2.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "WS_ArticleComModel.h"
#import <MJExtension.h>
@implementation WS_ArticleComModel
+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"ComGoodStaff":@"SC_TeamModel",
             @"ComCoreValues":@"Image_textModel",
             @"ComActitivies":@"Image_textModel",
             @"ComEvent":@"Image_textModel"
             };
}
@end
