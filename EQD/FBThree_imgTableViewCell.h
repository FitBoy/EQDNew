//
//  FBThree_imgTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/6/6.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
///简历库显示的cell 样稿
@interface FBThree_imgTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UIButton *B_img;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_right0;
@property (nonatomic,strong)  UILabel *L_left1;
@property (nonatomic,strong)  FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;

@end
