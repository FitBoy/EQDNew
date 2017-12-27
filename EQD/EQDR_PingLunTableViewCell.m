//
//  EQDR_PingLunTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//55 +5

#import "EQDR_PingLunTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation EQDR_PingLunTableViewCell
-(void)setModel:(EQDR_pingLunModel *)model
{
    _model =model;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_time.text  = model.createTime;
    NSString  *zanname = [model.isZan integerValue]==0?@"zan_false":@"zan_ture";
    self.IV_zan.image = [UIImage imageNamed:zanname];
    self.L_liuyan.text = model.commentCount;
    self.L_zan.text =model.zanCount;
    
}
-(UIView*)V_top
{
    if (!_V_top) {
        _V_top =[[UIView alloc]init];
        _V_top.userInteractionEnabled = YES;
        [self addSubview:_V_top];
        [_V_top  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
        }];
        
    }
    return _V_top;
}
-(UIImageView *)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        [self.V_top addSubview:_IV_head];
        _IV_head.layer.masksToBounds = YES;
        _IV_head.layer.cornerRadius =15;
        _IV_head.userInteractionEnabled = YES;
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(self.V_top.mas_left);
            make.centerY.mas_equalTo(self.V_top.mas_centerY);
        }];
        
    }
    return _IV_head;
}
-(YYLabel*)YL_name
{
    if (!_YL_name) {
        _YL_name = [[YYLabel alloc]init];
        [self.V_top addSubview:_YL_name];
        [_YL_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.V_top.mas_top).mas_offset(5);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.IV_liuyan.mas_left).mas_offset(-5);
        }];
        
    }
    return _YL_name;
}
-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time = [[UILabel alloc]init];
        [self.V_top addSubview:_L_time];
        _L_time.textColor = [UIColor grayColor];
        _L_time.font = [UIFont systemFontOfSize:12];
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.V_top.mas_bottom).mas_offset(-5);
            make.width.mas_equalTo(160);
        }];
        
    }
    return _L_time;
}
-(UIImageView*)IV_liuyan
{
    if (!_IV_liuyan) {
        _IV_liuyan = [[UIImageView alloc]init];
        _IV_liuyan.image = [UIImage imageNamed:@"pinglun.png"];
        _IV_liuyan.userInteractionEnabled =YES;
        [self.V_top addSubview:_IV_liuyan];
        [_IV_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.top.mas_equalTo(self.V_top.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.IV_zan.mas_left).mas_offset(-20);
        }];
        
        
    }
    return _IV_liuyan;
}
-(UILabel*)L_liuyan
{
    if (!_L_liuyan) {
        _L_liuyan = [[UILabel alloc]init];
        [self.V_top addSubview:_L_liuyan];
        _L_liuyan.font = [UIFont systemFontOfSize:12];
        _L_liuyan.textColor = [UIColor grayColor];
        _L_liuyan.textAlignment =NSTextAlignmentCenter;
        [_L_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 20));
            make.centerX.mas_equalTo(self.IV_liuyan.mas_centerX);
            make.bottom.mas_equalTo(self.V_top.mas_bottom).mas_offset(-5);
        }];
        
        
    }
    return _L_liuyan;
}
-(UIImageView*)IV_zan
{
    if (!_IV_zan) {
        _IV_zan = [[UIImageView alloc]init];
        [self.V_top addSubview:_IV_zan];
        _IV_zan.userInteractionEnabled =YES;
        [_IV_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.mas_equalTo(self.V_top.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.V_top.mas_top).mas_offset(5);
        }];
        
    }
    return _IV_zan;
}
-(UILabel*)L_zan
{
    if (!_L_zan) {
        _L_zan = [[UILabel alloc]init];
        [self.V_top addSubview:_L_zan];
        _L_zan.textAlignment =NSTextAlignmentCenter;
        _L_zan.textColor = [UIColor grayColor];
        _L_zan.font = [UIFont systemFontOfSize:12];
        [_L_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 20));
            make.centerX.mas_equalTo(self.IV_zan.mas_centerX);
            make.bottom.mas_equalTo(self.V_top.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _L_zan;
}
-(YYLabel*)YL_content
{
    if (!_YL_content) {
        _YL_content = [[YYLabel alloc]init];
        _YL_content.numberOfLines=0;
        [self addSubview:_YL_content];
    }
    return _YL_content;
}
-(YYLabel*)YL_pinglunContent
{
    if (!_YL_pinglunContent) {
        _YL_pinglunContent = [[YYLabel alloc]init];
        _YL_pinglunContent.numberOfLines =0;
        [self addSubview:_YL_pinglunContent];
    }
    return _YL_pinglunContent;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
