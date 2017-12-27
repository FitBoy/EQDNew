//
//  FBImageVCollectionViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBImageVCollectionViewCell.h"

@implementation FBImageVCollectionViewCell
-(void)setModel:(FBTextImgModel *)model
{
    self.imgV.image=model.image;
    _model = model;
    
}
-(UIImageView *)imgV
{
    if (!_imgV) {
        NSInteger width =(DEVICE_WIDTH-60)/3;
        _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
        [self addSubview:_imgV];
    }
    return _imgV;
}
@end
