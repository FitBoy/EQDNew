//
//  FBImgAddBackTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBImgAddBackTableViewCell.h"
#import <Masonry.h>
@implementation FBImgAddBackTableViewCell
-(UIImageView*)IV_add
{
    if (!_IV_add) {
        _IV_add = [[UIImageView alloc]init];
        _IV_add.userInteractionEnabled = YES;
        _IV_add.image = [UIImage imageNamed:@"add_eqd2"];
         [self addSubview:_IV_add];
        [_IV_add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
       
    }
    return _IV_add;
}
-(UILabel*)L_label
{
    if (!_L_label) {
        _L_label = [[UILabel alloc]init];
        _L_label.font = [UIFont systemFontOfSize:15];
        _L_label.textColor = [UIColor grayColor];
        [self addSubview:_L_label];
        _L_label.textAlignment = NSTextAlignmentCenter;
        [_L_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.top.mas_equalTo(self.IV_add.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _L_label;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        _IV_img.userInteractionEnabled =YES;
        _IV_img.layer.masksToBounds= YES;
        _IV_img.layer.cornerRadius =5;
        [_IV_img setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _IV_img.contentMode =  UIViewContentModeScaleAspectFill;
        _IV_img.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _IV_img.clipsToBounds  = YES;
        [self addSubview:_IV_img];
        [_IV_img bringSubviewToFront:self];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _IV_img;
}

-(void)setdataWithtitle:(NSString*)title  img:(UIImage*)imgurl
{
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth =1;
    self.L_label.text = title;
    if (imgurl!=nil) {
        self.IV_img.image=imgurl;
    }else
    {
        self.IV_img.image=nil;
    }
    
}

@end
