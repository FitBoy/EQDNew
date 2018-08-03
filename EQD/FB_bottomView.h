//
//  FB_bottomView.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FB_bottomView : UIView
@property (nonatomic,strong)  UIImageView *IV_zan1;
@property (nonatomic,strong) UIImageView *IV_zan2;
@property (nonatomic,strong)  UIImageView *IV_zan3;
@property (nonatomic,strong)  UIImageView *IV_zan4;

@property (nonatomic,strong)  UIImageView *IV_zan;
@property (nonatomic,strong)  UIImageView *IV_liuyan;
@property (nonatomic,strong)  UILabel *L_zan;
@property (nonatomic,strong)  UILabel *L_liuyan;

-(void)setZan_arr:(NSArray*)zan_arr isZan:(NSString*)isZan zanNum:(NSString*)zanNum liuYanNum:(NSString*)liuYanNum;
-(void)updateZanWithZanArr:(NSArray*)ZanArr;
-(void)updateliuyanNum:(NSString*)liuYanNum;
@end
