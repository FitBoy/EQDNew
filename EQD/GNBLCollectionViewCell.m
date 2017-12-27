//
//  GNBLCollectionViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GNBLCollectionViewCell.h"

#import <Masonry.h>
@implementation GNBLCollectionViewCell

-(UILabel*)L_RedTip
{
    if (!_L_RedTip) {
        _L_RedTip =[[UILabel alloc]init];
        _L_RedTip.backgroundColor =[UIColor redColor];
        _L_RedTip.layer.masksToBounds=YES;
        _L_RedTip.layer.cornerRadius =8;
        _L_RedTip.font =[UIFont systemFontOfSize:12];
        _L_RedTip.textColor =[UIColor whiteColor];
        _L_RedTip.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_L_RedTip];
        [_L_RedTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 16));
            make.bottom.mas_equalTo(self.IV_img.mas_top).mas_offset(8);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(-12);
        }];
    }
    return _L_RedTip;
}
-(UIImageView*)IV_img
{
    if(!_IV_img)
    {
        _IV_img = [[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.userInteractionEnabled=YES;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).mas_offset(8);
        }];
    }
    return _IV_img;
}
-(UILabel*)L_title
{
    if(!_L_title)
    {
        _L_title = [[UILabel alloc]init];
        _L_title.font =[UIFont systemFontOfSize:12];
        _L_title.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_L_title];
        [_L_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
    }
    return _L_title;
}
-(void)setModel:(GNmodel *)model
{
    self.IV_img.image=[UIImage imageNamed:model.img];
    self.L_title.text =model.name;
    if([model.number_red integerValue]>0)
    {
        self.L_RedTip.hidden=NO;
        self.L_RedTip.text =model.number_red;
    }else
    {
    self.L_RedTip.hidden=YES;
    }
}


@end
