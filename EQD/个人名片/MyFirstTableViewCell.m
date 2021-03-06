//
//  MyFirstTableViewCell.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MyFirstTableViewCell.h"
#import <Masonry.h>
@implementation MyFirstTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.IV_headimg=[[UIImageView alloc]init];
        [self addSubview:self.IV_headimg];
        self.IV_headimg.layer.masksToBounds=YES;
        self.IV_headimg.layer.cornerRadius=20;
        self.IV_headimg.userInteractionEnabled=YES;
        self.L_name=[[UILabel alloc]init];
        self.L_name.font=[UIFont systemFontOfSize:15];
        [self addSubview:self.L_name];
        
        self.L_zhanghao =[[UILabel alloc]init];
        [self addSubview:self.L_zhanghao];
        self.L_zhanghao.font=[UIFont systemFontOfSize:13];
        self.L_zhanghao.textColor=[UIColor grayColor];
        
        self.B_erWeima=[UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.B_erWeima];
        [self.B_erWeima setBackgroundImage:[UIImage imageNamed:@"erweimalogo.png"] forState:UIControlStateNormal];
        
        //下面增加约束
        [self.IV_headimg  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [self.L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 23));
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_headimg.mas_top);
        }];
        
        [self.L_zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 17));
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.IV_headimg.mas_bottom);
        }];
        [self.B_erWeima mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-35);
        }];
        
        
    }
    return self;
}


@end
