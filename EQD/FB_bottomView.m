//
//  FB_bottomView.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_bottomView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FB_bottomView
-(void)updateZanWithZanArr:(NSArray*)ZanArr
{
    [self setHiddenZan];
    if (ZanArr.count==0) {
        self.IV_zan1.image = [UIImage imageNamed:@"ic_arrow"];
    }else if (ZanArr.count ==1)
    {
        self.IV_zan2.hidden = NO;
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:ZanArr[0]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        self.IV_zan2.image = [UIImage imageNamed:@"ic_arrow"];
    }else if (ZanArr.count == 2)
    {
        self.IV_zan2.hidden = NO;
        self.IV_zan3.hidden = NO;
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:ZanArr[0]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan2 sd_setImageWithURL:[NSURL URLWithString:ZanArr[1]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        self.IV_zan3.image = [UIImage imageNamed:@"ic_arrow"];
    }else if (ZanArr.count == 3)
    {
        self.IV_zan2.hidden = NO;
        self.IV_zan3.hidden = NO;
        self.IV_zan4.hidden = NO;
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:ZanArr[0]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan2 sd_setImageWithURL:[NSURL URLWithString:ZanArr[1]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan3 sd_setImageWithURL:[NSURL URLWithString:ZanArr[2]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        self.IV_zan4.image = [UIImage imageNamed:@"ic_arrow"];
    }else
    {
        
    }
    self.IV_zan.image = [UIImage imageNamed:@"zan_true"];
}
-(void)updateliuyanNum:(NSString*)liuYanNum
{
    self.L_liuyan.text = liuYanNum;
}

-(void)setZan_arr:(NSArray*)zan_arr isZan:(NSString*)isZan zanNum:(NSString*)zanNum liuYanNum:(NSString*)liuYanNum
{
    [self updateZanWithZanArr:zan_arr];
    self.IV_zan.image = [UIImage imageNamed:[isZan integerValue]==0? @"zan_false":@"zan_true"];
    self.L_zan.text = zanNum;
    self.L_liuyan.text = liuYanNum;
    self.IV_liuyan.image = [UIImage imageNamed:@"pinglun"];
}
-(void)setHiddenZan{
    self.IV_zan2.hidden = YES;
    self.IV_zan3.hidden =YES;
    self.IV_zan4.hidden = YES;
}
-(UILabel*)L_zan
{
    if (!_L_zan) {
        _L_zan = [[UILabel alloc]init];
        _L_zan.font = [UIFont systemFontOfSize:12];
        _L_zan.textColor = [UIColor grayColor];
        [self addSubview:_L_zan];
        [_L_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 20));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.IV_liuyan.mas_left).mas_offset(-10);
        }];
    }
    return _L_zan;
}
-(UIImageView*)IV_zan
{
    if (!_IV_zan) {
        _IV_zan = [[UIImageView alloc]init];
        [self addSubview:_IV_zan];
        _IV_zan.userInteractionEnabled =YES;
        _IV_zan.image = [UIImage imageNamed:@"zan_false"];
        [_IV_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.L_zan.mas_left).mas_offset(-5);
        }];
    }
    return _IV_zan;
}
-(UIImageView*)IV_liuyan
{
    if (!_IV_liuyan) {
        _IV_liuyan = [[UIImageView alloc]init];
        _IV_liuyan.userInteractionEnabled =YES;
        _IV_liuyan.image = [UIImage imageNamed:@"pinglun"];
        [self addSubview:_IV_liuyan];
        [_IV_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.L_liuyan.mas_left).mas_offset(-5);
        }];
    }
    return _IV_liuyan;
}
-(UILabel*)L_liuyan
{
    if (!_L_liuyan) {
        _L_liuyan = [[UILabel alloc]init];
        _L_liuyan.font = [UIFont systemFontOfSize:12];
        _L_liuyan.textColor = [UIColor grayColor];
        [self addSubview:_L_liuyan];
        [_L_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 20));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _L_liuyan;
}


-(UIImageView*)IV_zan1
{
    if (!_IV_zan1) {
        _IV_zan1 = [[UIImageView alloc]init];
        [self addSubview:_IV_zan1];
        _IV_zan1.userInteractionEnabled = YES;
        _IV_zan1.layer.masksToBounds =YES;
        _IV_zan1.layer.cornerRadius =15;
        [_IV_zan1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _IV_zan1;
}
-(UIImageView*)IV_zan4
{
    if (!_IV_zan4) {
        _IV_zan4 = [[UIImageView alloc]init];
        [self addSubview:_IV_zan4];
        _IV_zan4.layer.masksToBounds = YES;
        _IV_zan4.layer.cornerRadius = 15;
        [_IV_zan4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.IV_zan3.mas_right).mas_offset(5);
        }];
        
    }
    return _IV_zan4;
}
-(UIImageView*)IV_zan3
{
    if (!_IV_zan3) {
        _IV_zan3 = [[UIImageView alloc]init];
        [self addSubview:_IV_zan3];
        _IV_zan3.layer.masksToBounds = YES;
        _IV_zan3.layer.cornerRadius = 15;
        [_IV_zan3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.IV_zan2.mas_right).mas_offset(5);
        }];
        
    }
    return _IV_zan3;
}
-(UIImageView*)IV_zan2
{
    if (!_IV_zan2) {
        _IV_zan2 = [[UIImageView alloc]init];
        [self addSubview:_IV_zan2];
        _IV_zan2.layer.masksToBounds = YES;
        _IV_zan2.layer.cornerRadius = 15;
        [_IV_zan2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.IV_zan1.mas_right).mas_offset(5);
        }];
        
    }
    return _IV_zan2;
}

@end
