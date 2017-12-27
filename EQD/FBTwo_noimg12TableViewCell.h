//
//  FBTwo_noimg12TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
@interface FBTwo_noimg12TableViewCell : UITableViewCell
///左右显示的label
@property (nonatomic,strong) UIView *V_bg;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_right0;
@property (nonatomic,strong)  FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;
@end
