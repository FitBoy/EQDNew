//
//  FBLabel_YYAddTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBLabel_YYAddTableViewCell.h"
@implementation FBLabel_YYAddTableViewCell

-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:12];
        _L_name.textColor = [UIColor grayColor];
        _L_name.frame = CGRectMake(10, 5, DEVICE_WIDTH-20, 15);
    }
    return _L_name;
}
-(YYLabel*)YL_content
{
    if (!_YL_content) {
        _YL_content = [[YYLabel alloc]init];
        [self addSubview:_YL_content];
        _YL_content.numberOfLines =0;
        _YL_content.font = [UIFont systemFontOfSize:17];
        
    }
    return _YL_content;
}

@end
