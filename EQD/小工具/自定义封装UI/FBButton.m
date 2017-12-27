//
//  FBButton.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBButton.h"

@implementation FBButton
-(void)setTitle:(NSString*)title titleColor:(UIColor*)titlecolor backgroundColor:(UIColor*)backgroundColor  font:(UIFont*)font {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:titlecolor forState:UIControlStateNormal];
    [self setBackgroundColor:backgroundColor];
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius = 3;
    self.titleLabel.font = font;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
