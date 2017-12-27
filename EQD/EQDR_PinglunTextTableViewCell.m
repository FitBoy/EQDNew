//
//  EQDR_PinglunTextTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_PinglunTextTableViewCell.h"

@implementation EQDR_PinglunTextTableViewCell

-(YYLabel*)YL_content
{
    if (!_YL_content) {
        _YL_content = [[YYLabel alloc]init];
        _YL_content.numberOfLines=0;
        [self addSubview:_YL_content];
    }
    return _YL_content;
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
