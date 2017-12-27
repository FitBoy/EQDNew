//
//  GZQ_top_headView.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZQ_top_headView : UIView
@property (nonatomic,strong)  UIImageView *IV_bg;
@property (nonatomic,strong) UILabel *L_name;
@property (nonatomic,strong)  UIImageView *IV_head;
@property (nonatomic,strong)  UILabel *L_sign;
///背景图地址  头像地址  名字
@property (nonatomic,strong)  NSArray *arr_contents;
-(void)setArr_contents:(NSArray *)arr_contents;
@end
