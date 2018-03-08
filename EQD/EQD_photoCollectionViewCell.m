//
//  EQD_photoCollectionViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQD_photoCollectionViewCell.h"
#import <Masonry.h>
@implementation EQD_photoCollectionViewCell
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img =[[UIImageView alloc]init];
        _IV_img.userInteractionEnabled =YES;
        _IV_img.layer.masksToBounds =YES;
        _IV_img.layer.cornerRadius =4;
        [self addSubview:_IV_img];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-5);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
    }
    return _IV_img;
}
@end
