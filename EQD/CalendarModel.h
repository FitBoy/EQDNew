//
//  CalendarModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarModel : NSObject
///年
@property (nonatomic,assign) NSInteger year;
///月
@property (nonatomic,assign) NSInteger month;
///阴历月
@property (nonatomic,assign) NSInteger month_yinli;
//日
@property (nonatomic,assign) NSInteger day;
///阴历日
@property (nonatomic,assign) NSInteger day_yinli;
///周 1 对应星期日  依次类推
@property (nonatomic,assign) NSInteger weekday;
///初始化的时间
@property (nonatomic,strong) NSDate *date;
///是否显示小红点
@property (nonatomic,assign)BOOL isShow;
///该日期是否是当前的日期
@property (nonatomic,assign)BOOL isNow;
///是否被选中
@property (nonatomic,assign) BOOL isSelectedBlue;

@property (nonatomic,strong)  NSIndexPath *indexPath;
-(instancetype)initWithDate:(NSDate*)date;
@end
