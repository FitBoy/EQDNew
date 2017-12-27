//
//  FBKongjianTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBKongjianTableViewCell.h"
#import <Masonry.h>
@implementation FBKongjianTableViewCell
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _V_bg;
}
-(UIButton*)B_headimg
{
    if (!_B_headimg) {
        _B_headimg =[UIButton buttonWithType:UIButtonTypeSystem];
        [self.V_bg addSubview:_B_headimg];
        _B_headimg.layer.masksToBounds=YES;
        _B_headimg.layer.cornerRadius=20;
        [_B_headimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.top.mas_equalTo(self.V_bg.mas_top);
        }];
        
    }
    return _B_headimg;
}
-(UILabel *)L_left0
{
    if (!_L_left0) {
        _L_left0 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font=[UIFont systemFontOfSize:17];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.B_headimg.mas_right).mas_offset(5);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.V_bg.mas_top);
            ///可以根据添加的View来调整
            make.right.mas_equalTo(self.V_bg.mas_right);
            
        }];
        
    }
    return _L_left0;
}
-(UILabel *)L_left1
{
    if (!_L_left1) {
        _L_left1 = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left1];
        _L_left1.font=[UIFont systemFontOfSize:13];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.B_headimg.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.B_headimg.mas_bottom);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _L_left1;
}
-(UILabel*)L_contents
{
    if (!_L_contents) {
        _L_contents = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_contents];
        _L_contents.font = [UIFont systemFontOfSize:15];
        _L_contents.numberOfLines=4;
        [_L_contents mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.height.mas_equalTo(80);
            make.top.mas_equalTo(self.B_headimg.mas_bottom).mas_offset(5);
        }];
    }
    return _L_contents;
    
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
