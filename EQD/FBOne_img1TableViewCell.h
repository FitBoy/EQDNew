//
//  FBOne_img1TableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/5.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBBaseModel.h"
#import "FBButton.h"
#import "CKHD_ListModel.h"
///图片靠左显示
@interface FBOne_img1TableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  FBButton *B_img;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  FBBaseModel *model;
-(void)setModel:(FBBaseModel *)model;


@end
