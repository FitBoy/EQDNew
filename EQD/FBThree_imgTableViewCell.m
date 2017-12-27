//
//  FBThree_imgTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/6.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBThree_imgTableViewCell.h"
#import <Masonry.h>
#import <UIButton+WebCache.h>
@implementation FBThree_imgTableViewCell

-(void)setModel:(FBBaseModel *)model
{
    _model=model;
    self.L_left0.text = model.left0;
    self.L_left1.text=model.left1;
    self.L_right0.text =model.right0;
    [self.B_img sd_setBackgroundImageWithURL:[NSURL URLWithString:model.img_header] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    
    
}
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.height.mas_equalTo(50);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _V_bg;
}
-(UIButton*)B_img
{
    if (!_B_img) {
        _B_img = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.V_bg addSubview:_B_img];
        _B_img.layer.masksToBounds=YES;
        _B_img.layer.cornerRadius=5;
        [_B_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _B_img;
    
}
-(UILabel *)L_left0
{
    if (!_L_left0) {
        _L_left0 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font = [UIFont systemFontOfSize:17];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(22);
            make.top.mas_equalTo(self.V_bg.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.L_right0.mas_left);
            make.left.mas_equalTo(self.B_img.mas_right).mas_offset(5);
        }];
        
        
    }
    return _L_left0;
}
-(UILabel *)L_right0
{
    if (!_L_right0) {
        _L_right0 = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_right0];
        _L_right0.font = [UIFont systemFontOfSize:17];
        _L_right0.textAlignment = NSTextAlignmentRight;
        [_L_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _L_right0;
}
-(UILabel*)L_left1
{
    if (!_L_left1) {
        _L_left1 = [[UILabel alloc]init];
        _L_left1.font = [UIFont systemFontOfSize:12];
        _L_left1.textColor = [UIColor grayColor];
        [self.V_bg addSubview:_L_left1];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.B_img.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.V_bg.mas_bottom).mas_offset(-5);
            make.height.mas_equalTo(18);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _L_left1;
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
