//
//  FB_shareEQDCollectionViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FB_shareEQDCollectionViewCell.h"
#import <Masonry.h>
@implementation FB_shareEQDCollectionViewCell
-(void)setModel:(FB_ShareModel *)model
{
    self.IV_img.image = [UIImage imageNamed:model.img];
    self.L_name.text = model.name;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.userInteractionEnabled =YES;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-5);
            make.height.mas_equalTo(self.mas_width).mas_offset(-10);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
        }];
        
    }
    return _IV_img;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        _L_name.userInteractionEnabled =YES;
        _L_name.font = [UIFont systemFontOfSize:12];
        _L_name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.right.mas_equalTo(self.IV_img);
            make.top.mas_equalTo(self.IV_img.mas_bottom).mas_equalTo(5);
        }];
        
    }
    return _L_name;
}
@end
