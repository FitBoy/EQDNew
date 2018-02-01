//
//  EQDR_labelTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "PX_courseManageModel.h"
@interface EQDR_labelTableViewCell : UITableViewCell
@property (nonatomic,strong)  YYLabel *YL_label;


@property (nonatomic,strong)  PX_courseManageModel *model_course;
///课程管理
-(void)setModel_course:(PX_courseManageModel *)model_course;


@end
