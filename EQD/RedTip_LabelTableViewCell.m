//
//  RedTip_LabelTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RedTip_LabelTableViewCell.h"
#import <Masonry.h>
@implementation RedTip_LabelTableViewCell
-(UILabel*)L_RedTip
{
    if (!_L_RedTip) {
        _L_RedTip =[[UILabel alloc]init];
        _L_RedTip.backgroundColor =[UIColor redColor];
        _L_RedTip.layer.masksToBounds=YES;
        _L_RedTip.layer.cornerRadius =8;
        _L_RedTip.textAlignment =NSTextAlignmentCenter;
        _L_RedTip.font = [UIFont systemFontOfSize:12];
        _L_RedTip.hidden=YES;
        _L_RedTip.textColor =[UIColor whiteColor];
        [self addSubview:_L_RedTip];
        [_L_RedTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 16));
            make.right.mas_equalTo(self.textLabel.mas_right);
            make.centerY.mas_equalTo(self.mas_centerY);
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
