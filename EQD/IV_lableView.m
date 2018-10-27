//
//  IV_lableView.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "IV_lableView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation IV_lableView
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.userInteractionEnabled = YES;
        _IV_img.layer.masksToBounds = YES;
        _IV_img.layer.cornerRadius =25;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top);
        }];
    }
    return _IV_img;
}
-(UILabel*)L_title
{
    if (!_L_title) {
        _L_title = [[UILabel alloc]init];
        [self addSubview:_L_title];
        _L_title.font = [UIFont systemFontOfSize:13];
        _L_title.textColor = [UIColor grayColor];
        _L_title.textAlignment = NSTextAlignmentCenter;
        [_L_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.bottom.mas_equalTo(self.mas_bottom);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
    }
    return _L_title;
}
-(void)setimg:(NSString*)imgName tiele:(NSString*)title isLocal:(BOOL)isloacal
{
    self.L_title.text = title;
    if (isloacal==NO) {
        [self.IV_img sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@""]];
    }else
    {
        self.IV_img.image = [UIImage imageNamed:imgName];
    }
}
@end
