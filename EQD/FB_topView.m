//
//  FB_topView.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_topView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FB_topView

-(void)setHead:(NSString*)Head name:(NSString*)name bumen:(NSString*)bumen time:(NSString*)time
{
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:Head] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_bumen.text = bumen;
    self.L_time.text =time;
    self.L_name.text = name;
}

-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        _IV_head.userInteractionEnabled = YES;
        [self addSubview:_IV_head];
        _IV_head.layer.masksToBounds = YES;
        _IV_head.layer.cornerRadius =20;
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
        }];
    }
    return _IV_head;
}
-(UIImageView*)IV_fenxiang
{
    if (!_IV_fenxiang) {
        _IV_fenxiang = [[UIImageView alloc]init];
        _IV_fenxiang.userInteractionEnabled =YES;
        _IV_fenxiang.image = [UIImage imageNamed:@"ic_arrow"];
        _IV_fenxiang.transform = CGAffineTransformMakeRotation(M_PI_2);
        [self addSubview:_IV_fenxiang];
        [_IV_fenxiang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_centerY).mas_offset(-25);
        }];
    }
    return _IV_fenxiang;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:17];
        [_L_name mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
            make.top.mas_equalTo(self.mas_centerY).mas_offset(-25);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.IV_fenxiang.mas_left).mas_offset(-5);
        }];
    }
    return _L_name;
}
-(UILabel*)L_bumen
{
    if (!_L_bumen) {
        _L_bumen = [[UILabel alloc]init];
        _L_bumen.font = [UIFont systemFontOfSize:13];
        _L_bumen.textColor = [UIColor grayColor];
        [self addSubview:_L_bumen];
        [_L_bumen mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.bottom.mas_equalTo(self.mas_centerY).mas_offset(25);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.L_time.mas_left).mas_offset(-5);
        }];
    }
    return _L_bumen;
}
-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time = [[UILabel alloc]init];
        _L_time.textColor = [UIColor grayColor];
        _L_time.font = [UIFont systemFontOfSize:13];
        _L_time.textAlignment = NSTextAlignmentRight;
        [self addSubview:_L_time];
        [_L_time mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.left.mas_equalTo(self.L_bumen.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.mas_centerY).mas_offset(25);
        }];
        
    }
    return _L_time;
}
@end
