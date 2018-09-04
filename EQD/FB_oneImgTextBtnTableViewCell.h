//
//  FB_oneImgTextBtnTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBButton.h"
#import <YYText.h>
#import "SC_productModel.h"
@interface FB_oneImgTextBtnTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong) YYLabel *YL_text;
@property (nonatomic,strong) FBButton *B_btn;

@property (nonatomic,strong)  SC_productModel  *model_product;

-(void)setModel_product:(SC_productModel *)model_product;
@end
