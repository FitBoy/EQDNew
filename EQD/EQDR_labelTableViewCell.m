//
//  EQDR_labelTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define EQDCOLOR   [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1]

#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
@implementation EQDR_labelTableViewCell
-(YYLabel*)YL_label
{
    if (!_YL_label) {
        _YL_label = [[YYLabel alloc]init];
        [self addSubview:_YL_label];
        _YL_label.numberOfLines =0;
        
    }
    return _YL_label;
}
-(void)setModel_course:(PX_courseManageModel *)model_course
{
    _model_course =model_course;
    NSMutableAttributedString  *courseTheme = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_course.courseTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSArray *tarr = [model_course.courseType componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString  *type = [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]}];
        [type yy_setTextBackgroundBorder:[YYTextBorder borderWithFillColor:[UIColor grayColor] cornerRadius:6] range:type.yy_rangeOfAll];
        
//        [type yy_setTextBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor blackColor]] range:type.yy_rangeOfAll];
        NSAttributedString  *kong = [[NSAttributedString alloc]initWithString:@"   "];
        [type appendAttributedString:kong];
        [courseTheme appendAttributedString:type];
    }
    
    courseTheme.yy_lineSpacing = 6;
    self.YL_label.attributedText = courseTheme;
    CGSize size = [courseTheme boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_course.cell_height = size.height+20;
    [self.YL_label  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    
}
-(void)setModel_tuijian:(EQDS_CourseModel *)model_tuijian
{
    _model_tuijian = model_tuijian;
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"【%@】",model_tuijian.lectureName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [name yy_setTextHighlightRange:name.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([self.delegate respondsToSelector:@selector(getTapNameWithname:Guid:model:)]) {
            [self.delegate getTapNameWithname:model_tuijian.lectureName Guid:model_tuijian.lecture model:model_tuijian];
        }
    }];
    NSMutableAttributedString *courseTheme = [[NSMutableAttributedString alloc]initWithString:model_tuijian.lectCourseTitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [name appendAttributedString:courseTheme];
    
    NSMutableAttributedString  *type = [[NSMutableAttributedString alloc]initWithString:@"\n" attributes:@{}];
    NSArray *tarr = [model_tuijian.lectCourseType componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *ttype= [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [ttype yy_setTextHighlightRange:ttype.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate respondsToSelector:@selector(getTapTypeWithtype:model:)]) {
                [self.delegate getTapTypeWithtype:tarr[i] model:model_tuijian];
            }
        }];
        [ttype yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:ttype.yy_rangeOfAll];
        [type appendAttributedString:ttype];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [type appendAttributedString:kong];
        
        
    }
    [name appendAttributedString:type];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_tuijian.cell_height = size.height+10;
    self.YL_label.attributedText =name;
    
    [self.YL_label  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
}
-(void)setModel_courseMin:(PX_courseManageModel *)model_courseMin
{
    _model_courseMin = model_courseMin;
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"【%@】",model_courseMin.lectureName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [name yy_setTextHighlightRange:name.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([self.delegate respondsToSelector:@selector(getTapNameWithname:Guid:model:)]) {
            [self.delegate getTapNameWithname:model_courseMin.lectureName Guid:model_courseMin.creater model:model_courseMin];
        }
    }];
    NSMutableAttributedString *courseTheme = [[NSMutableAttributedString alloc]initWithString:model_courseMin.courseTheme attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [name appendAttributedString:courseTheme];
    
    NSMutableAttributedString  *type = [[NSMutableAttributedString alloc]initWithString:@"\n" attributes:@{}];
    NSArray *tarr = [model_courseMin.courseType componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString *ttype= [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [ttype yy_setTextHighlightRange:ttype.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate respondsToSelector:@selector(getTapTypeWithtype:model:)]) {
                [self.delegate getTapTypeWithtype:tarr[i] model:model_courseMin];
            }
        }];
        [ttype yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:ttype.yy_rangeOfAll];
        [type appendAttributedString:ttype];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [type appendAttributedString:kong];
        
        
    }
    [name appendAttributedString:type];
    
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@天(%ld小时)   %@",model_courseMin.courseTimes,[model_courseMin.courseTimes integerValue]*6,model_courseMin.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    time.yy_alignment =NSTextAlignmentRight;
    [name appendAttributedString:time];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_courseMin.cell_height = size.height+10;
    self.YL_label.attributedText =name;
    
    [self.YL_label  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
}

@end
