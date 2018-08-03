//
//  SC_fangKeTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_fangKeTableViewCell.h"
#import <Masonry.h>
@implementation SC_fangKeTableViewCell

-(void)setModel_fangke:(SC_fangKeModel *)model_fangke
{
    _model_fangke = model_fangke;
    [self.V_top setHead:model_fangke.iphoto name:model_fangke.staffName bumen:[NSString stringWithFormat:@"%@-%@",model_fangke.departName,model_fangke.postName] time:model_fangke.createTime];
    self.V_top.IV_fenxiang.hidden =YES;
    self.L_contents.text = [NSString stringWithFormat:@"访问了企业的%@",model_fangke.mudularName];
    
    
}
-(FB_topView*)V_top
{
    if (!_V_top) {
        _V_top = [[FB_topView alloc]init];
        [self addSubview:_V_top];
        _V_top.userInteractionEnabled =YES;
        [_V_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
        }];
    }
    return _V_top;
}
-(UILabel*)L_contents
{
    if (!_L_contents) {
        _L_contents = [[UILabel alloc]init];
        [self addSubview:_L_contents];
        _L_contents.font = [UIFont systemFontOfSize:13];
        _L_contents.textColor = [UIColor  grayColor];
        _L_contents.userInteractionEnabled =YES;
        [_L_contents mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.mas_left).mas_offset(50);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.V_top.mas_bottom).mas_offset(5);
        }];
    }
    return _L_contents;
}
@end
