//
//  Com_searchTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/20.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "Com_searchTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation Com_searchTableViewCell
-(void)setModel_com:(Com_searchModel *)model_com
{
    _model_com = model_com;
    [self.IV_image sd_setImageWithURL:[NSURL URLWithString:model_com.com_logo] placeholderImage:[UIImage imageNamed:@"imageerro"]];
    self.L_name.text = model_com.com_name;
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",model_com.city,model_com.staffnum] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:15/255.0 green:41/255.0 blue:140/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, model_com.city.length)];
    self.L_place.attributedText = name;
    model_com.cell_height =60;
}


-(UIImageView*)IV_image
{
    if (!_IV_image) {
        _IV_image = [[UIImageView alloc]init];
        [self addSubview:_IV_image];
        [_IV_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _IV_image;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:17];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.IV_image.mas_left).mas_offset(-5);
            make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-2);
        }];
        
        
    }
    return _L_name;
}
-(UILabel*)L_place
{
    if (!_L_place) {
        _L_place = [[UILabel alloc]init];
        [self addSubview:_L_place];
        _L_place.font = [UIFont systemFontOfSize:12];
        _L_place.textColor = [UIColor grayColor];
        [_L_place mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_centerY).mas_offset(3);
            make.right.mas_equalTo(self.IV_image.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_place;
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
