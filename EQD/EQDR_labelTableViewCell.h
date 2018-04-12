//
//  EQDR_labelTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "PX_courseManageModel.h"
#import "EQDS_CourseModel.h"
#import "PXNeedModel.h"
#import "PX_NotificationListModel.h"
#import "My_BaoXiaoModel.h"
@interface EQDR_labelTableViewCell : UITableViewCell

@property (nonatomic,strong)  YYLabel *YL_label;

@property (nonatomic,strong)  My_BaoXiaoModel *model_baoxiao;
///报销列表
-(void)setModel_baoxiao:(My_BaoXiaoModel *)model_baoxiao;

@property (nonatomic,strong)  PX_NotificationListModel *model_notification;
///培训通知
-(void)setModel_notification:(PX_NotificationListModel *)model_notification;

@property (nonatomic,strong)  PX_courseManageModel *model_course;
///课程管理
-(void)setModel_course:(PX_courseManageModel *)model_course;

///易企学的最新课程
@property (nonatomic,strong)  PX_courseManageModel  *model_courseMin;
-(void)setModel_courseMin:(PX_courseManageModel *)model_courseMin;
/// 最新课程才有的点击事
@property (nonatomic,weak) id  delegate;

/// 易企学的 推荐课程
@property (nonatomic,strong)  EQDS_CourseModel  *model_tuijian;
-(void)setModel_tuijian:(EQDS_CourseModel *)model_tuijian;
/// 易企学的培训需求
@property (nonatomic,strong)  PXNeedModel *model_need;
-(void)setModel_need:(PXNeedModel *)model_need;
@end
@protocol EQDR_labelTableViewCellDelegate <NSObject>
-(void)getTapNameWithname:(NSString*)name  Guid:(NSString*)Guid model:(id)model;
-(void)getTapTypeWithtype:(NSString*)type model:(id)model;
@end

