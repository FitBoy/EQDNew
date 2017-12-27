//
//  FBBanBieTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBanBieTableViewCell.h"
#import <Masonry.h>
@implementation FBBanBieTableViewCell
-(void)setModel:(BanbieModel *)model
{
    _model =model;
    self.L_name.text = model.ruleName;
    self.L_time.text =model.ruleDescribe;
    self.L_week.text =model.weeks;
    self.L_holidays.text =model.Holidays;
    self.L_shuoming.text =@"节假日为上班的节假日(没有是节假日不用上班)";
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name =[[UILabel alloc]init];
        _L_name.font =[UIFont systemFontOfSize:17];
//        _L_name.textAlignment =NSTextAlignmentCenter;
        [self.V_bg addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.left.right.top.mas_equalTo(self.V_bg);
        }];
        
    }
    return _L_name;
}
-(UILabel *)L_time
{
    if (!_L_time) {
        _L_time =[[UILabel alloc]init];
        _L_time.font =[UIFont systemFontOfSize:13];
        _L_time.textColor =[UIColor grayColor];
        [self.V_bg addSubview:_L_time];
        
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.right.mas_equalTo(self.V_bg);
            make.top.mas_equalTo(self.L_name.mas_bottom).mas_offset(5);
        }];
        
    }
    return _L_time;
}
-(UILabel *)L_week
{
    if (!_L_week) {
        _L_week =[[UILabel alloc]init];
        _L_week.font =[UIFont systemFontOfSize:13];
        _L_week.textColor =[UIColor grayColor];
        [self.V_bg addSubview:_L_week];
        [_L_week mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.right.mas_equalTo(self.V_bg);
            make.top.mas_equalTo(self.L_time.mas_bottom).mas_offset(5);
    
        }];
        
        
    }
    return _L_week;
}
-(UILabel*)L_holidays
{
    if (!_L_holidays) {
        _L_holidays =[[UILabel alloc]init];
        _L_holidays.font =[UIFont systemFontOfSize:13];
        _L_holidays.textColor =[UIColor grayColor];
        [self.V_bg addSubview:_L_holidays];
        [_L_holidays mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.right.mas_equalTo(self.V_bg);
            make.top.mas_equalTo(self.L_week.mas_bottom).mas_offset(5);

        }];
        
    }
    return _L_holidays;
}
-(UILabel *)L_shuoming
{
    if (!_L_shuoming) {
        _L_shuoming =[[UILabel alloc]init];
        _L_shuoming.font =[UIFont systemFontOfSize:13];
        _L_shuoming.textColor =[UIColor greenColor];
        [self.V_bg addSubview:_L_shuoming];
        [_L_shuoming mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.right.mas_equalTo(self.V_bg);
            make.top.mas_equalTo(self.L_holidays.mas_bottom).mas_offset(5);

        }];
        
    }
    return _L_shuoming;
}

-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
        _V_bg.layer.masksToBounds=YES;
        _V_bg.layer.cornerRadius=6;
        _V_bg.layer.borderWidth=2;
        _V_bg.layer.borderColor=[UIColor blueColor].CGColor;
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(130);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
            
        }];
        
    }
    return _V_bg;
}
@end
