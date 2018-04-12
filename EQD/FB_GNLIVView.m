//
//  FB_GNLIVView.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/14.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_GNLIVView.h"
#import <Masonry.h>
@implementation FB_GNLIVView
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:15 weight:2];
        _L_name.textAlignment = NSTextAlignmentCenter;
        _L_name.textColor = [UIColor whiteColor];
        _L_name.backgroundColor = [UIColor darkGrayColor];
        _L_name.layer.masksToBounds=YES;
        _L_name.layer.cornerRadius=5;
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(5);
            make.right.mas_equalTo(self.IV_img.mas_left).mas_offset(-5);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _L_name;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        _IV_img.userInteractionEnabled = YES;
        [self addSubview:_IV_img];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(35, 35));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-5);
        }];
    }
    return _IV_img;
}

-(void)setname:(NSString*)name  AndimgName:(NSString*)imgName
{
    self.L_name.text = name;
    self.IV_img.image = [UIImage imageNamed:imgName];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
