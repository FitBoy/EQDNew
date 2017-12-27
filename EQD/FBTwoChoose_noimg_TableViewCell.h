//
//  FBTwoChoose_noimg_TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 上下显示的label 有选择框

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
@interface FBTwoChoose_noimg_TableViewCell : UITableViewCell
@property (nonatomic,strong) UIView *V_bg;
@property (nonatomic,strong)  UIImageView *IV_choose;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_left1;
@property (nonatomic,strong)  FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;

@end
