//
//  EQDS_VideoTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/27.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "EQDS_VideoModel.h"
@interface EQDS_VideoTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  YYLabel *YL_label;
@property (nonatomic,strong)  UILabel *L_time;
@property (nonatomic,strong)  EQDS_VideoModel  *model;
@property (nonatomic,weak) id delegate;
-(void)setModel:(EQDS_VideoModel *)model;
///推荐的视频 首页
-(void)setModel2:(EQDS_VideoModel *)model;
@end
@protocol EQDS_VideoTableViewCellDelegate <NSObject>
-(void)getlabel:(NSString*)label WithModel:(id)model;
@end;
