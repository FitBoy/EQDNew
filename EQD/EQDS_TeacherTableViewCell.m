//
//  EQDS_TeacherTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/26.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_TeacherTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation EQDS_TeacherTableViewCell

-(void)setModel3:(EQDS_teacherInfoModel *)model
{
    _model_teacher = model;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.headimage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    
    self.L_name.text =[NSString stringWithFormat:@"%@",model.realname];
    self.L_contents.text = [NSString stringWithFormat:@"常驻地区：%@",model.address];
    NSMutableAttributedString *ResearchField = [[NSMutableAttributedString alloc]initWithString:@""];
    NSArray *tarr = [model.ResearchField componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString  *Tstr = [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        [Tstr yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:Tstr.yy_rangeOfAll];
        [Tstr yy_setTextHighlightRange:Tstr.yy_rangeOfAll color:[UIColor orangeColor] backgroundColor:[UIColor orangeColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate respondsToSelector:@selector(getlable:Withmodel:)]) {
                [self.delegate getlable:tarr[i] Withmodel:model];
            }
        }];
        
        [ResearchField appendAttributedString:Tstr];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [ResearchField appendAttributedString:kong];
    }
    self.YL_label.attributedText = ResearchField;
}
-(void)setModel2:(EQDS_teacherInfoModel *)model2
{
    _model_teacher = model2;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model2.headimage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
   
    self.L_name.text =[NSString stringWithFormat:@"%@",model2.realname];
    self.L_contents.text = [NSString stringWithFormat:@"主将课程：%@\n参考价格：%@元",model2.courses,model2.CooperativePrice];
    NSMutableAttributedString *ResearchField = [[NSMutableAttributedString alloc]initWithString:@""];
    NSArray *tarr = [model2.ResearchField componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString  *Tstr = [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        [Tstr yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:Tstr.yy_rangeOfAll];
        [Tstr yy_setTextHighlightRange:Tstr.yy_rangeOfAll color:[UIColor orangeColor] backgroundColor:[UIColor orangeColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate respondsToSelector:@selector(getlable:Withmodel:)]) {
                [self.delegate getlable:tarr[i] Withmodel:model2];
            }
        }];
        
        [ResearchField appendAttributedString:Tstr];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [ResearchField appendAttributedString:kong];
    }
    self.YL_label.attributedText = ResearchField;
    model2.cellHeight =120;
    
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name=[[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:17];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_head.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _L_name;
}
-(UILabel*)L_contents
{
    if (!_L_contents) {
        _L_contents = [[UILabel alloc]init];
        [self addSubview:_L_contents];
        _L_contents.font = [UIFont systemFontOfSize:13];
        _L_contents.textColor = [UIColor grayColor];
        _L_contents.numberOfLines = 2;
        [_L_contents mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _L_contents;
}
-(YYLabel*)YL_label
{
    if (!_YL_label) {
        _YL_label = [[YYLabel alloc]init];
        [self addSubview:_YL_label];
        _YL_label.font = [UIFont systemFontOfSize:13];
        [_YL_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.IV_head.mas_bottom).mas_offset(-5);
        }];
    }
    return _YL_label;
}
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        [self addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(85, 100));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _IV_head;
}
-(void)setModel:(eQDS_teacherAndSearchModel *)model
{
    _model = model;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.lectureImage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text = model.lectureName;
    self.L_contents.text = model.lectureIntroduce;
    NSArray *tarr = [model.lectureType  componentsSeparatedByString:@","];
    NSMutableAttributedString *Tstr = [[NSMutableAttributedString alloc]initWithString:@""];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString  *tstr = [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor orangeColor]}];
        [tstr yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:tstr.yy_rangeOfAll];
        [tstr yy_setTextHighlightRange:tstr.yy_rangeOfAll color:[UIColor orangeColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate respondsToSelector:@selector(getlable:Withmodel:)]) {
                [self.delegate getlable:tarr[i] Withmodel:model];
            }
        }];
        [Tstr appendAttributedString:tstr];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [Tstr appendAttributedString:kong];
    }
    self.YL_label.attributedText = Tstr;
    
    
}

-(void)setModel_course:(EQDS_courseNewModel *)model_course
{
    _model_course = model_course;
    self.L_name.text = model_course.courseTheme;
    if(model_course.courseImages.length==0)
    {
        self.IV_head.hidden = YES;
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }else
    {
        self.IV_head.hidden =NO;
        [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model_course.courseImages] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    }
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"讲师：%@\n授课对象：%@",model_course.lectureName,model_course.courseObjecter] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];

//    [content yy_setColor:[UIColor redColor] range:NSMakeRange(5, model_course.coursePrice.length)];
//    content.yy_lineSpacing =6;
    
    self.L_contents.attributedText =content;
    NSArray *tarr = [model_course.courseType  componentsSeparatedByString:@","];
    NSMutableAttributedString *Tstr = [[NSMutableAttributedString alloc]initWithString:@""];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString  *tstr = [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor orangeColor]}];
        [tstr yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:tstr.yy_rangeOfAll];
        [Tstr appendAttributedString:tstr];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [Tstr appendAttributedString:kong];
    }
    self.YL_label.attributedText = Tstr;
    
    model_course.cell_height =110;
    
    
}

@end
