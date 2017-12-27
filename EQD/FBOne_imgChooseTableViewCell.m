//
//  FBOne_imgChooseTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBOne_imgChooseTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBOne_imgChooseTableViewCell
-(void)setModel:(FBBaseModel *)model
{
    _model =model;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model.img_header] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_left0.text =model.left0;
    if (model.ischoose==NO) {
        self.IV_choose.image=[UIImage imageNamed:@"shequ_tluntan"];
    }
    else
    {
        self.IV_choose.image=[UIImage imageNamed:@"shequ_landui"];
    }
    
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
        _IV_choose=[[UIImageView alloc]init];
        _IV_choose.userInteractionEnabled =YES;
        [self.V_bg addSubview:_IV_choose];
        _IV_choose.image =[UIImage imageNamed:@"shequ_tluntan"];
        [_IV_choose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            
        }];
    }
    return _IV_choose;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img =[[UIImageView alloc]init];
        _IV_img.userInteractionEnabled =YES;
        _IV_img.layer.masksToBounds=YES;
        _IV_img.layer.cornerRadius=20;
        [self.V_bg addSubview:_IV_img];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
    }
    return _IV_img;
}
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 =[[UILabel alloc]init];
        _L_left0.font =[UIFont systemFontOfSize:17];
        [self.V_bg addSubview:_L_left0];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
}
    return _L_left0;
}

@end
