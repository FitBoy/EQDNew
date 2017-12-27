//
//  ZUZhi_ExpandTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZuZhiModel.h"
@interface ZUZhi_ExpandTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UIImageView *IV_icon;
@property (nonatomic,strong)  UIImageView *IV_choose;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  ZuZhiModel *model;
-(void)setModel:(ZuZhiModel *)model;
@end
