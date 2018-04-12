//
//  ImgScrollTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "ImgScrollTableViewCell.h"
#import <Masonry.h>
@implementation ImgScrollTableViewCell
-(FBImgsScrollView*)imgScrollV
{
    if (!_imgScrollV) {
        _imgScrollV = [[FBImgsScrollView alloc]init];
        [self addSubview:_imgScrollV];
    }
    return _imgScrollV;
}
-(void)setarr_stringimgs:(NSArray*)arr_stringImgs WithHeight:(float)height
{
    self.imgScrollV.frame = CGRectMake(0, 0, DEVICE_WIDTH, height);
    [self.imgScrollV setArr_stringImgs:arr_stringImgs Withsize:CGSizeMake(height-10, height-10)];    
}

@end
