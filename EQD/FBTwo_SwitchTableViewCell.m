//
//  FBTwo_SwitchTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTwo_SwitchTableViewCell.h"
#import <Masonry.h>
@implementation FBTwo_SwitchTableViewCell

-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        _V_bg.userInteractionEnabled=YES;
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _V_bg;
}
-(UILabel*)L_left0
{
    if(!_L_left0)
    {
        _L_left0 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font =[UIFont systemFontOfSize:17];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(21);
            make.top.left.mas_equalTo(self.V_bg);
            make.right.mas_equalTo(self.S_kai.mas_left).mas_offset(-5);
        }];
    }
    return _L_left0;
}
-(UILabel*)L_left1
{
    if(!_L_left1)
    {
        _L_left1 = [[UILabel alloc]init];
        _L_left1.numberOfLines=0;
        [self.V_bg addSubview:_L_left1];
        _L_left1.font = [UIFont systemFontOfSize:12];
        _L_left1.textColor = [UIColor grayColor];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(29);
            make.left.bottom.mas_equalTo(self.V_bg);
            make.right.mas_equalTo(self.S_kai.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_left1;
}
-(FBindexPathSwitch*)S_kai
{
    if(!_S_kai)
    {
        _S_kai = [[FBindexPathSwitch alloc]init];
        [self.V_bg addSubview:_S_kai];
        [_S_kai mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 30));
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
    }
    return _S_kai;
}
-(void)setModel:(FBBaseModel *)model
{
    self.L_left0.text =model.left0;
    self.L_left1.text =model.left1;
    self.S_kai.on = model.ischoose;
}

@end
