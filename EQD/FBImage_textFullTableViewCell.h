//
//  FBImage_textFullTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "Image_textModel.h"
@interface FBImage_textFullTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong) YYLabel *YL_text;
@property (nonatomic,strong)  Image_textModel  *model_imgText;
@property (nonatomic,strong)  Image_textModel  *model_center;
///核心价值观
-(void)setModel_center:(Image_textModel *)model_center;

/// 组织机构
-(void)setModel_imgText:(Image_textModel *)model_imgText;
@end
