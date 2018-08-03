//
//  FBImage_textFullTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBImage_textFullTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@implementation FBImage_textFullTableViewCell
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.userInteractionEnabled =YES;
        _IV_img.layer.masksToBounds =YES;
        _IV_img.layer.cornerRadius =6;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_equalTo(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.height.mas_equalTo((DEVICE_WIDTH-30)*0.5);
        }];
        
    }
    return _IV_img;
}
-(YYLabel*)YL_text
{
    if (!_YL_text) {
        _YL_text = [[YYLabel alloc]init];
        [self addSubview:_YL_text];
        _YL_text.numberOfLines =0;
    }
    return _YL_text;
}

-(void)setModel_center:(Image_textModel *)model_center
{
      [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_center.ImageUrl] placeholderImage:[UIImage imageNamed:@"imageerro"] options:(SDWebImageProgressiveDownload)];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_center.title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:3]}];
    text.yy_alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *xuhao = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model_center.describe] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [text appendAttributedString:xuhao];
    text.yy_lineSpacing =6;
    self.YL_text.attributedText = text;
    CGSize size = [text boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    [self.YL_text mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.top.mas_equalTo(self.IV_img.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    model_center.cell_height = size.height+20+(DEVICE_WIDTH-30)*0.5;
}
-(void)setModel_imgText:(Image_textModel *)model_imgText
{
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_imgText.ImageUrl] placeholderImage:[UIImage imageNamed:@"imageerro"] options:(SDWebImageProgressiveDownload)];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:model_imgText.describe attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    NSMutableAttributedString *xuhao = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n排序号:%@",model_imgText.sort] attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    xuhao.yy_alignment = NSTextAlignmentRight;
    [text appendAttributedString:xuhao];
    text.yy_lineSpacing =6;
    self.YL_text.attributedText = text;
    CGSize size = [text boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    [self.YL_text mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.top.mas_equalTo(self.IV_img.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    model_imgText.cell_height = size.height+20+(DEVICE_WIDTH-30)*0.5;
    
    
}


@end
