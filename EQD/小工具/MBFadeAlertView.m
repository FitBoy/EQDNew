//
//  MBFadeAlertView.m
//  MatchNet
//
//  Created by 张花蕊 on 16/11/30.
//  Copyright (c) 2016年 汇亚科技. All rights reserved.
//

#import "MBFadeAlertView.h"
#import "AppDelegate.h"

//整个view的展示宽度
#define    MBFadeWidth          [UIScreen mainScreen].bounds.size.width - 120

@interface MBFadeAlertView ()


@end

@implementation MBFadeAlertView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //初始化
        self.textFont           =   [UIFont systemFontOfSize:13.0f];
        self.fadeWidth          =   MBFadeWidth;
        self.fadeBGColor        =   [UIColor colorWithRed:94.0/255.0f green:105.0/255.0f blue:107.0/255.0f alpha:1.0f];
        self.titleColor         =   [UIColor whiteColor];
        self.textOffWidth       =   18;
        self.textOffHeight      =   8;
        self.textBottomHeight   =   120;
        self.fadeTime           =   1.5;
        self.FadeBGAlpha        =   0.8;
    }
    return self;
}


- (void)showAlertWith:(NSString *)str
{
    self.alpha = 0;
    
    NSDictionary *attribute = @{NSFontAttributeName: self.textFont};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MBFadeWidth, FLT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    
    CGFloat width  = rect.size.width  + self.textOffWidth;
    CGFloat height = rect.size.height + self.textOffHeight;
    
    
    self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width- width)/2, [UIScreen mainScreen].bounds.size.height - height - self.textBottomHeight, width, height);
    self.backgroundColor = self.fadeBGColor;
    
    //圆角
    self.layer.masksToBounds = YES;
    
    //一行大圆角，超过一行小圆角
    if (rect.size.height > 21) {
        
        self.layer.cornerRadius = 10/2;
    }else
    {
        self.layer.cornerRadius = height/2;
    }
    
    
    UILabel *tmpLabel = [[UILabel alloc] init];
    tmpLabel.text = str;
    tmpLabel.numberOfLines = 0;
    tmpLabel.backgroundColor = [UIColor clearColor];
    tmpLabel.textColor = self.titleColor;
    tmpLabel.textAlignment = NSTextAlignmentCenter;
    tmpLabel.font = self.textFont;
    tmpLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:tmpLabel];
    
    
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window addSubview:self];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    self.alpha = self.FadeBGAlpha;
    [UIView commitAnimations];
    
    //存在时间
    [self performSelector:@selector(fadeAway) withObject:nil afterDelay:self.fadeTime];
}
// 渐变消失
- (void)fadeAway
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    self.alpha = .0;
    [UIView commitAnimations];
    [self performSelector:@selector(remove) withObject:nil afterDelay:0.5f];
}
// 从上层视图移除并释放
- (void)remove
{
    [self removeFromSuperview];
}

@end
