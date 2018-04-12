//
//  FB_GNLIVView.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/14.
//  Copyright © 2018年 FitBoy. All rights reserved.
///高 50

#import <UIKit/UIKit.h>

@interface FB_GNLIVView : UIView
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  UIImageView *IV_img;
-(void)setname:(NSString*)name  AndimgName:(NSString*)imgName;
@end
