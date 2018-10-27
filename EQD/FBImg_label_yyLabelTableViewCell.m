//
//  FBImg_label_yyLabelTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBImg_label_yyLabelTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBImg_label_yyLabelTableViewCell

-(YYLabel*)yy_label
{
    if (!_yy_label) {
        _yy_label = [[YYLabel alloc]init];
        [self addSubview:_yy_label];
        _yy_label.userInteractionEnabled = YES;
        _yy_label.numberOfLines =0;
        [_yy_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(60);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-2);
        }];
    }
    return _yy_label;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        _L_name.userInteractionEnabled =YES;
        _L_name.numberOfLines =2;
        [self addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(2);
        }];
    }
    return _L_name;
}

-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.userInteractionEnabled = YES;
//        _IV_img.layer.masksToBounds = YES;
//        _IV_img.layer.cornerRadius =6;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _IV_img;
}
-(void)setModel_huodong:(CK_huoDongModel *)model_huodong
{
    _model_huodong = model_huodong;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_huodong.activeImg] placeholderImage:[UIImage imageNamed:@"imageerro"] options:(SDWebImageProgressiveDownload)];
    self.L_name.text = model_huodong.activeTitle;
    NSString *price = [model_huodong.price integerValue]==0?@"免费":[NSString stringWithFormat:@"￥%@元",model_huodong.price];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"报名:%@\n地区:%@\n发布时间:%@",price,model_huodong.activeCity,model_huodong.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    name.yy_lineSpacing =6;
    self.yy_label.attributedText = name;
    
}
-(void)setIMgUrl:(NSString*)imgUrl name:(NSString*)name attrbuteName:(NSAttributedString*)attrbuteName
{
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"imageerro"] options:(SDWebImageProgressiveDownload)];
    self.L_name.text = name;
    self.yy_label.attributedText = attrbuteName;
}


@end
