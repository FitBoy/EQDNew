//
//  RiZhiListTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/4/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIZhiListModel.h"
#import "FBSegmentedControl.h"
#import <YYText.h>
@interface RiZhiListTableViewCell : UITableViewCell
@property (nonatomic,strong)  RIZhiListModel *model_rizhiList;
-(void)setModel_rizhiList:(RIZhiListModel *)model_rizhiList;
@property (nonatomic,strong)  UIView *V_top;//50
@property (nonatomic,strong)  UIView *V_bottom;//40
@property (nonatomic,strong)  UIView  *V_contents;// 自适应
@property (nonatomic,strong)  UIView *V_pinglun;

// 头部
@property (nonatomic,strong)  UIImageView  *IV_head;
@property (nonatomic,strong)  UILabel *L_bumen;
@property (nonatomic,strong)  UILabel *L_time;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UIImageView *IV_fenxiang;
// 底部
@property (nonatomic,strong)  UIImageView *IV_zan1;
@property (nonatomic,strong) UIImageView *IV_zan2;
@property (nonatomic,strong)  UIImageView *IV_zan3;
@property (nonatomic,strong)  UIImageView *IV_zan4;

@property (nonatomic,strong)  UIImageView *IV_zan;
@property (nonatomic,strong)  UIImageView *IV_liuyan;
@property (nonatomic,strong)  UILabel *L_zan;
@property (nonatomic,strong)  UILabel *L_liuyan;

///内容
@property (nonatomic,strong) FBSegmentedControl *S_fourItems;
@property (nonatomic,strong) YYLabel *YL_lcontents;
///评论
@property (nonatomic,strong)  YYLabel *YL_pinglun;

@property (nonatomic,weak) id delegate_rizhi;

-(void)updateZanWithmodel:(RIZhiListModel*)model AndImg:(NSString*)userImg;
@end
@protocol RiZhiListTableViewCellDelegate <NSObject>
///   0是前面人的  1是后面人的   2 是对内容进行回复   3是对内容的长按
-(void)getPinglunModel:(GZQ_PingLunModel *)model_pinglun AndisHuifu:(NSInteger) isHuifu;
///查看更多
-(void)getMoreWithrizhiModel:(RIZhiListModel*)model_more;
@end
