//
//  EQDR_PingLunTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "EQDR_pingLunModel.h"
@interface EQDR_PingLunTableViewCell : UITableViewCell
@property (nonatomic,strong) UIView* V_top;

@property (nonatomic,strong) UIImageView *IV_head;
@property (nonatomic,strong) YYLabel  *YL_name;
@property (nonatomic,strong)  UILabel *L_time;
@property (nonatomic,strong)  UIImageView *IV_liuyan;
@property (nonatomic,strong)  UIImageView *IV_zan;
@property (nonatomic,strong)  UILabel *L_liuyan;
@property (nonatomic,strong)  UILabel *L_zan;

//内容
@property (nonatomic,strong)  YYLabel *YL_content;
@property (nonatomic,strong)  YYLabel *YL_pinglunContent;



@property (nonatomic,strong)  EQDR_pingLunModel *model;
-(void)setModel:(EQDR_pingLunModel *)model;


@end
