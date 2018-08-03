//
//  SC_fangKeTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 5+ 50 +5+20+5  访客

#import <UIKit/UIKit.h>
#import "FB_topView.h"
#import "SC_fangKeModel.h"
@interface SC_fangKeTableViewCell : UITableViewCell
@property (nonatomic,strong)  FB_topView  *V_top;
@property (nonatomic,strong)  UILabel *L_contents;
@property (nonatomic,strong)  SC_fangKeModel *model_fangke;
-(void)setModel_fangke:(SC_fangKeModel *)model_fangke;
@end
