//
//  GZQ_top_DetailView.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 图片最多9张 ，文字不限 ，其他几乎仿工作圈的布局

#import <UIKit/UIKit.h>
#import "GongZuoQunModel.h"
@interface GZQ_top_DetailView : UIView
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UIView *V_top;
@property (nonatomic,strong)  UIView *V_bottom;
@property (nonatomic,strong)  UILabel *L_contents;

///头部的布局
@property (nonatomic,strong)  UIImageView *IV_head;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_bumen;
@property (nonatomic,strong)  UIImageView *IV_zhuanfa;
@property (nonatomic,strong)  UILabel *L_time;

///底部的布局
@property (nonatomic,strong)  UIImageView *IV_zan;
@property (nonatomic,strong)  UIImageView *IV_liuyan;
@property (nonatomic,strong)  UILabel *L_zan;
@property (nonatomic,strong)  UILabel *L_liuyan;
@property (nonatomic,strong)  UILabel *L_address;
///三张点赞人的头像
@property (nonatomic,strong)  UIImageView *IV_zan1;
@property (nonatomic,strong)  UIImageView *IV_zan2;
@property (nonatomic,strong)  UIImageView *IV_zan3;
@property (nonatomic,strong)  UIImageView *IV_zan4;

///有图片显示的9张图片
@property (nonatomic,strong)  UIImageView *IV_img1;
@property (nonatomic,strong)  UIImageView *IV_img2;
@property (nonatomic,strong)  UIImageView *IV_img3;
@property (nonatomic,strong)  UIImageView *IV_img4;
@property (nonatomic,strong)  UIImageView *IV_img5;
@property (nonatomic,strong)  UIImageView *IV_img6;
@property (nonatomic,strong)  UIImageView *IV_img7;
@property (nonatomic,strong)  UIImageView *IV_img8;
@property (nonatomic,strong)  UIImageView *IV_img9;
///存放九张图片
@property (nonatomic,strong)  NSMutableArray *arr_imgs;

///返回view 显示的高度
@property (nonatomic,assign) float height_view;
@property (nonatomic,strong)  GongZuoQunModel *model;
-(void)setModel:(GongZuoQunModel *)model;

///点赞 更新
-(void)updateZan_numWithuserphoto:(NSString*)userPhoto Andmodel:(MoreBaseModel*)model;
///更新留言数
-(void)updateliuyan;
///更新留言 -1
-(void)updateliuyan2;
@end
