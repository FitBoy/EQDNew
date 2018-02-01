//
//  FBImg_YYlabelTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/26.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBImg_YYlabelTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBImg_YYlabelTableViewCell
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        [self addSubview:_IV_head];
        _IV_head.userInteractionEnabled = YES;
        _IV_head.layer.masksToBounds = YES;
        _IV_head.layer.cornerRadius =5;
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _IV_head;
}
-(YYLabel*)YL_text
{
    if (!_YL_text) {
        _YL_text = [[YYLabel alloc]init];
        [self addSubview:_YL_text];
        _YL_text.numberOfLines =3;
        [_YL_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _YL_text;
}
-(void)setModel_teacherInfo:(EQDS_teacherInfoModel *)model_teacherInfo
{
    _model_teacherInfo = model_teacherInfo;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model_teacherInfo.headimage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:model_teacherInfo.realname attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSMutableAttributedString  *city = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  [%@]\n",model_teacherInfo.city] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    city.yy_alignment = NSTextAlignmentRight;
    [name appendAttributedString:city];
    NSArray *tarr = [model_teacherInfo.ResearchField componentsSeparatedByString:@","];
    for (int i=0; i<tarr.count; i++) {
        NSMutableAttributedString  *tlabel = [[NSMutableAttributedString alloc]initWithString:tarr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        [tlabel yy_setTextBackgroundBorder:[YYTextBorder borderWithFillColor:[UIColor grayColor] cornerRadius:6] range:tlabel.yy_rangeOfAll];
        NSAttributedString *kong = [[NSAttributedString alloc]initWithString:@"   "];
        [tlabel appendAttributedString:kong];
        [name appendAttributedString:tlabel];
    }
    name.yy_lineSpacing =3;
    self.YL_text.attributedText = name;
    model_teacherInfo.cellHeight =60;
}
@end
