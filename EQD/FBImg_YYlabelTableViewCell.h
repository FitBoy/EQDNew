//
//  FBImg_YYlabelTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/26.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "EQDS_teacherInfoModel.h"
@interface FBImg_YYlabelTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_head;
@property (nonatomic,strong) YYLabel *YL_text;
@property (nonatomic,strong)  EQDS_teacherInfoModel *model_teacherInfo;
-(void)setModel_teacherInfo:(EQDS_teacherInfoModel *)model_teacherInfo;
@end
