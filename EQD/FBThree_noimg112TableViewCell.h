//
//  FBThree_noimg112TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 左2 右1

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
@interface FBThree_noimg112TableViewCell : UITableViewCell
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_left1;
@property (nonatomic,strong)  UILabel *L_right;
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;
@end
