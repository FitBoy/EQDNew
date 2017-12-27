//
//  FBOne_img2TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
///图片靠右显示的cell
@interface FBOne_img2TableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong) FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;

@end
