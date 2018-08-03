//
//  Com_dongTanTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FB_topView.h"
#import "FB_bottomView.h"
#import "Com_dongTanModel.h"
#import <YYText.h>
@interface Com_dongTanTableViewCell : UITableViewCell

///头部
@property (nonatomic,strong)  FB_topView  *V_top;
///底部第一层
@property (nonatomic,strong)  FB_bottomView  *V_bottom;
///中间内容
@property (nonatomic,strong)  UIView *V_content;
/// 评论区域
@property (nonatomic,strong) UIView *V_pinglun;


///中间的内容与位置
@property (nonatomic,strong)  UILabel *L_title;
@property (nonatomic,strong)  YYLabel *YL_contents;

///三张图片
@property (nonatomic,strong) UIImageView *IV_img1;
@property (nonatomic,strong) UIImageView *IV_img2;
@property (nonatomic,strong)  UIImageView *IV_img3;

///评论的内容
@property (nonatomic,strong)  YYLabel *YL_pinglun;

@property (nonatomic,strong) Com_dongTanModel  *model_dongtai;
-(void)setModel_dongtai:(Com_dongTanModel *)model_dongtai;

@property (nonatomic,weak) id delegate_dongtai;
@end

@protocol Com_dongTanTableViewCellDelegate <NSObject>
///   0是前面人的  1是后面人的   2 是对内容进行回复   3是对内容的长按
-(void)getDongTaiModel:(GZQ_PingLunModel *)model_pinglun AndisHuifu:(NSInteger) isHuifu;
///查看更多
-(void)getMoreWithDongTaiModel:(Com_dongTanModel*)model_more;
@end
