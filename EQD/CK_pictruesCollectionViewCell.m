//
//  CK_pictruesCollectionViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_pictruesCollectionViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation CK_pictruesCollectionViewCell
-(void)setModel_mulu:(PhotoModel *)model_mulu
{
    _model_mulu = model_mulu;
    [self.IV_image sd_setImageWithURL:[NSURL URLWithString:model_mulu.imageUrl] placeholderImage:[UIImage imageNamed:@"EQDR_wenjianjia"]];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString  stringWithFormat:@"%@\n",model_mulu.title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];

    NSMutableAttributedString  *other = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@张",model_mulu.imageCount] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:other];
    name.yy_lineSpacing = 6;
    self.L_name.attributedText =name;
    
    
}

-(void)setModel_mulu2:(PhotoModel *)model_mulu
{
    _model_mulu = model_mulu;
    [self.IV_image sd_setImageWithURL:[NSURL URLWithString:model_mulu.imageUrl] placeholderImage:[UIImage imageNamed:@"EQDR_wenjianjia"]];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString  stringWithFormat:@"%@\n",model_mulu.imageName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    name.yy_lineSpacing = 6;
    self.L_name.attributedText =name;
}
-(UIImageView*)IV_image
{
    if (!_IV_image) {
        _IV_image = [[UIImageView alloc]init];
        _IV_image.userInteractionEnabled =YES;
        [self addSubview:_IV_image];
        _IV_image.layer.masksToBounds = YES;
        _IV_image.layer.cornerRadius =6;
        [_IV_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_equalTo(self.mas_width);
        }];
        
        
    }
    return _IV_image;
}
-(YYLabel*)L_name
{
    if (!_L_name) {
        _L_name = [[YYLabel alloc]init];
        _L_name.userInteractionEnabled =YES;
        _L_name.numberOfLines =0;
        [self addSubview:_L_name];
        
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IV_image.mas_bottom);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left);
        }];
        
    }
    return _L_name;
}
@end
