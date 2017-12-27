//
//  QuanXianSheZhiTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QuanXianSheZhiTableViewCell.h"
#import <Masonry.h>
@implementation QuanXianSheZhiTableViewCell
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        _V_bg.userInteractionEnabled=YES;
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
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0=[[UILabel alloc]init];
        _L_left0.font =[UIFont systemFontOfSize:17];
        [self.V_bg addSubview:_L_left0];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.L_right0.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_left0;
}
-(UILabel*)L_right0
{
    if (!_L_right0) {
        _L_right0 =[[UILabel alloc]init];
        _L_right0.font =[UIFont systemFontOfSize:17];
        _L_right0.textAlignment =NSTextAlignmentRight;
        [self.V_bg addSubview:_L_right0];
        [_L_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.B_right0.mas_left).mas_offset(-5);
            make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _L_right0;
}
-(FBButton*)B_right0
{
    if (!_B_right0) {
        _B_right0 =[FBButton buttonWithType:UIButtonTypeSystem];
        [_B_right0 setTitle:@"修改" titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1] font:[UIFont systemFontOfSize:17]];
        [self.V_bg addSubview:_B_right0];
        [_B_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _B_right0;
}

@end
