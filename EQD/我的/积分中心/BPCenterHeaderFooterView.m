//
//  BPCenterHeaderFooterView.m
//  EQD
//
//  Created by 梁新帅 on 2018/11/13.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "BPCenterHeaderFooterView.h"
#import <Masonry.h>
@implementation BPCenterHeaderFooterView

-(FBButton*)tbtn_title
{
    if (!_tbtn_title) {
        _tbtn_title = [FBButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_tbtn_title];
        _tbtn_title.userInteractionEnabled = NO;
        [_tbtn_title setBackgroundImage:[UIImage imageNamed:@"C_headBg"] forState:UIControlStateNormal];
        [_tbtn_title setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _tbtn_title.titleLabel.font = [UIFont systemFontOfSize:21];
        [_tbtn_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 30));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
    }
    return _tbtn_title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
