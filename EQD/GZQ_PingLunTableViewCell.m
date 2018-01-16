//
//  GZQ_PingLunTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define EQDCOLOR   [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1]

#import "GZQ_PingLunTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "NSString+FBString.h"
@implementation GZQ_PingLunTableViewCell
-(UILabel*)L_more
{
    if (!_L_more) {
        _L_more = [[UILabel alloc]init];
        _L_more.text = @"查看更多评论";
        _L_more.textColor = EQDCOLOR;
        _L_more.textAlignment = NSTextAlignmentRight;
        _L_more.userInteractionEnabled =YES;
        [self addSubview:_L_more];
    }
    return _L_more;
}
-(YYLabel*)yyL_fuwenben
{
    if (!_yyL_fuwenben) {
        _yyL_fuwenben =[[YYLabel alloc]init];
        _yyL_fuwenben.font=[UIFont systemFontOfSize:13];
        _yyL_fuwenben.numberOfLines=0;
        [self.V_bg addSubview:_yyL_fuwenben];
    }
    return _yyL_fuwenben;
}
-(UIImageView*)IV_liuyan
{
    if (!_IV_liuyan) {
        _IV_liuyan =[[UIImageView alloc]init];
        [self.V_top addSubview:_IV_liuyan];
        _IV_liuyan.layer.masksToBounds=YES;
        _IV_liuyan.layer.cornerRadius=12;
        _IV_liuyan.userInteractionEnabled=YES;
        _IV_liuyan.image=[UIImage imageNamed:@"pinglun"];
        [_IV_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.right.mas_equalTo(self.V_top.mas_right);
            make.top.mas_equalTo(self.IV_head.mas_top);
        }];
    }
    return _IV_liuyan;
}
-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time =[[UILabel alloc]init];
        [self.V_top addSubview:_L_time];
        _L_time.textColor =[UIColor grayColor];
        _L_time.font=[UIFont systemFontOfSize:13];
        _L_time.textAlignment=NSTextAlignmentRight;
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(self.V_top.mas_right);
            make.left.mas_equalTo(self.L_bumen.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.IV_head.mas_bottom);
        }];
        
    }
    return _L_time;
}
-(UILabel*)L_bumen
{
    if (!_L_bumen) {
        _L_bumen =[[UILabel alloc]init];
        [self.V_top addSubview:_L_bumen];
        _L_bumen.textColor =[UIColor grayColor];
        _L_bumen.font =[UIFont systemFontOfSize:13];
        [_L_bumen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.IV_head.mas_bottom);
            make.right.mas_equalTo(self.L_time.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_bumen;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name=[[UILabel alloc]init];
        _L_name.userInteractionEnabled=YES;
        [self.V_top addSubview:_L_name];
        _L_name.font =[UIFont systemFontOfSize:17];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_head.mas_top);
            make.right.mas_equalTo(self.IV_liuyan.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_name;
}
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head =[[UIImageView alloc]init];
        _IV_head.layer.masksToBounds=YES;
        _IV_head.layer.cornerRadius=20;
        _IV_head.userInteractionEnabled=YES;
        [self.V_top addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_top.mas_left);
            make.centerY.mas_equalTo(self.V_top.mas_centerY);
        }];
        
    }
    return _IV_head;
}
-(UILabel*)L_contents
{
    if (!_L_contents) {
        _L_contents =[[UILabel alloc]init];
        _L_contents.numberOfLines=0;
        _L_contents.font =[UIFont systemFontOfSize:15];
        _L_contents.userInteractionEnabled=YES;
        [self.V_bg addSubview:_L_contents];
        
    }
    return _L_contents;
}

-(UIView*)V_top
{
    if (!_V_top) {
        _V_top=[[UIView alloc]init];
        [self.V_bg addSubview:_V_top];
        [_V_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.top.left.right.mas_equalTo(self.V_bg);
        }];
        
    }
    return _V_top;
}
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _V_bg;
}
-(void)setModel:(GZQ_PingLunModel *)model{
    _model=model;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text =model.staffName==nil?model.upname:model.staffName;
    if (model.departName==nil) {
        self.L_bumen.text = nil;
    }else
    {
    self.L_bumen.text =[NSString stringWithFormat:@"%@-%@",model.departName,model.postName];
    }
    self.L_time.text =model.CreateTime;
    self.L_contents.text =model.Message;
   
    self.yyL_fuwenben.attributedText =nil;
    self.L_more.hidden =YES;
}




@end
