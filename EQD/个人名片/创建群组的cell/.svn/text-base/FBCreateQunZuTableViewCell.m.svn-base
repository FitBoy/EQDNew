//
//  FBCreateQunZuTableViewCell.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBCreateQunZuTableViewCell.h"
#import <Masonry.h>
@implementation FBCreateQunZuTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.IV_choose =[[UIImageView alloc]init];
        self.IV_choose.image =[UIImage imageNamed:@"shequ_tluntan.png"];
        [self addSubview:self.IV_choose];
        
        self.IV_headimg =[[UIImageView alloc]init];
        [self addSubview:self.IV_headimg];
        self.IV_headimg.layer.masksToBounds=YES;
        self.IV_headimg.layer.cornerRadius=20;
        self.IV_headimg.image = [UIImage imageNamed:@"no_login_head"];
        self.L_name =[[UILabel alloc]init];
        [self addSubview:self.L_name];
        
        
        //下面增加约束
        [self.IV_choose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(10);
            
        }];
        
        [self.IV_headimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.IV_choose.mas_right).mas_offset(10);
        }];
        
        [self.L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.IV_headimg.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.mas_right).mas_offset(-10);
            make.height.mas_equalTo(40);
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
