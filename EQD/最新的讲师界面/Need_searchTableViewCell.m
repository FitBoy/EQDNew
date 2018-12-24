//
//  Need_searchTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/24.
//  Copyright © 2018 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "Need_searchTableViewCell.h"
#import <Masonry.h>
#import <YYText.h>

@implementation Need_searchTableViewCell
-(UILabel*)L_left
{
    if (!_L_left) {
        _L_left = [[UILabel alloc]init];
        _L_left.numberOfLines = 0;
        [self addSubview:_L_left];
        [_L_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.L_right.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.height.mas_equalTo(50);
        }];
        
    }
    return _L_left;
}
-(UILabel*)L_right
{
    if (!_L_right) {
        _L_right = [[UILabel alloc]init];
        [self addSubview:_L_right];
        [_L_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _L_right;
}

-(void)setModel_need:(PXNeedModel * _Nonnull)model_need
{
    _model_need = model_need;
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:model_need.theTheme attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    NSMutableAttributedString *type = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_need.type] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithRed:15/255.0 green:41/255.0 blue:140/255.0 alpha:1]}];
    [name appendAttributedString:type];
    NSMutableAttributedString *place = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n培训时间：%@ ~ %@\n地点：%@",model_need.thedateStart,model_need.thedateEnd,model_need.thedateEnd] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:place];
    name.yy_lineSpacing =6;
    
    self.L_left.attributedText = name;
    
    self.L_right.text = [NSString stringWithFormat:@"预算:%@",model_need.budgetedExpense];
    self.L_right.textAlignment  = NSTextAlignmentRight;
    self.L_right.textColor = [UIColor redColor];
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-130, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [_L_left mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
    }];
    model_need.cellHeight = size.height +20;
  
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
