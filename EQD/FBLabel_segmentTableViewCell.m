//
//  FBLabel_segmentTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBLabel_segmentTableViewCell.h"
#import <Masonry.h>
@implementation FBLabel_segmentTableViewCell

-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        _L_name.font = [UIFont systemFontOfSize:17];
        [self addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.SC_choose.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_name;
}
-(UISegmentedControl*)SC_choose
{
    if (!_SC_choose) {
        _SC_choose = [[FBSegmentedControl alloc]initWithItems:@[@"无",@"有"]];
        [self addSubview:_SC_choose];
        [_SC_choose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _SC_choose;
}

@end
