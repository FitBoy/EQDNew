//
//  FBFour_noimgTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBFour_noimgTableViewCell.h"
#import <Masonry.h>
@implementation FBFour_noimgTableViewCell
-(void)setModel:(FBBaseModel *)model
{
    _model=model;
    self.L_left0.text = model.left0;
    self.L_left1.text=model.left1;
    self.L_right0.text=model.right0;
    self.L_right1.text = model.right1;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(UILabel *)L_left0
{
    if (!_L_left0) {
        _L_left0=[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font =[UIFont systemFontOfSize:17];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(22);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.top.mas_equalTo(self.V_bg.mas_top);
            make.right.mas_equalTo(self.L_right0.mas_left).mas_offset(-5);
        }];

    }
    return _L_left0;
}
-(UILabel *)L_left1
{
    if (!_L_left1) {
        _L_left1 =[[UILabel alloc]init];
        _L_left1.font=[UIFont systemFontOfSize:13];
        _L_left1.textColor=[UIColor grayColor];
        [self.V_bg addSubview:_L_left1];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.height.mas_equalTo(18);
            make.right.mas_equalTo(self.L_right1.mas_left).mas_offset(-5);
            make.bottom.mas_equalTo(self.V_bg.mas_bottom);
        }];
    }
    return _L_left1;
}
-(UILabel *)L_right0
{
    if (!_L_right0) {
        _L_right0 =[[UILabel alloc]init];
        _L_right0.textAlignment=NSTextAlignmentRight;
        _L_right0.font = [UIFont systemFontOfSize:17];
        [self.V_bg addSubview:_L_right0];
        [_L_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(22);
            make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.top.mas_equalTo(self.V_bg.mas_top);
        }];
        
    }
    return _L_right0;
}
-(UILabel *)L_right1
{
    if (!_L_right1) {
        _L_right1 =[[UILabel alloc]init];
        _L_right1.font =[UIFont systemFontOfSize:13];
        _L_right1.textAlignment=NSTextAlignmentRight;
        _L_right1.textColor=[UIColor grayColor];
        [self.V_bg addSubview:_L_right1];
        [_L_right1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(self.L_left1.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.bottom.mas_equalTo(self.V_bg.mas_bottom);
        }];
        
    }
    return _L_right1;
}
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
        _V_bg.userInteractionEnabled=YES;
        [self addSubview:_V_bg];
        
        [_V_bg  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
        }];
        
    }
    return _V_bg;
}
@end
