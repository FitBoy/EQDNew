//
//  FByyLabel_twobtnTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FByyLabel_twobtnTableViewCell.h"
#import <Masonry.h>
@implementation FByyLabel_twobtnTableViewCell
-(void)setModel_need:(PXNeedModel *)model_need
{
    _model_need=model_need;
    NSMutableAttributedString *name =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_need.theTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19 weight:3]}];
    self.yy_tlabel.attributedText =name;
    CGSize  size= [name boundingRectWithSize:CGSizeMake(self.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model_need.cellHeight = size.height+15+35;
    [self.yy_tlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.top.mas_equalTo(self.mas_top).mas_offset(5);
    }];
    
}
-(YYLabel*)yy_tlabel
{
    if (!_yy_tlabel) {
        _yy_tlabel = [[YYLabel alloc]init];
        _yy_tlabel.numberOfLines =0;
        [self addSubview:_yy_tlabel];
        
    }
    return _yy_tlabel;
}
-(FBButton*)tbtn_left
{
    if (!_tbtn_left) {
        _tbtn_left = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_tbtn_left];
        [_tbtn_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
            make.right.mas_equalTo(self.mas_centerX).mas_offset(-5);
        }];
        
    }
    return _tbtn_left;
}
-(FBButton*)tbtn_right
{
    if (!_tbtn_right) {
        _tbtn_right = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_tbtn_right];
        [_tbtn_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.left.mas_equalTo(self.mas_centerX).mas_offset(5);
        }];
    }
    return _tbtn_right;
}

@end
