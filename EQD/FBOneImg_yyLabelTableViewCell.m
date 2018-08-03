//
//  FBOneImg_yyLabelTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define EQDCOLOR   [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1]

#import "FBOneImg_yyLabelTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBOneImg_yyLabelTableViewCell

-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        [self addSubview:_V_bg];
        _V_bg.userInteractionEnabled =YES;
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return _V_bg;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img =[[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_img];
        _IV_img.userInteractionEnabled = YES;
        _IV_img.layer.masksToBounds =YES;
        _IV_img.layer.cornerRadius =20;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _IV_img;
}
-(YYLabel*)yyL_context
{
    if (!_yyL_context) {
        _yyL_context = [[YYLabel alloc]init];
        _yyL_context.numberOfLines = 0;
        [self.V_bg addSubview:_yyL_context];
    }
    return _yyL_context;
}
-(UIImageView*)IV_choose
{
    if (!_IV_choose) {
        _IV_choose = [[UIImageView alloc]init];
        [self.V_bg addSubview:_IV_choose];
        _IV_choose.userInteractionEnabled = YES;
        [_IV_choose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _IV_choose;
}
-(void)setStatusImg:(NSString*)img context:(NSMutableAttributedString*)context statusName:(NSString*)StatusName
{
    self.IV_choose.hidden =YES;
    self.L_status.text =StatusName;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.yyL_context.attributedText = context;
    CGSize size = [context boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-180, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [self.yyL_context mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
        make.right.mas_equalTo(self.L_status.mas_left).mas_offset(-5);
    }];
}


-(void)setImg:(NSString*)img Context:(NSMutableAttributedString*)context isChoose:(BOOL)isChoose isShow:(BOOL)isshow
{
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.yyL_context.attributedText = context;
    self.L_status.hidden =YES;
    if ( isshow== NO) {
        self.IV_choose.hidden = YES;
        CGSize size = [context boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [self.yyL_context mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+5);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }else
    {
        self.IV_choose.hidden = NO;
        NSString *image = isChoose ==NO?@"shequ_tluntan":@"shequ_landui";
        self.IV_choose.image = [UIImage imageNamed:image];
        CGSize size = [context boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30-40-20-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [self.yyL_context mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+5);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.IV_choose.mas_right).mas_offset(-5);
        }];
    }
}
-(UILabel*)L_status
{
    if (!_L_status) {
        _L_status = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_status];
        _L_status.layer.borderWidth=1;
        _L_status.layer.borderColor = EQDCOLOR.CGColor;
        _L_status.userInteractionEnabled = YES;
        _L_status.text = @"邀请注册";
        [_L_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
    }
    return _L_status;
}
@end
