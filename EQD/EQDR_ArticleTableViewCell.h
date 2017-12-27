//
//  EQDR_ArticleTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "EQDR_articleListModel.h"
@interface EQDR_ArticleTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_top;
@property (nonatomic,strong)  UIView *V_bottom;

///头
@property (nonatomic,strong)  UIImageView *IV_head;
@property (nonatomic,strong) YYLabel *YL_name;
@property (nonatomic,strong)  UILabel *L_time;
@property (nonatomic,strong)  UIImageView *IV_fenXiang;

///肚
@property (nonatomic,strong) UIImageView  *IV_img;
@property (nonatomic,strong)  YYLabel *YL_titleContent;

///行业分类
@property (nonatomic,strong)  YYLabel *YL_hangye;
///来源
@property (nonatomic,strong)   YYLabel *L_source;

///阅读点赞留言分类
@property (nonatomic,strong)  UILabel *L_RPL;

@property (nonatomic,strong)  EQDR_articleListModel *model;
-(void)setModel:(EQDR_articleListModel *)model;


@end
