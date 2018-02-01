//
//  EQDR_labelTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
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


@end
