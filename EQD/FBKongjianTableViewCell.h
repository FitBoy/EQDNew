//
//  FBKongjianTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置 工作圈的cell显示
@interface FBKongjianTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UIButton *B_headimg;
@property (nonatomic,strong) UILabel *L_left0;
@property (nonatomic,strong)  UILabel *L_left1;
///显示内容 最多4行
@property (nonatomic,strong)  UILabel *L_contents;
//存放图片的数组
@property (nonatomic,strong) NSArray *arr_imgPath;

@end
