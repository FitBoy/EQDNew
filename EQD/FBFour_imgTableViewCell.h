//
//  FBFour_imgTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 头像 +4 个label

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
@interface FBFour_imgTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UIImageView *IV_header;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_left1;
@property (nonatomic,strong)  UILabel *L_right0;
@property (nonatomic,strong)  UILabel *L_right1;
@property (nonatomic,strong)  FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;

@end
