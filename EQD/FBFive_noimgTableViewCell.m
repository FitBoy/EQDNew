//
//  FBFive_noimgTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBFive_noimgTableViewCell.h"
#import <Masonry.h>
@implementation FBFive_noimgTableViewCell
-(void)setModel:(DaKaJiLu *)model
{
    _model =model;
    
    self.L_left0.text =[NSString stringWithFormat:@"打卡时间:%@",model.createTime];
    self.L_right0.text =[NSString stringWithFormat:@"规定时间:%@",model.clockTime];
    self.L_left1.text =[NSString stringWithFormat:@"打卡wifi:%@",model.WIFIName];
    self.L_bottom.text =model.place;
    if ([model.status integerValue]==0) {
        self.L_right1.textColor=[UIColor blackColor];
        self.L_right1.text =@"正常";
    }else if ([model.status integerValue]==1)
    {
        self.L_right1.textColor =[UIColor redColor];
        self.L_right1.text=@"上班迟到";
    }else if([model.status integerValue]==2)
    {
        self.L_right1.textColor =[UIColor redColor];
        self.L_right1.text =@"下班早退";
    }else
    {
       self.L_right1.textColor=[UIColor blackColor]; 
    }
        
    
}
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        _V_bg.userInteractionEnabled=YES;
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _V_bg;
}
-(UILabel *)L_left0
{
    if (!_L_left0) {
        _L_left0 =[[UILabel alloc]init];
        _L_left0.font =[UIFont systemFontOfSize:15];
        [self.V_bg addSubview:_L_left0];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.top.mas_equalTo(self.V_bg.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.L_right0.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_left0;
}
-(UILabel*)L_right0
{
    if (!_L_right0) {
        _L_right0 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_right0];
        _L_right0.font =[UIFont systemFontOfSize:15];
        _L_right0.textAlignment =NSTextAlignmentRight;
        [_L_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.V_bg.mas_top).mas_offset(5);
            make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _L_right0;
}
-(UILabel*)L_left1
{
    if (!_L_left1) {
        _L_left1 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left1];
        _L_left1.font =[UIFont systemFontOfSize:15];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.top.mas_equalTo(self.L_left0.mas_bottom).mas_offset(5);
            make.right.mas_equalTo(self.L_right1.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_left1;
}
-(UILabel *)L_right1
{
    if (!_L_right1) {
        _L_right1 =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_right1];
        _L_right1.font =[UIFont systemFontOfSize:15];
        _L_right1.textAlignment =NSTextAlignmentRight;
        [_L_right1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.L_left1.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.top.mas_equalTo(self.L_right0.mas_bottom).mas_offset(5);
        }];
        
    }
    return _L_right1;
}
-(UILabel *)L_bottom
{
    if (!_L_bottom) {
        _L_bottom =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_bottom];
        _L_bottom.font =[UIFont systemFontOfSize:13];
        _L_bottom.numberOfLines=2;
        _L_bottom.textColor=[UIColor grayColor];
        [_L_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.right.mas_equalTo(self.V_bg);
            make.bottom.mas_equalTo(self.V_bg.mas_bottom).mas_offset(-5);
        }];
    }
    return _L_bottom;
}
@end
