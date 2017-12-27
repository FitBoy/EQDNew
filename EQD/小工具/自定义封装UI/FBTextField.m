//
//  FBTextField.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTextField.h"

@implementation FBTextField
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return [self initWithFrame:CGRectMake(0, 0, 0, 0)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
