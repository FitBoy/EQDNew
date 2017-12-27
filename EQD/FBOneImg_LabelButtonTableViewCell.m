//
//  FBOneImg_LabelButtonTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBOneImg_LabelButtonTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBOneImg_LabelButtonTableViewCell
-(UIImageView*)IV_headimg
{
    if (!_IV_headimg) {
        _IV_headimg =[[UIImageView alloc]init];
        [self addSubview:_IV_headimg];
        _IV_headimg.layer.masksToBounds=YES;
        _IV_headimg.layer.cornerRadius = 20;
        _IV_headimg.userInteractionEnabled =YES;
        [_IV_headimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
        }];
        
    }
    return _IV_headimg;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.userInteractionEnabled =YES;
        _L_name.font = [UIFont systemFontOfSize:17];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.B_btn.mas_left).mas_offset(-5);
        }];
    }
    return _L_name;
}
-(FBButton*)B_btn
{
    if (!_B_btn) {
        _B_btn = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_btn];
        [_B_btn setTitle:@"+ 关注" titleColor:[UIColor whiteColor] backgroundColor:[UIColor greenColor] font:[UIFont systemFontOfSize:17]];
        _B_btn.layer.borderColor =[UIColor grayColor].CGColor;
        _B_btn.layer.borderWidth=1;
        [_B_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _B_btn;
}

-(void)setModel:(EQDR_MyAttentionModel *)model
{
    [self.IV_headimg sd_setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text =model.upname;
    if ([model.isguanzhu integerValue]==1) {
          [self.B_btn setTitle:@"已关注" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17]];
    }else
    {
          [self.B_btn setTitle:@"+ 关注" titleColor:[UIColor whiteColor] backgroundColor:[UIColor greenColor] font:[UIFont systemFontOfSize:17]];
    }
  
    
    
}

-(void)setModel2:(EQDR_MyAttentionModel *)model
{
    [self.IV_headimg sd_setImageWithURL:[NSURL URLWithString:model.createriphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text =model.createrupname;
    if ([model.isAttention integerValue]==1) {
        [self.B_btn setTitle:@"互相关注" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17]];
    }else
    {
        [self.B_btn setTitle:@"+ 关注" titleColor:[UIColor whiteColor] backgroundColor:[UIColor greenColor] font:[UIFont systemFontOfSize:17]];
    }
}
@end
