//
//  IVLabeltableHeadView.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "IVLabeltableHeadView.h"
#import <Masonry.h>
@implementation IVLabeltableHeadView
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        _IV_head.userInteractionEnabled=YES;
        [self addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _IV_head;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.userInteractionEnabled=YES;
        _L_name.font = [UIFont systemFontOfSize:18];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _L_name;
}

@end
