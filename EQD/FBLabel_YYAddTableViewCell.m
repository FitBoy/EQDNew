//
//  FBLabel_YYAddTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
@implementation FBLabel_YYAddTableViewCell
-(void)setModel_need:(SC_needModel *)model_need
{
    _model_need =model_need;
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_need.ProductName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:3]}];
    name.yy_alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"发布时间：%@（%@）\n需求预算：%@元\n需求量：%@\n",model_need.createTime,model_need.end_status,model_need.DemandPrice,model_need.DemandNum] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [name appendAttributedString:contents];
    NSMutableAttributedString *type0 = [[NSMutableAttributedString alloc]initWithString:@" " attributes:nil];
    NSMutableAttributedString *type = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_need.ProductType] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [type yy_setTextBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:type.yy_rangeOfAll];
    [type0 appendAttributedString:type];
    [name appendAttributedString:type0];
    NSMutableAttributedString *address = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"发货地址：%@",model_need.DemandAddress] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [name appendAttributedString:address];
    name.yy_lineSpacing = 6;
    
    
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_need.cell_height =size.height+15;
    self.YL_content.attributedText =name;
    [self.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:12];
        _L_name.textColor = [UIColor grayColor];
        _L_name.frame = CGRectMake(10, 5, DEVICE_WIDTH-20, 15);
    }
    return _L_name;
}
-(YYLabel*)YL_content
{
    if (!_YL_content) {
        _YL_content = [[YYLabel alloc]init];
        [self addSubview:_YL_content];
        _YL_content.numberOfLines =0;
        _YL_content.font = [UIFont systemFontOfSize:17];
        
    }
    return _YL_content;
}

@end
