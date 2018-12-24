//
//  BPqiandaoShow.h
//  EQD
//
//  Created by 梁新帅 on 2018/11/14.
//  Copyright © 2018 FitBoy. All rights reserved.
// 总高度 写成 90   签到的第几天

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPqiandaoShow : UIView
@property (nonatomic,strong) UILabel *L_top;
@property (nonatomic,strong)  UIImageView *IV_center;
@property (nonatomic,strong) UILabel *L_bottom;

-(void)setTop:(NSString*)topName  bottomName:(NSString*)bottomName  isQiandao:(BOOL)isQianDao;

@end

NS_ASSUME_NONNULL_END
