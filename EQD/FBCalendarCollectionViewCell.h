//
//  FBCalendarCollectionViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import <UIKit/UIKit.h>
#import "CalendarModel.h"
@interface FBCalendarCollectionViewCell : UICollectionViewCell
{
    int width;
    
}
///背景
@property (nonatomic,strong)  UIView *V_bg;
///数字
@property (nonatomic,strong)  UILabel *L_num;
///阴历 或节假日
@property (nonatomic,strong)  UILabel *L_name;
///小红点
@property (nonatomic,strong)  UIView *V_dian;
@property (nonatomic,strong)CalendarModel *model;
///配置单元格
-(void)setModel:(CalendarModel*)model;

@end
