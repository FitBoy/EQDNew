//
//  BottomMoreView.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "BottomMoreView.h"

@implementation BottomMoreView
-(void)setMorename:(NSString *)more right:(NSString *)right center:(NSString *)center
{
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.backgroundColor = [UIColor grayColor];
    [self.B_more setTitle:more titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18]];
    
    [self.B_center setTitle:center titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18]];
    [self.B_right setTitle:right titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18]];
}
-(FBButton*)B_more
{
    if (!_B_more) {
        _B_more = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_more];
        _B_more.frame = CGRectMake(0, 0, (self.frame.size.width-2)/3.0, 40);
    }
    return _B_more;
}
-(FBButton*)B_right
{
    if (!_B_right) {
        _B_right = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_right];
        _B_right.frame = CGRectMake(self.frame.size.width-(self.frame.size.width-2)/3.0, 0, (self.frame.size.width-2)/3.0, 40);
    }
    return _B_right;
}
-(FBButton*)B_center
{
    if (!_B_center) {
        _B_center = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_center];
        _B_center.frame = CGRectMake((self.frame.size.width-2)/3.0+1, 0, (self.frame.size.width-2)/3.0, 40);
    }
    return _B_center;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
