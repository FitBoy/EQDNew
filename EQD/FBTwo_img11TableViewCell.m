//
//  FBTwo_img11TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTwo_img11TableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBTwo_img11TableViewCell

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
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        _IV_img.userInteractionEnabled=YES;
        [self.V_bg addSubview:_IV_img];
        _IV_img.layer.masksToBounds=YES;
        _IV_img.layer.cornerRadius=20;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _IV_img;
    
}
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_left0];
        _L_left0.font = [UIFont  systemFontOfSize:15];
        
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.IV_img.mas_top);
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
        _L_left1.font = [UIFont systemFontOfSize:13];
        _L_left1.textColor = [UIColor grayColor];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(10);
            make.bottom.mas_equalTo(self.IV_img.mas_bottom);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _L_left1;
}
-(void)setModel:(FBBaseModel *)model
{
    _model=model;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model.img_header]  placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_left0.text = model.left0;
    self.L_left1.text = model.left1;
}

-(void)setMode_caigou:(FX_personModel*)mode_caigou
{
    _mode_caigou = mode_caigou;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:mode_caigou.iphoto]  placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_left0.text = mode_caigou.staffName;
    self.L_left1.text = [NSString stringWithFormat:@"%@-%@",mode_caigou.department,mode_caigou.post];
    
}
-(void)setModel_techerInfo:(EQDS_teacherInfoModel *)model_techerInfo
{
    _model_techerInfo = model_techerInfo;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_techerInfo.headimage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_left0.text = [NSString stringWithFormat:@"%@ [%@]",model_techerInfo.realname,model_techerInfo.city];
    NSArray *tarr = [model_techerInfo.ResearchField componentsSeparatedByString:@","];
    NSMutableAttributedString *label = [[NSMutableAttributedString alloc]initWithString:@""];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString  *tlabel=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"[%@]",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"  "];
        [tlabel appendAttributedString:kong];
        [label appendAttributedString:tlabel];
    }
    self.L_left1.numberOfLines =2;
    self.L_left1.attributedText = label;
    model_techerInfo.cellHeight =60;
    
}
@end
