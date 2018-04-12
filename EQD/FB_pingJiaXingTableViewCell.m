//
//  FB_pingJiaXingTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FB_pingJiaXingTableViewCell.h"
#import <Masonry.h>
@implementation FB_pingJiaXingTableViewCell

-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        [self addSubview:_L_name];
        _L_name.font = [UIFont systemFontOfSize:15];
        _L_name.numberOfLines = 0;
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top);
        }];
        
    }
    return  _L_name;
}
-(FBStarView*)starView
{
    if (!_starView) {
        float width = (DEVICE_WIDTH-30-45)/10.0;
        _starView = [[FBStarView alloc]initWithFrame:CGRectMake(0, 25,DEVICE_WIDTH, width+20)];
        [self addSubview:_starView];
        
    }
    return _starView;
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
