//
//  FBone_SwitchTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBone_SwitchTableViewCell.h"
#import <Masonry.h>
@implementation FBone_SwitchTableViewCell
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
    }
    return _V_bg;
}
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font=[UIFont systemFontOfSize:18];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.S_kaiguan.mas_left);
        }];
        
    }
    return _L_left0;
}
-(UISwitch*)S_kaiguan
{
    if (!_S_kaiguan) {
        _S_kaiguan=[[UISwitch alloc]init];
        [self.V_bg addSubview:_S_kaiguan];
        [_S_kaiguan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 30));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _S_kaiguan;
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
