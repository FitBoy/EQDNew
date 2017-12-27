//
//  FBchengyuanTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBchengyuanTableViewCell.h"
#import <Masonry.h>
@implementation FBchengyuanTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.IV_headimg =[[UIImageView alloc]init];
        [self addSubview:self.IV_headimg];
        self.IV_headimg.layer.masksToBounds=YES;
        self.IV_headimg.layer.cornerRadius =25;
        self.IV_headimg.image = [UIImage imageNamed:@"no_login_head"];
        
        self.L_name = [[UILabel alloc]init];
        [self addSubview:self.L_name];
        self.L_date =[[UILabel alloc]init];
        [self addSubview:self.L_date];
        self.L_date.font =[UIFont systemFontOfSize:15];
        self.L_date.textColor =[UIColor grayColor];
        
        
        
        
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
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
        }];
        
        [self.L_date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-100);
            make.top.mas_equalTo(self.L_name.mas_bottom);
        }];
        
       
        
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
