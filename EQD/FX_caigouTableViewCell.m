//
//  FX_caigouTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FX_caigouTableViewCell.h"
#import <Masonry.h>
@implementation FX_caigouTableViewCell

-(void)setModel_caigou:(SC_needModel *)model_caigou
{
    _model_caigou = model_caigou;
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_caigou.ProductName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:3]}];
    name.yy_alignment =NSTextAlignmentCenter;
    NSMutableAttributedString *name1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"预算：￥%@元 \n结束时间：%@",model_caigou.DemandPrice,model_caigou.EndTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:name1];
    name.yy_lineSpacing =6;
    self.YL_contents.attributedText = name;
    CGSize size = [name boundingRectWithSize:CGSizeMake(self.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_caigou.cell_height = size.height+15+45;
    [self.YL_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.top.mas_equalTo(self.mas_top).mas_offset(5);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    
}
-(YYLabel*)YL_contents
{
    if (!_YL_contents) {
        _YL_contents = [[YYLabel alloc]init];
        _YL_contents.numberOfLines =0;
        [self addSubview:_YL_contents];
    }
    return _YL_contents;
}

-(FBButton*)B_btn
{
 if(!_B_btn)
 {
     _B_btn = [FBButton buttonWithType:UIButtonTypeSystem];
     [self addSubview:_B_btn];
     [_B_btn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(35);
         make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
         make.left.mas_equalTo(self.mas_left).mas_offset(60);
         make.right.mas_equalTo(self.mas_right).mas_offset(-60);
     }];
     
 }
    return _B_btn;
}
@end
