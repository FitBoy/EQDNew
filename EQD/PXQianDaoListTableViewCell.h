//
//  PXQianDaoListTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/1.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXKaoQinListModel.h"

@interface PXQianDaoListTableViewCell : UITableViewCell
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_left1;

@property (nonatomic,strong)  UILabel *L_right0;
@property (nonatomic,strong)  UILabel *L_right1;

@property (nonatomic,strong)  UILabel *L_center;

@property (nonatomic,strong)  PXKaoQinListModel *model;

-(void)setModel:(PXKaoQinListModel *)model;

@end
