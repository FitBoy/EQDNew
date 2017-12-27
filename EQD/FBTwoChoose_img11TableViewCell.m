//
//  FBTwoChoose_img11TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTwoChoose_img11TableViewCell.h"
#import <Masonry.h>
#import <UIButton+WebCache.h>
@implementation FBTwoChoose_img11TableViewCell
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _V_bg;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_img];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _IV_img;
}
-(UIButton*)B_img
{
    if (!_B_img) {
        _B_img = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.V_bg addSubview:_B_img];
        _B_img.layer.masksToBounds=YES;
        _B_img.layer.cornerRadius=20;
        [_B_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(5);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _B_img;
    
}
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font = [UIFont  systemFontOfSize:17];
        
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(22);
            make.left.mas_equalTo(self.B_img.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.B_img.mas_top);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-30);
        }];
    }
    return _L_left0;
}
-(UILabel *)L_left1
{
    if (!_L_left1) {
        _L_left1 = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left1];
        _L_left1.font = [UIFont systemFontOfSize:13];
        _L_left1.textColor = [UIColor grayColor];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(self.B_img.mas_right).mas_offset(10);
            make.bottom.mas_equalTo(self.B_img.mas_bottom);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-30);
        }];
        
    }
    return _L_left1;
}
-(void)setModel:(FBBaseModel *)model
{
    _model=model;
    [self.B_img sd_setBackgroundImageWithURL:[NSURL URLWithString:model.img_header] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_left0.text = model.left0;
    self.L_left1.text = model.left1;
    if (model.ischoose==NO) {
        self.IV_img.image = [UIImage imageNamed:@"shequ_tluntan"];
    }
    else
    {
        self.IV_img.image = [UIImage imageNamed:@"shequ_landui"];
    }
    
}

@end
