//
//  GNBLCollectionViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNmodel.h"
@interface GNBLCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong)  UILabel *L_title;
@property (nonatomic,strong)  UILabel  *L_RedTip;
@property (nonatomic,strong)  GNmodel *model;
-(void)setModel:(GNmodel *)model;
@end
