//
//  FBWorkCircleLinkTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/31.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBWorkCircleLinkTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBWorkCircleLinkTableViewCell

-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        _V_bg.userInteractionEnabled = YES;
        _V_bg.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
        [self addSubview:_V_bg];
        
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.height.mas_equalTo(60);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _V_bg;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        _IV_img.userInteractionEnabled =YES;
        [self.V_bg addSubview:_IV_img];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.V_bg.mas_left).mas_offset(5);
        }];
        
    }
    return _IV_img;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        _L_name.userInteractionEnabled =YES;
        _L_name.lineBreakMode = NSLineBreakByTruncatingTail;
        _L_name.font = [UIFont systemFontOfSize:18];
        [self.V_bg addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_bg.mas_right).mas_offset(-5);
        }];
        
    }
    return _L_name;
}

-(void)setimg:(NSString*)img name:(NSString*)name  placehoderImage:(NSString*)imgname
{
    imgname =(imgname == nil?@"share_lianjie":imgname);
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:imgname]];
    self.L_name.text = name;
}

@end
