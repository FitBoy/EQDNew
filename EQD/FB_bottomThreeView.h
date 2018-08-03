//
//  FB_bottomThreeView.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FB_bottomThreeView : UIView
@property (nonatomic,strong) UIImageView  *IV_read;
@property (nonatomic,strong) UILabel  *L_read;
@property (nonatomic,strong)  UIImageView *IV_liuyan;
@property (nonatomic,strong) UILabel *L_liuyan;
@property (nonatomic,strong)  UIImageView *IV_zan;
@property (nonatomic,strong)  UILabel *L_zan;

-(void)setread:(NSString*)read liuyan:(NSString*)liuyan zan:(NSString*)zan;
@end
