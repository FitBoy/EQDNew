//
//  FB_CollectionLinkTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 5+30 +5  头部  50+5+20+5 中部与尾部


#import <UIKit/UIKit.h>
#import "MyShouCangModel.h"
@interface FB_CollectionLinkTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *IV_head;
@property (nonatomic,strong) UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_time;

@property (nonatomic,strong) UIImageView *IV_Link;
@property (nonatomic,strong) UILabel *L_content;

@property (nonatomic,strong) UILabel *L_source;

@property (nonatomic,strong)  MyShouCangModel *model;
-(void)setModel:(MyShouCangModel *)model;
//类别是大类的布局
-(void)setModel2:(MyShouCangModel *)model;
@end
