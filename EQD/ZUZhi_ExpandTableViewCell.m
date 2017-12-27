//
//  ZUZhi_ExpandTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ZUZhi_ExpandTableViewCell.h"
#import <Masonry.h>
@implementation ZUZhi_ExpandTableViewCell
-(void)setModel:(ZuZhiModel *)model
{
    _model =model;
    self.L_name.text =model.departName;
//    self.IV_choose.image=model.isChoose==0? [UIImage imageNamed:@"shequ_tluntan"]:[UIImage imageNamed:@"shequ_landui"];
    self.IV_choose.hidden=YES;
    [self.IV_icon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(15*model.flag);
    }];
}
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        _V_bg.userInteractionEnabled=YES;
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
-(UIImageView*)IV_choose
{
    if (!_IV_choose) {
        _IV_choose =[[UIImageView alloc]init];
        _IV_choose.userInteractionEnabled=YES;
        _IV_choose.image =[UIImage imageNamed:@"shequ_tluntan"];
        [self.V_bg addSubview:_IV_choose];
        [_IV_choose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _IV_choose;
}
-(UIImageView*)IV_icon
{
    if (!_IV_icon) {
        _IV_icon =[[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_icon];
        _IV_icon.image =[UIImage imageNamed:@"eqd_arrow_right"];
        _IV_icon.transform=CGAffineTransformMakeRotation(M_PI_2);
        [_IV_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.V_bg.mas_left);
        }];
        
    }
    return _IV_icon;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_name];
        _L_name.font =[UIFont systemFontOfSize:15];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IV_icon.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.IV_choose.mas_left).mas_offset(-5);
            make.height.mas_equalTo(30);
        }];
        
    }
    return _L_name;
}

@end
