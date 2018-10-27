//
//  FBimage_name_text_btnTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBimage_name_text_btnTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBimage_name_text_btnTableViewCell
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        _IV_img.layer.masksToBounds = YES;
        _IV_img.layer.cornerRadius =20;
        [self addSubview:_IV_img];
        [_IV_img  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
        }];
        
    }
    return _IV_img;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:18];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.IV_img.mas_centerY);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-120);
        }];
    }
    return _L_name;
}
-(YYLabel*)YL_text
{
    if (!_YL_text) {
        _YL_text = [[YYLabel alloc]init];
        [self addSubview:_YL_text];
        _YL_text.numberOfLines = 0;
        
    }
    return _YL_text;
}
-(YYLabel*)YL_price
{
    if (!_YL_price) {
        _YL_price = [[YYLabel alloc]init];
        [self addSubview:_YL_price];
        
        
    }
    return _YL_price;
}
-(FBButton*)B_shoucang
{
    if (!_B_shoucang) {
        _B_shoucang = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_shoucang];
        
    }
    return _B_shoucang;
}
-(void)setModel_teacher:(eQDS_teacherAndSearchModel *)model_teacher
{
    _model_teacher = model_teacher;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_teacher.lectureImage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text = model_teacher.lectureName;
    NSMutableAttributedString *contents =[[NSMutableAttributedString alloc]initWithString:@"" attributes:nil];
    if(model_teacher.lectureIntroduce.length >1)
    {
    NSMutableAttributedString *contents2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_teacher.lectureIntroduce.length>40?[model_teacher.lectureIntroduce substringWithRange:NSMakeRange(0, 40)]:model_teacher.lectureIntroduce] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [contents appendAttributedString:contents2];
    }else
    {
        
    }
    
    NSArray *tarr = [model_teacher.lectureType componentsSeparatedByString:@","];
    NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"  " attributes:nil];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString * type = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        [type yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor grayColor]] range:type.yy_rangeOfAll];
        [kong  appendAttributedString:type];
        NSMutableAttributedString *kong2 = [[NSMutableAttributedString alloc]initWithString:@"  " attributes:nil];
        [kong appendAttributedString:kong2];
    }
    [contents appendAttributedString:kong];
    contents.yy_lineSpacing =6;

   
    CGSize size = [contents boundingRectWithSize:CGSizeMake(self.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_teacher.cell_height = 50+size.height+15;
    self.YL_text.attributedText =contents;
    [self.YL_text mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
    }];
    self.YL_price.hidden =YES;
    self.B_shoucang.hidden= YES;
    
}

-(void)setModel_teacher2:(eQDS_teacherAndSearchModel *)model_teacher
{
    _model_teacher = model_teacher;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_teacher.lectureImage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text = model_teacher.lectureName;
    NSMutableAttributedString *contents =[[NSMutableAttributedString alloc]initWithString:@"" attributes:nil];
    if(model_teacher.lectureIntroduce.length >1)
    {
        NSMutableAttributedString *contents2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_teacher.lectureIntroduce.length>40?[model_teacher.lectureIntroduce substringWithRange:NSMakeRange(0, 40)]:model_teacher.lectureIntroduce] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [contents appendAttributedString:contents2];
    }else
    {
        
    }
    
    NSArray *tarr = [model_teacher.lectureType componentsSeparatedByString:@","];
    NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"  " attributes:nil];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString * type = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        [type yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor grayColor]] range:type.yy_rangeOfAll];
        [kong  appendAttributedString:type];
        NSMutableAttributedString *kong2 = [[NSMutableAttributedString alloc]initWithString:@"  " attributes:nil];
        [kong appendAttributedString:kong2];
    }
    [contents appendAttributedString:kong];
    contents.yy_lineSpacing =6;
    
    self.B_shoucang.hidden = NO;
    [self.B_shoucang setTitle:@"收藏" titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1] font:[UIFont systemFontOfSize:18]];
    [self.B_shoucang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    CGSize size = [contents boundingRectWithSize:CGSizeMake(self.frame.size.width-30-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_teacher.cell_height = 50+size.height+15;
    self.YL_text.attributedText =contents;
    [self.YL_text mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.B_shoucang.mas_left).mas_offset(-5);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
    }];
    self.YL_price.hidden =YES;
}

-(void)setModel_info:(EQDS_teacherInfoModel *)model_info
{
    _model_info = model_info;
    [self.IV_img sd_setImageWithURL:[NSURL URLWithString:model_info.headimage] placeholderImage:[UIImage imageNamed:@"no_login_head"] options:(SDWebImageProgressiveDownload)];
    self.L_name.text = model_info.realname;
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:@"" attributes:nil];
    if (model_info.courses.length>1) {
        NSMutableAttributedString *contents2 =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_info.courses] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        [contents appendAttributedString:contents2];
    }else
    {
        
    }
    NSMutableAttributedString *type = [[NSMutableAttributedString alloc]initWithString:@"  " attributes:nil];
    NSArray *tarr = [model_info.ResearchField componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *type1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [type1 yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:0.6 strokeColor:[UIColor blackColor]] range:type1.yy_rangeOfAll];
        [type appendAttributedString:type1];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   " attributes:nil];
        [type appendAttributedString:kong];
    }
    [contents  appendAttributedString:type];
    contents.yy_lineSpacing =6;
    
    NSMutableAttributedString *price  = [[NSMutableAttributedString alloc]initWithString:@"￥" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSMutableAttributedString *price1 = [[NSMutableAttributedString alloc]initWithString:model_info.CooperativePrice attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor redColor]}];
    [price appendAttributedString:price1];
    NSMutableAttributedString *price2 =[[NSMutableAttributedString alloc]initWithString:@"元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    [price appendAttributedString:price2];
    
    self.B_shoucang.hidden = YES;
   /* [self.B_shoucang setTitle:@"收藏" titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1] font:[UIFont systemFontOfSize:18]];
    [self.B_shoucang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(20);
    }];*/
    self.YL_price.hidden = NO;
    self.YL_price.attributedText = price;
    CGSize  size_price = [price boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [self.YL_price mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(size_price.width+5, 30));
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    self.YL_text.attributedText = contents;
    CGSize size_content = [contents boundingRectWithSize:CGSizeMake(self.frame.size.width-30-105, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_info.cellHeight = size_content.height+15+50;
    [self.YL_text mas_remakeConstraints:^(MASConstraintMaker *make) {
     
        make.height.mas_equalTo(size_content.height+10);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        make.right.mas_equalTo(self.mas_right).mas_offset(-120);
    }];
    
    
    
}

@end
