//
//  FBFour_noimgTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
@interface FBFour_noimgTableViewCell : UITableViewCell
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_right0;
@property (nonatomic,strong)  UILabel *L_left1;
@property (nonatomic,strong)  UILabel *L_right1;
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;


@end
