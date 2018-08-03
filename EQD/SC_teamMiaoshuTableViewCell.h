//
//  SC_teamMiaoshuTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 人物介绍的cell

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "SC_TeamModel.h"
#import "WS_equipmentModel.h"
@interface SC_teamMiaoshuTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_head;
@property (nonatomic,strong) YYLabel *YL_name;
@property (nonatomic,strong)  YYLabel *YL_contents;

///团队介绍
@property (nonatomic,strong)  SC_TeamModel *model_team;
-(void)setModel_team:(SC_TeamModel *)model_team;

///设备信息
@property (nonatomic,strong)  WS_equipmentModel  *model_equipment;
-(void)setModel_equipment:(WS_equipmentModel *)model_equipment;

@end
