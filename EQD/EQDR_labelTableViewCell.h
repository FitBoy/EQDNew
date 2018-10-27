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
#import "GongGao_ListModel.h"
#import "GNmodel.h"
#import "TrumModel.h"
#import "RiZhiModel.h"
#import "GZQ_PingLunModel.h"
#import "EQDS_BaseModel.h"
@interface EQDR_labelTableViewCell : UITableViewCell

///最新的文章
@property (nonatomic,strong)  EQDS_BaseModel  *model_base;
-(void)setModel_base:(EQDS_BaseModel *)model_base;
///最新的课程
-(void)setModel_base2:(EQDS_BaseModel *)model_base;

///日志的评论
@property (nonatomic,strong)   GZQ_PingLunModel *model_RiZhiPingLun;
-(void)setModel_RiZhiPingLun:(GZQ_PingLunModel *)model_RiZhiPingLun;
///日志
@property (nonatomic,strong)  RiZhiModel *model_rizhi;
-(void)setModel_rizhi:(RiZhiModel *)model_rizhi;
///小喇叭
@property (nonatomic,strong) TrumModel *model_trum;
-(void)setModel_trum:(TrumModel *)model_trum;
@property (nonatomic,strong)  YYLabel *YL_label;
///字号15
@property (nonatomic,copy) NSString* address;
-(void)setAddress:(NSString *)address;
///字号 18
@property (nonatomic,copy) NSString* contents;
-(void)setContents:(NSString *)contents;
/// 里面的model 是 GNmodel
@property (nonatomic,strong)  NSArray *arr_json;
-(void)setArr_json:(NSArray *)arr_json;

/// 简单的输入选择
@property (nonatomic,strong)  GNmodel *model_GN;
-(void)setModel_GN:(GNmodel *)model_GN;


@property (nonatomic,strong)  GongGao_ListModel  *model_gonggao;
-(void)setModel_gonggao:(GongGao_ListModel *)model_gonggao;

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
///匹配的课程
-(void)setModel_pipei:(EQDS_CourseModel *)model_pipei;

/// 易企学的培训需求
@property (nonatomic,strong)  PXNeedModel *model_need;
-(void)setModel_need:(PXNeedModel *)model_need;
///没有预算的培训需求
-(void)setModel_need2:(PXNeedModel *)model_need;
@end
@protocol EQDR_labelTableViewCellDelegate <NSObject>
-(void)getTapNameWithname:(NSString*)name  Guid:(NSString*)Guid model:(id)model;
-(void)getTapTypeWithtype:(NSString*)type model:(id)model;

///日志的评论的delegate  0 是第一个人 1是第二个人 2内容 12 长按内容
-(void)getPingLunRiZhiModel:(GZQ_PingLunModel*)model_pinglun Withtemp:(NSInteger)temp;
@end

