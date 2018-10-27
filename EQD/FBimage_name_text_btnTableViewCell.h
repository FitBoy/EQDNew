//
//  FBimage_name_text_btnTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/9/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 推荐的讲师的样式


#import <UIKit/UIKit.h>
#import "eQDS_teacherAndSearchModel.h"
#import <YYText.h>
#import "FBButton.h"
#import "EQDS_teacherInfoModel.h"
@interface FBimage_name_text_btnTableViewCell : UITableViewCell

@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong)  UILabel *L_name;
////下面的需要重新自己布局
@property (nonatomic,strong)  YYLabel *YL_text;
@property (nonatomic,strong) YYLabel *YL_price;
@property (nonatomic,strong)  FBButton *B_shoucang;
@property (nonatomic,strong)  eQDS_teacherAndSearchModel *model_teacher;
@property (nonatomic,strong)  EQDS_teacherInfoModel *model_info;
///推荐的讲师
-(void)setModel_teacher:(eQDS_teacherAndSearchModel *)model_teacher;

///有收藏的推荐讲师
-(void)setModel_teacher2:(eQDS_teacherAndSearchModel *)model_teacher;
/// 活跃的讲师 最新的讲师 有价格与收藏
-(void)setModel_info:(EQDS_teacherInfoModel *)model_info;

@end
