//
//  FBTextFieldTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTextFieldTableViewCell.h"
#import <Masonry.h>
@implementation FBTextFieldTableViewCell
-(void)setPlaceHolder:(NSString*)placeholder
{
    self.TF_text.placeholder=placeholder;
}
-(UITextField*)TF_text
{
    if (!_TF_text) {
        _TF_text = [[UITextField alloc]init];
        [self addSubview:_TF_text];
        _TF_text.placeholder=@"手机号";
        _TF_text.clearButtonMode=UITextFieldViewModeAlways;
        _TF_text.font=[UIFont systemFontOfSize:18];
        [_TF_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _TF_text;
}
@end
