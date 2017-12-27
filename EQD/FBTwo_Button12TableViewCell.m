//
//  FBTwo_Button12TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTwo_Button12TableViewCell.h"
#import <Masonry.h>
@implementation FBTwo_Button12TableViewCell

-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
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
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_name];
        _L_name.font =[UIFont systemFontOfSize:18];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.V_bg.mas_top).mas_offset(5);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.B_add.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_name;
}
-(UILabel *)L_number
{
    if (!_L_number) {
        _L_number =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_number];
        _L_number.font=[UIFont systemFontOfSize:13];
        _L_number.textColor=[UIColor grayColor];
        [_L_number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.bottom.mas_equalTo(self.V_bg.mas_bottom).mas_offset(-5);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.right.mas_equalTo(self.B_add.mas_left).mas_offset(-5);
        }];
    }
    return _L_number;
}
-(UIButton*)B_add
{
    if (!_B_add) {
        _B_add = [FBIndexPathButton buttonWithType:UIButtonTypeSystem];
        _B_add.titleLabel.font=[UIFont systemFontOfSize:17];
        [self.V_bg addSubview:_B_add];
        _B_add.layer.masksToBounds=YES;
        _B_add.layer.cornerRadius=10;
        [_B_add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-5);
        }];
        
    }
    return _B_add;
}
-(void)setModel:(FBPeople *)model
{
    //shequ_landui  shequ_tluntan
    _model=model;
    self.L_name.text=model.name;
    
   
    if ([model.status integerValue]<2) {
        self.B_add.enabled=YES;
        [self.B_add setBackgroundImage:[UIImage imageNamed:@"shequ_tluntan"] forState:UIControlStateNormal];
        self.L_number.text=model.phone;
          }
    else if([model.status integerValue]==5)
    {
        self.B_add.enabled=YES;
        [self.B_add setBackgroundImage:[UIImage imageNamed:@"shequ_landui"] forState:UIControlStateNormal];
      self.L_number.text=model.phone;
    }
    else
    {
        self.B_add.enabled=NO;
        [self.B_add setBackgroundImage:nil forState:UIControlStateNormal];
        NSArray *tarr = @[@"已在企业",@"在别企业",@"已被邀请"];
        NSInteger  temp=[model.status integerValue]-2;
        self.L_number.text=[NSString stringWithFormat:@"%@(%@)",model.phone,tarr[temp]];
    }
   }

@end
