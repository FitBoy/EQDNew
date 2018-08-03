//
//  SC_productTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 产品 信息 image 100 X 100

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "SC_productModel.h"
@interface SC_productTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong)  YYLabel *yl_contents;
@property (nonatomic,strong)  SC_productModel *model_product;

-(void)setModel_product:(SC_productModel *)model_product;
@end
