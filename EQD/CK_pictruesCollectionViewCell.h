//
//  CK_pictruesCollectionViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "PhotoModel.h"
@interface CK_pictruesCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)  UIImageView *IV_image;
@property (nonatomic,strong) YYLabel *L_name;

@property (nonatomic,strong)  PhotoModel  *model_mulu;

-(void)setModel_mulu:(PhotoModel *)model_mulu;
///图片
-(void)setModel_mulu2:(PhotoModel *)model_mulu;
@end
