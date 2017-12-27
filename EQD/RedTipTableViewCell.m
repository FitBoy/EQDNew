//
//  RedTipTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/6.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RedTipTableViewCell.h"
#import <Masonry.h>

@implementation RedTipTableViewCell

-(UILabel*)L_RedTip
{
    if (!_L_RedTip) {
        _L_RedTip =[[UILabel alloc]init];
        _L_RedTip.backgroundColor =[UIColor redColor];
        _L_RedTip.layer.masksToBounds=YES;
        _L_RedTip.layer.cornerRadius =8;
        _L_RedTip.font = [UIFont systemFontOfSize:12];
        _L_RedTip.textAlignment =NSTextAlignmentCenter;
        _L_RedTip.textColor = [UIColor whiteColor];
        [self addSubview:_L_RedTip];
        [_L_RedTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 16));
            make.bottom.mas_equalTo(self.imageView.mas_top).mas_offset(8);
            make.left.mas_equalTo(self.imageView.mas_right).mas_offset(-12);
        }];
    }
    return _L_RedTip;
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
