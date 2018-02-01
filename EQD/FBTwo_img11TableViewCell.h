//
//  FBTwo_img11TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
#import "EQDS_teacherInfoModel.h"
/// 头像--- 上下显示label
@interface FBTwo_img11TableViewCell : UITableViewCell
@property (nonatomic,strong) UIView *V_bg;
@property (nonatomic,strong) UIImageView *IV_img;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_left1;
@property (nonatomic,strong)  FBBaseModel *model;
@property (nonatomic,strong) EQDS_teacherInfoModel *model_techerInfo;
-(void)setModel:(FBBaseModel *)model;
-(void)setModel_techerInfo:(EQDS_teacherInfoModel *)model_techerInfo;
@end
