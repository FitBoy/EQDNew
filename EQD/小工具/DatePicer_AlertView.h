//
//  DatePicer_AlertView.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBTwoButtonView.h"
@interface DatePicer_AlertView : UIView
@property (nonatomic,strong)  UILabel *L_title;
@property (nonatomic,strong)  UIDatePicker *picker;
@property (nonatomic,strong)  FBTwoButtonView *two_btn;
@property (nonatomic,copy) NSString* date;
@property (nonatomic,copy) NSString* date2;
@property (nonatomic,strong)  NSString *date3;
-(UILabel*)L_title;
///初始化 时间格式化 yyyy-MM-dd HH:mm
-(void)setDate:(NSString *)date;
///初始化时间格式 HH:mm
-(void)setDate2:(NSString *)date2;

///初始化 时间格式化 yyyy-MM-dd
-(void)setDate3:(NSString *)date3;
@end
