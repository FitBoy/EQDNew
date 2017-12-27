//
//  FanKuiTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FanKuiModel.h"
@interface FanKuiTableViewCell : UITableViewCell
@property (nonatomic,strong) UIView *V_bg;
@property (nonatomic,strong)  UILabel *L_title;
@property (nonatomic,strong)  UILabel *L_type;
@property (nonatomic,strong)  UILabel *L_status;
@property (nonatomic,strong)  FanKuiModel *model;
-(void)setModel:(FanKuiModel *)model;
@end
