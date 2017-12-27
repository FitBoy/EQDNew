//
//  MyShouCangTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 上下边 内5   左右边内15
// 5+30+5 头像一行
//总高度 40 + width + 25

#import <UIKit/UIKit.h>
#import "MyShouCangModel.h"
@interface MyShouCangTableViewCell : UITableViewCell

@property (nonatomic,strong)  UIImageView  *IV_head;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_time;


@property (nonatomic,strong)  UILabel *L_content;

//最多显示的3张图片
@property (nonatomic,strong)  UIImageView *IV_img1;
@property (nonatomic,strong)  UIImageView *IV_img2;
@property (nonatomic,strong)  UIImageView *IV_img3;

@property (nonatomic,strong)  UILabel *L_from;


@property (nonatomic,strong)  MyShouCangModel  *model;

-(void)setModel:(MyShouCangModel *)model;
@end
