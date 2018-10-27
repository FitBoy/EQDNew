//
//  IV_lableView.h
//  EQD
//
//  Created by 梁新帅 on 2018/10/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 70 X 70

#import <UIKit/UIKit.h>

@interface IV_lableView : UIView
///目前仅支持本地图片
@property (nonatomic,strong) UIImageView  *IV_img;
@property (nonatomic,strong)  UILabel *L_title;
-(void)setimg:(NSString*)imgName tiele:(NSString*)title isLocal:(BOOL)isloacal;
@end
