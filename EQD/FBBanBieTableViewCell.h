//
//  FBBanBieTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//  整体140  背景130

#import <UIKit/UIKit.h>
#import "BanbieModel.h"
@interface FBBanBieTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_time;
@property (nonatomic,strong)  UILabel *L_week;
@property (nonatomic,strong)  UILabel *L_holidays;
@property (nonatomic,strong)  UILabel *L_shuoming;
@property (nonatomic,strong)  BanbieModel *model;
-(void)setModel:(BanbieModel *)model;
@end
