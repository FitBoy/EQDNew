//
//  FBThree_noimg122TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//左 1 右 2

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
@interface FBThree_noimg122TableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UILabel *L_left;
@property (nonatomic,strong)  UILabel *L_right0;
@property (nonatomic,strong)  UILabel *L_right1;

@property (nonatomic,strong)  FBBaseModel *model;

-(void)setModel:(FBBaseModel *)model;


@end
