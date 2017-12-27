//
//  FBOneImg_LabelButtonTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 我的粉丝 我的关注

#import <UIKit/UIKit.h>
#import "FBButton.h"
#import "EQDR_MyAttentionModel.h"
@interface FBOneImg_LabelButtonTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_headimg;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  FBButton *B_btn;

///我的关注
@property (nonatomic,strong)  EQDR_MyAttentionModel *model;
-(void)setModel:(EQDR_MyAttentionModel *)model;
///我的粉丝的模型
-(void)setModel2:(EQDR_MyAttentionModel *)model;
@end
