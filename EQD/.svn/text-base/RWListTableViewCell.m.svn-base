//
//  RWListTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RWListTableViewCell.h"
#import <Masonry.h>
@implementation RWListTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.L_rwname = [[UILabel alloc]init];
        [self addSubview:self.L_rwname];
        self.L_rwname.font =[UIFont systemFontOfSize:17];
        
        self.B_name = [UIButton buttonWithType:UIButtonTypeSystem];
        self.B_name.titleLabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:self.B_name];
        
        self.L_status = [[UILabel alloc]init];
        [self addSubview:self.L_status];
        self.L_status.font=[UIFont systemFontOfSize:17];
        self.L_status.textColor=[UIColor greenColor];
        
        self.L_bianMa=[[UILabel alloc]init];
        self.L_bianMa.font=[UIFont systemFontOfSize:12];
        self.L_bianMa.textColor=[UIColor grayColor];
        
        self.B_liuyan = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.B_liuyan];
       
        
        self.L_numliuyan = [[UILabel alloc]init];
        [self addSubview:self.L_numliuyan];
        self.L_numliuyan.font=[UIFont systemFontOfSize:12];
        
        self.B_zan = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.B_zan];
        
        self.B_numzan = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.B_numzan];
        self.B_numzan.titleLabel.font=[UIFont systemFontOfSize:12];
        
        //下面增加确定的约束
        [self.L_rwname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.L_status.mas_left).mas_offset(-5);
        }];
        [self.L_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
        [self.B_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.L_status.mas_left).mas_offset(-5);
        }];
        [self.L_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 15));
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
        [self.B_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-2.5);
            make.left.mas_equalTo(self.mas_right).mas_offset(-130);
        }];
        
        [self.L_numliuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.left.mas_equalTo(self.B_liuyan.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-2.5);
        }];
        
        [self.B_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
             make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-2.5);
            make.left.mas_equalTo(self.mas_right).mas_offset(-90);
        }];
        
        [self.B_numzan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.left.mas_equalTo(self.B_zan.mas_right).mas_offset(10);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-2.5);
        }];
        
        
        
        
        
    }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
