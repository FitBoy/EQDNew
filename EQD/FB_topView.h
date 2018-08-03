//
//  FB_topView.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 50

#import <UIKit/UIKit.h>

@interface FB_topView : UIView
@property (nonatomic,strong)  UIImageView *IV_head;
///左上
@property (nonatomic,strong)  UILabel *L_name;
///左下
@property (nonatomic,strong)  UILabel *L_bumen;
///右上
@property (nonatomic,strong)  UIImageView *IV_fenxiang;
///右下
@property (nonatomic,strong) UILabel *L_time;

-(void)setHead:(NSString*)Head name:(NSString*)name bumen:(NSString*)bumen time:(NSString*)time;
@end
