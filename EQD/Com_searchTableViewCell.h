//
//  Com_searchTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/12/20.
//  Copyright © 2018 FitBoy. All rights reserved.
// 企业的头像图片在右边   左边分别是企业名称 + 地区/规模

#import <UIKit/UIKit.h>
#import "Com_searchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Com_searchTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_image;
@property (nonatomic,strong) UILabel *L_name;
@property (nonatomic,strong) UILabel *L_place;

@property (nonatomic,strong)  Com_searchModel *model_com;
-(void)setModel_com:(Com_searchModel * _Nonnull)model_com;
@end

NS_ASSUME_NONNULL_END
