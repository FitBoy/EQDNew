//
//  Image_textModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Image_textModel.h"
#import "NSString+FBString.h"
@implementation Image_textModel
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
