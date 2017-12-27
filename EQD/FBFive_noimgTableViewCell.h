//
//  FBFive_noimgTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 高 90

#import <UIKit/UIKit.h>
#import "DaKaJiLu.h"
@interface FBFive_noimgTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_right0;
@property (nonatomic,strong) UILabel *L_left1;
@property (nonatomic,strong)  UILabel *L_right1;
@property (nonatomic,strong)  UILabel *L_bottom;
@property (nonatomic,strong)  DaKaJiLu *model;
-(void)setModel:(DaKaJiLu *)model;
@end
