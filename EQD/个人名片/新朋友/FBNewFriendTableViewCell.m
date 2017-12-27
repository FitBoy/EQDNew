//
//  FBNewFriendTableViewCell.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBNewFriendTableViewCell.h"
#import <Masonry.h>
@implementation FBNewFriendTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.IV_headimg =[[UIImageView alloc]init];
        [self addSubview:self.IV_headimg];
        self.IV_headimg.layer.masksToBounds=YES;
        self.IV_headimg.layer.cornerRadius =25;
              
        self.L_name = [[UILabel alloc]init];
        [self addSubview:self.L_name];
        self.L_date =[[UILabel alloc]init];
        [self addSubview:self.L_date];
        self.L_date.font =[UIFont systemFontOfSize:15];
        self.L_date.textColor =[UIColor grayColor];
        
        self.B_btn = [FBindexpathButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.B_btn];
        [self.B_btn setTitle:@"同意" forState:UIControlStateNormal];
        [self.B_btn setBackgroundColor:[UIColor colorWithRed:0 green:157/255.0 blue:237/255.0 alpha:1]];
        [self.B_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        ///下面添加约束
        [self.IV_headimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            
        }];
        [self.L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.mas_right).mas_offset(-100);
            make.top.mas_equalTo(self.IV_headimg.mas_top);
        }];
        
        [self.L_date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-100);
            make.top.mas_equalTo(self.L_name.mas_bottom);
        }];
        
        [self.B_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 35));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
        
    }
    return self;
}

@end
