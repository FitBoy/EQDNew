//
//  CalendarModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CalendarModel.h"

@implementation CalendarModel
-(instancetype)initWithDate:(NSDate*)date
{
    if (self =[super init]) {
        self.date =date;
        //获取准确的年份
        NSCalendar  *calender0=[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *compontent0 = [calender0 components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
        self.year =compontent0.year;
        self.month = compontent0.month;
        self.day = compontent0.day;
        self.weekday =compontent0.weekday;
        //获取阴历的时间
        NSCalendar  *calender1=[NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
        NSDateComponents *compontent1 = [calender1 components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
        self.month_yinli =compontent1.month;
        self.day_yinli =compontent1.day;
        
    }
    return self;
    
    
}
@end
