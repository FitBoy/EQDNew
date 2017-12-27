//
//  FBOne_imgChooseTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
@interface FBOne_imgChooseTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong)  UIImageView *IV_choose;
@property (nonatomic,strong)  UILabel *L_left0;
@property (nonatomic,strong)  FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;
@end
