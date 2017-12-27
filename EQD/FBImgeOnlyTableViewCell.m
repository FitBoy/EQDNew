//
//  FBImgeOnlyTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBImgeOnlyTableViewCell.h"
#import <Masonry.h>
@implementation FBImgeOnlyTableViewCell

-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img =[[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.userInteractionEnabled=YES;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH-30, (DEVICE_WIDTH-30)/2.0));
        }];
    }
    return _IV_img;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
