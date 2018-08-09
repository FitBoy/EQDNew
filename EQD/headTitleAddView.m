//
//  headTitleAddView.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "headTitleAddView.h"
#import <Masonry.h>
@implementation headTitleAddView
-(UILabel*)L_text
{
    if(!_L_text)
    {
        _L_text = [[UILabel alloc]init];
        _L_text.font = [UIFont systemFontOfSize:16];
        _L_text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_L_text];
        [_L_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-50);
        }];
        
    }
    return _L_text;
}
-(UIImageView*)IV_add
{
    if (!_IV_add) {
        _IV_add = [[UIImageView alloc]init];
        _IV_add.userInteractionEnabled = YES;
        _IV_add.image = [UIImage imageNamed:@"add_eqd2"];
       /* _IV_add.layer.borderWidth =1;
        _IV_add.layer.borderColor = [[UIColor grayColor] CGColor];*/
        self.userInteractionEnabled =YES;
        [self addSubview:_IV_add];
        [_IV_add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
    }
    return _IV_add;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
