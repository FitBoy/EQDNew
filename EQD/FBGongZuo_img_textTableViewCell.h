//
//  FBGongZuo_img_textTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 显示图文的cell 80+15 + 图文高度+24(地址)

#import <UIKit/UIKit.h>
#import "MoreBaseModel.h"
@interface FBGongZuo_img_textTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UIView *V_top;
@property (nonatomic,strong)  UIView *V_bottom;

@property (nonatomic,strong)  UILabel *L_address;
@property (nonatomic,strong)  UIImageView *IV_head;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_left1;
@property (nonatomic,strong)  UIImageView  *IV_right0;
@property (nonatomic,strong)  UILabel *L_right1;
@property (nonatomic,strong)  UILabel *L_contents;

@property (nonatomic,strong)  UIImageView *IV_zan;
@property (nonatomic,strong)  UIImageView *IV_liuyan;
@property (nonatomic,strong)  UILabel *L_zan;
@property (nonatomic,strong)  UILabel *L_liuyan;

///三张点赞人的头像
@property (nonatomic,strong)  UIImageView *IV_zan1;
@property (nonatomic,strong)  UIImageView *IV_zan2;
@property (nonatomic,strong)  UIImageView *IV_zan3;
@property (nonatomic,strong)  UIImageView *IV_zan4;

///有图片显示的3张图片
@property (nonatomic,strong)  UIImageView *IV_img1;
@property (nonatomic,strong)  UIImageView *IV_img2;
@property (nonatomic,strong)  UIImageView *IV_img3;
@property (nonatomic,strong)  UILabel *L_imgnum;

///返回此cell的高度
@property (nonatomic,assign) float cell_height;
@property (nonatomic,strong)  MoreBaseModel *model;
-(void)setModel:(MoreBaseModel *)model;
///点赞 更新
-(void)updateZan_numWithuserphoto:(NSString*)userPhoto Andmodel:(MoreBaseModel*)model;
///更新留言数
-(void)updateliuyan;
@end
