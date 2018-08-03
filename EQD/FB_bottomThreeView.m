//
//  FB_bottomThreeView.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
// read zan_false zan_true  pinglun

#import "FB_bottomThreeView.h"
#import <Masonry.h>
@implementation FB_bottomThreeView
-(void)setread:(NSString*)read liuyan:(NSString*)liuyan zan:(NSString*)zan{
   
    self.L_read.text =[read integerValue]==0?@"阅读":read;
    self.L_liuyan.text = [liuyan integerValue]==0?@"评论":liuyan;
    self.L_zan.text = [zan integerValue]==0?@"点赞":zan;
    self.IV_zan.image = [UIImage imageNamed:@"zan_false"];
}
-(UIImageView*)IV_read
{
    if (!_IV_read) {
        _IV_read = [[UIImageView alloc]init];
        [self addSubview:_IV_read];
        _IV_read.image = [UIImage imageNamed:@"read"];
        _IV_read.userInteractionEnabled =YES;
        [_IV_read mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
        }];
        
    }
    return _IV_read;
}
-(UILabel*)L_read
{
    if (!_L_read) {
        _L_read = [[UILabel alloc]init];
        [self addSubview:_L_read];
        _L_read.userInteractionEnabled = YES;
        _L_read.textColor = [UIColor grayColor];
        _L_read.font = [UIFont systemFontOfSize:13];
        [_L_read mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.left.mas_equalTo(self.IV_read.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _L_read;
}

-(UILabel*)L_zan

{
    if (!_L_zan) {
        _L_zan = [[UILabel alloc]init];
        [self addSubview:_L_zan];
        _L_zan.font = [UIFont systemFontOfSize:13];
        _L_zan.textColor = [UIColor grayColor];
        [_L_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _L_zan;
}

-(UIImageView*)IV_zan
{
    if (!_IV_zan) {
        _IV_zan= [[UIImageView alloc]init];
        [self addSubview:_IV_zan];
        _IV_zan.userInteractionEnabled =YES;
        _IV_zan.image = [UIImage imageNamed:@"zan_false"];
        [_IV_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.mas_equalTo(self.L_zan.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _IV_zan;
}

-(UIImageView*)IV_liuyan
{
    if (!_IV_liuyan) {
        _IV_liuyan = [[UIImageView alloc]init];
        [self addSubview:_IV_liuyan];
        _IV_liuyan.userInteractionEnabled =YES;
        _IV_liuyan.image = [UIImage imageNamed:@"pinglun"];
        [_IV_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_centerX).mas_offset(-40);
        }];
        
    }
    return _IV_liuyan;
}
-(UILabel*)L_liuyan
{
    if (!_L_liuyan) {
        _L_liuyan = [[UILabel alloc]init];
        [self addSubview:_L_liuyan];
        _L_liuyan.font = [UIFont systemFontOfSize:13];
        _L_liuyan.textColor = [UIColor grayColor];
        [_L_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.left.mas_equalTo(self.IV_liuyan.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _L_liuyan;
}
@end
