//
//  FBTwoButtonView.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTwoButtonView.h"
#import <Masonry.h>
@implementation FBTwoButtonView
-(void)setleftname:(NSString*)leftname rightname:(NSString*)rightname
{
    [self.B_left setTitle:leftname titleColor:[UIColor whiteColor] backgroundColor:[UIColor redColor] font:[UIFont systemFontOfSize:17]];
    [self.B_right setTitle:rightname titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1] font:[UIFont systemFontOfSize:17]];
    
}
-(FBButton*)B_left
{
    if (!_B_left) {
        _B_left =[FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_left];
        [_B_left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(self.mas_centerX).mas_offset(-5);
        }];
        
    }
    return _B_left;
}
-(FBButton *)B_right
{
    if (!_B_right) {
        _B_right =[FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_right];
        [_B_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.mas_centerX).mas_offset(5);
        }];
        
    }
    return _B_right;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
