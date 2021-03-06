//
//  FBTwo_noimg12TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTwo_noimg12TableViewCell.h"
#import <Masonry.h>
@implementation FBTwo_noimg12TableViewCell

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

-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 = [[UILabel alloc]init];
        _L_left0.font = [UIFont systemFontOfSize:17];
        [self.V_bg addSubview:_L_left0];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.L_right0.mas_left);
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
        _L_right0.numberOfLines=2;
        _L_right0.textColor =[UIColor grayColor];
        [_L_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.left.mas_equalTo(self.L_left0.mas_right);
        }];
        
    }
    return _L_right0;
}
-(void)setModel:(FBBaseModel *)model
{
    _model=model;
    self.L_left0.text=model.left0;
    self.L_right0.text=model.right0;
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
