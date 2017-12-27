//
//  FBThree_noimg122TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBThree_noimg122TableViewCell.h"
#import <Masonry.h>
@implementation FBThree_noimg122TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(FBBaseModel *)model
{
    _model=model;
    self.L_left.text =model.left0;
    self.L_right0.text =model.right0;
    self.L_right1.text =model.right1;
    
}

-(UILabel *)L_left
{
    if (!_L_left) {
        _L_left =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left];
        _L_left.font =[UIFont systemFontOfSize:17];
        [_L_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.L_right0.mas_left).mas_offset(-5);
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _L_left;
}
-(UILabel *)L_right0
{
    if (!_L_right0) {
        
        _L_right0 =[[UILabel alloc]init];
        _L_right0.textAlignment =NSTextAlignmentRight;
        _L_right0.font =[UIFont systemFontOfSize:13];
        _L_right0.textColor=[UIColor grayColor];
        [self.V_bg addSubview:_L_right0];
        [_L_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.L_left.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.V_bg.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _L_right0;
}
-(UILabel *)L_right1
{
    if (!_L_right1) {
        
        _L_right1 =[[UILabel alloc]init];
        _L_right1.textAlignment=NSTextAlignmentRight;
        _L_right1.font=[UIFont systemFontOfSize:13];
        _L_right1.textColor=[UIColor grayColor];
        [self.V_bg addSubview:_L_right1];
        [_L_right1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.L_left.mas_right).mas_offset(5);
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
        _V_bg.userInteractionEnabled =YES;
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self addSubview:_V_bg];
        
    }
    return _V_bg;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
