//
//  FByylabel_btnOnerightTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FByylabel_btnOnerightTableViewCell.h"
#import <Masonry.h>
@implementation FByylabel_btnOnerightTableViewCell
-(YYLabel*)yy_label
{
    if (!_yy_label) {
        _yy_label = [[YYLabel alloc]init];
        _yy_label.numberOfLines =0;
        [self addSubview:_yy_label];
    }
    return _yy_label;
}
-(FBButton*)btn_right
{
    if (!_btn_right) {
        _btn_right =[FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_btn_right];
        _btn_right.layer.borderColor = [UIColor grayColor].CGColor;
        _btn_right.layer.borderWidth =0.6;
        [_btn_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 30));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _btn_right;
}
-(void)setModel_course:(PX_courseManageModel *)model_course
{
    NSMutableAttributedString *name  =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"【%@】%@",model_course.lectureName,model_course.courseTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    self.yy_label.attributedText= name;
    [self.btn_right setTitle:@"匹配的需求" titleColor:nil backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18]];
    CGSize size = [name boundingRectWithSize:CGSizeMake(CGRectGetMinX(self.btn_right.frame)-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_course.cell_height = size.height+20;
    [self.yy_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.btn_right).mas_offset(-5);
        make.height.mas_equalTo(size.height+15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

@end
