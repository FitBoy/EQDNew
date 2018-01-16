//
//  GZQ_PingLunTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZQ_PingLunModel.h"
#import <YYText.h>
@interface GZQ_PingLunTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
///头部
@property (nonatomic,strong)  UIView *V_top;
///内容
@property (nonatomic,strong)  UILabel *L_contents;
///富文本内容
@property (nonatomic,strong)  YYLabel *yyL_fuwenben;

///头部的详细 头像
@property (nonatomic,strong)  UIImageView *IV_head;
///名字
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_bumen;
@property (nonatomic,strong)  UILabel *L_time;
@property (nonatomic,strong)  UIImageView *IV_liuyan;

@property (nonatomic,strong) UILabel *L_more;
///模型类
@property (nonatomic,strong)  GZQ_PingLunModel *model;
-(void)setModel:(GZQ_PingLunModel *)model;

@end


