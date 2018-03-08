//
//  EQDS_VideoTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/27.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define EQDCOLOR   [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1]

#import "EQDS_VideoTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation EQDS_VideoTableViewCell
-(void)setModel:(EQDS_VideoModel *)model
{
    _model =model;
    self.L_time.text = model.videoTime;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model.videoImage] placeholderImage:[UIImage imageNamed:@"imageerro"]];
    self.L_name.text = model.videoTitle;
    NSArray *tarr = [model.label componentsSeparatedByString:@","];
    NSMutableAttributedString *label = [[NSMutableAttributedString alloc]initWithString:@""];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *tlabel = [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        [tlabel yy_setTextHighlightRange:tlabel.yy_rangeOfAll color:[UIColor orangeColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate respondsToSelector:@selector(getlabel:WithModel:)]) {
                [self.delegate getlabel:tarr[i] WithModel:model];
            }
        }];
        [tlabel yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:tlabel.yy_rangeOfAll];
        [label appendAttributedString:tlabel];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [label appendAttributedString:kong];
    }
    label.yy_lineSpacing = 4;
    self.YL_label.attributedText =label;
    
}

-(void)setModel2:(EQDS_VideoModel *)model
{
    _model =model;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model.lectVideoImage] placeholderImage:[UIImage imageNamed:@"imageerro"]];
    self.L_time.text = model.videoTime;
    self.L_name.text = model.lectVideoTitle;
    NSArray *tarr = [model.lectVideoType componentsSeparatedByString:@","];
    NSMutableAttributedString *label = [[NSMutableAttributedString alloc]initWithString:@""];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *tlabel = [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        [tlabel yy_setTextHighlightRange:tlabel.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate respondsToSelector:@selector(getlabel:WithModel:)]) {
                [self.delegate getlabel:tarr[i] WithModel:model];
            }
        }];
        [tlabel yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:tlabel.yy_rangeOfAll];
        [label appendAttributedString:tlabel];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [label appendAttributedString:kong];
    }
    label.yy_lineSpacing = 4;
    self.YL_label.attributedText =label;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img =[[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.userInteractionEnabled =YES;
        _IV_img.layer.masksToBounds=YES;
        _IV_img.layer.cornerRadius =4;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 84));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _IV_img;
}
-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time = [[UILabel alloc]init];
        [self.IV_img addSubview:_L_time];
        _L_time.textColor = [UIColor whiteColor];
        _L_time.font = [UIFont systemFontOfSize:15];
        _L_time.textAlignment = NSTextAlignmentRight;
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.right.mas_equalTo(self.IV_img.mas_right).mas_offset(-5);
            make.bottom.mas_equalTo(self.IV_img.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _L_time;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:17];
        _L_name.numberOfLines =2;
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.right.mas_equalTo(self.mas_right).mas_offset(-10);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_img.mas_top);
        }];
    }
    return _L_name;
}

-(YYLabel*)YL_label
{
    if (!_YL_label) {
        _YL_label =[[YYLabel alloc]init];
        [self addSubview:_YL_label];
        _YL_label.font = [UIFont systemFontOfSize:13];
        _YL_label.numberOfLines=2;
        [_YL_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-10);
            make.bottom.mas_equalTo(self.IV_img.mas_bottom);
        }];
    }
    return _YL_label;
}
@end
