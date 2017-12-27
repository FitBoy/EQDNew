//
//  FBOne_TextFieldTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBOne_TextFieldTableViewCell.h"
#import <Masonry.h>
@implementation FBOne_TextFieldTableViewCell
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _V_bg;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_name];
        _L_name.font=[UIFont systemFontOfSize:18];
//        _L_name.textColor=[UIColor grayColor];
        _L_name.textAlignment=NSTextAlignmentCenter;
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.width.mas_equalTo(80);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
        }];
        
    }
    return _L_name;
    
}
-(FBindexPathTextField*)TF_contents
{
    if (!_TF_contents) {
        _TF_contents =[[FBindexPathTextField alloc]init];
        [self.V_bg addSubview:_TF_contents];
        _TF_contents.font=[UIFont systemFontOfSize:18];
        [_TF_contents mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.L_name.mas_right).mas_offset(5);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
}
    return _TF_contents;
}
@end
