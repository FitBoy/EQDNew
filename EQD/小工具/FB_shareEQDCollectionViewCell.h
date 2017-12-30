//
//  FB_shareEQDCollectionViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FB_ShareModel.h"
@interface FB_shareEQDCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong) UILabel  *L_name;
@property (nonatomic,strong)  FB_ShareModel *model;
-(void)setModel:(FB_ShareModel *)model;
@end
