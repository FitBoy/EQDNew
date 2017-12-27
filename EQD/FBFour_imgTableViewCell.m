//
//  FBFour_imgTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBFour_imgTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBFour_imgTableViewCell
-(void)setModel:(FBBaseModel *)model
{
    _model =model;
    [self.IV_header sd_setImageWithURL:[NSURL URLWithString:model.img_header] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    
    self.L_left0.text =model.left0;
    self.L_left1.text =model.left1;
    self.L_right0.text =model.right0;
    self.L_right1.text=model.right1;
}
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _V_bg;
}
-(UIImageView*)IV_header
{
    if (!_IV_header) {
        _IV_header =[[UIImageView alloc]init];
        _IV_header.userInteractionEnabled=YES;
        _IV_header.layer.masksToBounds=YES;
        _IV_header.layer.cornerRadius=20;
        [self.V_bg addSubview:_IV_header];
        [_IV_header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.V_bg.mas_left);
        }];
        
    }
    return _IV_header;
}
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font=[UIFont systemFontOfSize:17];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.left.mas_equalTo(self.IV_header.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_header.mas_top);
            make.right.mas_equalTo(self.L_right0.mas_left).mas_offset(-5);
        }];
        
    }
     return  _L_left0;
}
-(UILabel*)L_left1
{
    if (!_L_left1) {
        _L_left1 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left1];
        _L_left1.font =[UIFont systemFontOfSize:13];
        _L_left1.textColor =[UIColor grayColor];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(self.IV_header.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.IV_header.mas_bottom);
            make.right.mas_equalTo(self.L_right1.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_left1;
}

-(UILabel*)L_right0
{
    if (!_L_right0) {
        _L_right0 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_right0];
        _L_right0.font = [UIFont systemFontOfSize:17];
        _L_right0.textAlignment=NSTextAlignmentRight;
        [_L_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.top.mas_equalTo(self.IV_header.mas_top);
            make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
        }];
        
    }
    return _L_right0;
}

-(UILabel*)L_right1
{
    if (!_L_right1) {
        _L_right1 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_right1];
        _L_right1.font =[UIFont systemFontOfSize:13];
        _L_right1.textColor=[UIColor grayColor];
        [_L_right1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.left.mas_equalTo(self.L_left1.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.IV_header.mas_bottom);
        }];
        
    }
    return _L_right1;
}
@end
