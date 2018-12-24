//
//  BPDetailTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/11/10.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "BPDetailTableViewCell.h"
#import <Masonry.h>
@implementation BPDetailTableViewCell
-(YYLabel*)YL_label
{
    if (!_YL_label) {
        _YL_label = [[YYLabel alloc]init];
        [self addSubview:_YL_label];
        _YL_label.numberOfLines =2;
        _YL_label.userInteractionEnabled =YES;
        [_YL_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.L_jifen.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(self.mas_centerY);
            
        }];
        
    }
    return _YL_label;
}
-(UILabel*)L_jifen
{
    if (!_L_jifen) {
        _L_jifen = [[UILabel alloc]init];
        [self addSubview:_L_jifen];
        _L_jifen.userInteractionEnabled =YES;
        _L_jifen.textAlignment = NSTextAlignmentRight;
        _L_jifen.font = [UIFont systemFontOfSize:20];
        _L_jifen.textColor = [UIColor colorWithRed:49/255.0 green:72/255.0 blue:196/255.0 alpha:1];
        
        [_L_jifen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.left.mas_equalTo(self.YL_label.mas_right).mas_offset(5);
        }];
    }
    return _L_jifen;
}
-(void)setBP_model:(BPModel *)BP_model
{
    _BP_model = BP_model;
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@获得积分",BP_model.remark] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",BP_model.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:time];
    name.yy_lineSpacing =6;
    
    self.YL_label.attributedText =name;
    NSString *text = [BP_model.operation integerValue]==1?[NSString stringWithFormat:@"+%@",BP_model.credit]:[NSString stringWithFormat:@"-%@",BP_model.credit];
    
    self.L_jifen.text = text;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
