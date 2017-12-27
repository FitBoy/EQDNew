//
//  FBTwo_noImg11TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 上下label 显示

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
@interface FBTwo_noImg11TableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong) UILabel *L_left0;
@property (nonatomic,strong) UILabel *L_left1;
@property (nonatomic,strong) FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;

@end
