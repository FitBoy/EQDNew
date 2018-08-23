//
//  SC_productTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#import "SC_productTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation SC_productTableViewCell

-(void)setModel_shoucang:(SC_productModel *)model_product
{
    _model_product = model_product;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_product.productImage]];
    NSMutableAttributedString *productName = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"产品名称：%@\n产品价格：￥%@ 元",model_product.ProductName,model_product.ProductPrice] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]}];
    model_product.cell_height =110;
    self.yl_contents.attributedText = productName;
}
-(void)setModel_product:(SC_productModel *)model_product
{
    _model_product = model_product;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_product.image] placeholderImage:[UIImage imageNamed:@"imageerro"] options:(SDWebImageProgressiveDownload)];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"产品名称：%@\n产品单价：%@元\n发货地址：%@\n",model_product.ProductName,model_product.ProductPrice,model_product.area] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    NSMutableAttributedString *type = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@  ",model_product.ProductType] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    [type yy_setTextBackgroundBorder:[YYTextBorder borderWithFillColor:[UIColor orangeColor] cornerRadius:3] range:type.yy_rangeOfAll];
    [name appendAttributedString:type];
    name.yy_lineSpacing = 4;
    self.yl_contents.attributedText = name;
    model_product.cell_height =110;
}


-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.userInteractionEnabled =YES;
        _IV_img.layer.masksToBounds =YES;
        _IV_img.layer.cornerRadius =6;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
        }];
    }
    return _IV_img;
}

-(YYLabel*)yl_contents
{
    if (!_yl_contents) {
        _yl_contents = [[YYLabel alloc]init];
        [self addSubview:_yl_contents];
        _yl_contents.numberOfLines =0;
        [_yl_contents mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.height.mas_equalTo(100);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _yl_contents;
}

@end
