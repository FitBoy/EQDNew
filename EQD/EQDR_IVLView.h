//
//  EQDR_IVLView.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//   底部的 50

#import <UIKit/UIKit.h>

@interface EQDR_IVLView : UIView
@property (nonatomic,strong)  UIImageView *IV_img;
@property (nonatomic,strong)  UILabel *L_show;
-(void)setImg:(NSString*)img  name:(NSString*)name;
@end
