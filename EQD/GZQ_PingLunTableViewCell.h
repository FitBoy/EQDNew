//
//  GZQ_PingLunTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZQ_PingLunModel.h"
#import <YYText.h>
@interface GZQ_PingLunTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
///头部
@property (nonatomic,strong)  UIView *V_top;
///内容
@property (nonatomic,strong)  UILabel *L_contents;
///富文本内容
@property (nonatomic,strong)  YYLabel *yyL_fuwenben;

///头部的详细 头像
@property (nonatomic,strong)  UIImageView *IV_head;
///名字
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UILabel *L_bumen;
@property (nonatomic,strong)  UILabel *L_time;
@property (nonatomic,strong)  UIImageView *IV_liuyan;

@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,weak) id delegate;
///模型类
@property (nonatomic,strong)  GZQ_PingLunModel *model;
-(void)setModel:(GZQ_PingLunModel *)model;
/// 更新 点赞
-(NSAttributedString*)updatefuwenbenWithmodel:(GZQ_PingLunModel*)model userGuid:(NSString*)userGuid;
@end

@protocol GZQ_PingLunTableViewCellDelegate <NSObject>

///点击的回复人的Guid
-(void)getuserGuid:(NSString*)userGuid;
///被回复人的Guid
-(void)getOtherGuid:(NSString*)otherGuid;
///点击内容需要回复的评论id
-(void)getContentId:(NSString*)contentId userGuid:(NSString*)userGuid name:(NSString*)name thismodelId:(NSString*)thisModelId indexpath:(NSIndexPath *)indexpath;
///长按的操作
-(void)getmessage:(NSString*)message contentId:(NSString*)contentId  creater:(NSString*)creater thismodelId:(NSString*)bigModelId indexPath:(NSIndexPath*)indexPath;

@end
