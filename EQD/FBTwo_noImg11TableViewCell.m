//
//  FBTwo_noImg11TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTwo_noImg11TableViewCell.h"
#import <Masonry.h>
@implementation FBTwo_noImg11TableViewCell

-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
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
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font=[UIFont systemFontOfSize:17];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(22);
            make.top.mas_equalTo(self.V_bg.mas_top).mas_offset(5);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _L_left0;
}
-(UILabel*)L_left1
{
    if (!_L_left1) {
        _L_left1 = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left1];
        _L_left1.font=[UIFont systemFontOfSize:13];
        _L_left1.textColor =[UIColor grayColor];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(18);
            make.bottom.mas_equalTo(self.V_bg.mas_bottom).mas_offset(-5);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
    }
    return _L_left1;
}
-(void)setModel:(FBBaseModel *)model
{
    _model =model;
    self.L_left0.text =model.left0;
    self.L_left1.text=model.left1;
    
}
@end
