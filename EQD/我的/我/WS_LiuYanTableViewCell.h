//
//  WS_LiuYanTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FB_topView.h"
#import <YYText.h>
#import "WS_liuYanModel.h"
@interface WS_LiuYanTableViewCell : UITableViewCell
@property (nonatomic,strong)  FB_topView  *V_top;
@property (nonatomic,strong) UILabel *L_contets;
@property (nonatomic,strong) YYLabel *YL_contents;
@property (nonatomic,strong)  WS_liuYanModel *model_liuyan;
-(void)setModel_liuyan:(WS_liuYanModel *)model_liuyan;
@end
