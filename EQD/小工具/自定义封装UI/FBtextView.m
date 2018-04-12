//
//  FBtextView.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/31.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBtextView.h"

@implementation FBtextView
-(void)setPlaceHoder:(NSString *)placeHoder
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeHoder;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    placeHolderLabel.font = [UIFont systemFontOfSize:17.f];
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
