//
//  FB_CollectionLinkTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_CollectionLinkTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FB_CollectionLinkTableViewCell
-(void)setModel2:(MyShouCangModel *)model
{
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.sourceOwner.avatar] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text = model.sourceOwner.nickname;
    self.L_time.text = model.Collection.createTime;
    NSArray  *tarr = [model.Collection.url componentsSeparatedByString:@";"];
    
    [self.IV_Link sd_setImageWithURL:[NSURL URLWithString:tarr[0]] placeholderImage:[UIImage imageNamed:@"share_lianjie"]];
    self.L_content.text = model.Collection.title;
    self.L_source.text = model.Collection.source;
}
-(void)setModel:(MyShouCangModel *)model
{
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text = model.nickname;
    self.L_time.text = model.createTime;
    [self.IV_Link sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"share_lianjie"]];
    self.L_content.text = model.title;
    self.L_source.text = model.source;
    
}
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        _IV_head.userInteractionEnabled =YES;
        _IV_head.layer.masksToBounds = YES;
        _IV_head.layer.cornerRadius =15;
        [self addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
        }];
    }
    return _IV_head;
}
-(UIImageView*)IV_Link
{
    if (!_IV_Link) {
        _IV_Link = [[UIImageView alloc]init];
        _IV_Link.userInteractionEnabled =YES;
        _IV_Link.layer.masksToBounds =YES;
        _IV_Link.layer.cornerRadius = 5;
        _IV_Link.layer.borderWidth =0.3;
        _IV_Link.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:_IV_Link];
        [_IV_Link mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(5);
        }];
        
    }
    return _IV_Link;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        _L_name.font = [UIFont systemFontOfSize:17];
        [self addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(self.IV_head.mas_centerY);
            make.right.mas_equalTo(self.L_time.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_name;
}
-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time = [[UILabel alloc]init];
        _L_time.font = [UIFont systemFontOfSize:13];
        _L_time.textColor = [UIColor grayColor];
        [self addSubview:_L_time];
        [_L_time  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo (self.IV_head.mas_centerY);
            make.left.mas_equalTo(self.L_name.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _L_time;
}
-(UILabel*)L_content
{
    if (!_L_content) {
        _L_content = [[UILabel alloc]init];
        _L_content.numberOfLines =2;
        _L_content.font = [UIFont systemFontOfSize:17];
//       _L_content.textColor = [UIColor grayColor];
        [self addSubview:_L_content];
        [_L_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.IV_Link.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(5);
        }];
    }
    return _L_content;
}
-(UILabel*)L_source
{
    if (!_L_source) {
        _L_source = [[UILabel alloc]init];
        [self addSubview:_L_source];
        _L_source.textColor = [UIColor grayColor];
        _L_source.font = [UIFont systemFontOfSize:13];
        [_L_source mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _L_source;
}

@end
