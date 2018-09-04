//
//  FB_oneImgTextBtnTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_oneImgTextBtnTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FB_oneImgTextBtnTableViewCell
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        _IV_img.userInteractionEnabled =YES;
        [self addSubview:_IV_img];
       
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _IV_img;
}
-(YYLabel*)YL_text
{
    if (!_YL_text) {
        _YL_text = [[YYLabel alloc]init];
        _YL_text.numberOfLines= 0;
        [self addSubview:_YL_text];
        
        [_YL_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.B_btn.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _YL_text;
}
-(FBButton*)B_btn
{
    if (!_B_btn) {
        _B_btn = [FBButton buttonWithType:UIButtonTypeSystem];
        _B_btn.layer.borderColor = [UIColor grayColor].CGColor;
        _B_btn.layer.borderWidth = 1;
        [self addSubview:_B_btn];
        [_B_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 30));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
    }
    return _B_btn;
}
-(void)setModel_product:(SC_productModel *)model_product
{
    _model_product = model_product;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_product.image]];
    [self.B_btn setTitle:@"查看产品需求" titleColor:nil backgroundColor:nil font:[UIFont systemFontOfSize:16]];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:model_product.ProductName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    self.YL_text.attributedText = name;
}
@end
