//
//  FBThree_noimg112TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBThree_noimg112TableViewCell.h"
#import <Masonry.h>
@implementation FBThree_noimg112TableViewCell
-(void)setModel:(FBBaseModel *)model{
    _model=model;
    self.L_right.text = model.right0;
    self.L_left0.text =model.left0;
    self.L_left1.text =model.left1;
}
-(UIView *)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
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

-(UILabel *)L_right
{
    if (!_L_right) {
        _L_right =[[UILabel alloc]init];
        _L_right.textAlignment =NSTextAlignmentRight;
        _L_right.textColor =[UIColor grayColor];
        _L_right.font =[UIFont systemFontOfSize:17];
        _L_right.userInteractionEnabled =YES;
        [self.V_bg addSubview:_L_right];
        [_L_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 30));
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _L_right;
}
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.userInteractionEnabled =YES;
        _L_left0.font =[UIFont systemFontOfSize:17];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.L_right.mas_left).mas_offset(-5);
            make.top.mas_equalTo(self.V_bg.mas_top);
        }];
        
    }
    return _L_left0;
}
-(UILabel *)L_left1
{
    if (!_L_left1) {
        _L_left1 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left1];
        _L_left1.textColor=[UIColor grayColor];
        _L_left1.font =[UIFont systemFontOfSize:13];
        _L_left1.userInteractionEnabled=YES;
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.L_right.mas_left).mas_offset(5);
            make.bottom.mas_equalTo(self.V_bg.mas_bottom);
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
