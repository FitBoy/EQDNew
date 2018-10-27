//
//  S_tableHeadView.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "S_tableHeadView.h"
#import <Masonry.h>
@implementation S_tableHeadView
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        _L_name.font = [UIFont systemFontOfSize:17];
        _L_name.textAlignment = NSTextAlignmentCenter;
        _L_name.textColor = [UIColor grayColor];
        [self addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 30));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
    }
    return _L_name;
}

-(FBButton*)B_more
{
    if (!_B_more) {
        _B_more = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_more];
        [_B_more setTitle:@"更多" titleColor:nil backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
        [_B_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 30));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _B_more;
}
-(void)setname:(NSString *)name btnHidden:(BOOL)hidden
{
    self.L_name.text = name;
    self.B_more.hidden = hidden;
}
@end
