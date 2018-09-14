//
//  FByylabel_btnOnerightTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/9/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBButton.h"
#import <YYText.h>
#import "PX_courseManageModel.h"
@interface FByylabel_btnOnerightTableViewCell : UITableViewCell
@property (nonatomic,strong)  YYLabel  *yy_label;
@property (nonatomic,strong)  FBButton  *btn_right;

@property (nonatomic,strong)  PX_courseManageModel *model_course;
-(void)setModel_course:(PX_courseManageModel *)model_course;
@end
