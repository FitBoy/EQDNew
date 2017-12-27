//
//  FBOne_img2TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBOne_img2TableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBOne_img2TableViewCell
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
        }];
        
    }
    return _V_bg;
}
-(UILabel *)L_left0
{
    if (!_L_left0) {
        _L_left0=[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font = [UIFont  systemFontOfSize:18];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.IV_img.mas_left);
        }];
        
    }
    return _L_left0;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_img];
        _IV_img.layer.masksToBounds =YES;
        _IV_img.layer.cornerRadius=20;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _IV_img;
}
-(void)setModel:(FBBaseModel *)model
{
    _model =model;
    self.L_left0.text =model.left0;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model.img_header] placeholderImage:[UIImage imageNamed:@"eqd"]];
    
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
