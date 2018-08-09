//
//  FBunderLineTextField.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBunderLineTextField.h"

@implementation FBunderLineTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef   context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1));
}


@end
