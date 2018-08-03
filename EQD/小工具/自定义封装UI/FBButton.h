//
//  FBButton.h
//  EQD
//
//  Created by 梁新帅 on 2017/3/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBButton : UIButton
-(void)setTitle:(NSString*)title titleColor:(UIColor*)titlecolor backgroundColor:(UIColor*)backgroundColor  font:(UIFont*)font;
@property (nonatomic,strong)  NSIndexPath *indexpath;

///工作日志是第一个增加的
@property (nonatomic,assign) NSInteger temp;
@end
