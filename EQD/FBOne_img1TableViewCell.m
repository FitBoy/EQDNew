//
//  FBOne_img1TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/5.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBOne_img1TableViewCell.h"
#import <Masonry.h>
#import <UIButton+WebCache.h>
@implementation FBOne_img1TableViewCell

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
-(FBButton*)B_img
{
    if (!_B_img) {
        _B_img =[FBButton buttonWithType:UIButtonTypeSystem];
        [self.V_bg addSubview:_B_img];
        _B_img.layer.masksToBounds=YES;
        _B_img.layer.cornerRadius=20;
        [_B_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _B_img;
}
-(UILabel *)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_name];
        _L_name.font =[UIFont systemFontOfSize:17];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.B_img.mas_right).mas_offset(5);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _L_name;
}
-(void)setModel:(FBBaseModel *)model
{
    _model=model;
    [self.B_img sd_setBackgroundImageWithURL:[NSURL URLWithString:model.img_header] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"qun"]];
    self.L_name.text = model.left0;
}


@end
