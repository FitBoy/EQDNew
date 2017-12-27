//
//  DaKa_JiLuTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaKaJiLuModel.h"

@interface DaKa_JiLuTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UILabel *L_time;
@property (nonatomic,strong)  UILabel *L_shuoming;
@property (nonatomic,strong)  UILabel *L_status;
@property (nonatomic,strong)  DaKaJiLuModel *model;
-(void)setModel:(DaKaJiLuModel *)model;
@end
