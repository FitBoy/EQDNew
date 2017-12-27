//
//  KQDaKaView.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define EQDCOLOR   [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1]
#import "KQDaKaView.h"

@implementation KQDaKaView
-(void)setModel:(CalendarModel *)model Withweeks:(NSString*)weeks
{
    
    float width = DEVICE_WIDTH/7.0;
    _model = model;
    NSDate *next = model.date;
    CalendarModel *tmodel = model;
    self.weeks_week =weeks;
    for(int i =0 ;i<7;i++)
    {
        
        UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(width*i, 0, width, 24)];
        [self addSubview:tlabel];
        tlabel.textAlignment =NSTextAlignmentCenter;
        NSString *week =[self getweekdayWithnum:tmodel.weekday];
        tlabel.text =week;
        tlabel.font = [UIFont systemFontOfSize:17];
       
        
        UILabel *tlabel2 =[[UILabel alloc]initWithFrame:CGRectMake((width-25)/2.0+width*i, 24+5, 25, 25)];
        tlabel2.textAlignment = NSTextAlignmentCenter;
        tlabel2.font =[UIFont systemFontOfSize:20];
        tlabel2.text = [NSString stringWithFormat:@"%ld",tmodel.day];
        [self addSubview:tlabel2];
        tlabel2.layer.masksToBounds=YES;
        tlabel2.layer.cornerRadius=12.5;
        tlabel2.backgroundColor =EQDCOLOR;
        next = [NSDate dateWithTimeInterval:24*60*60 sinceDate:next];
        tmodel = [[CalendarModel alloc]initWithDate:next];
        
        
        
        UILabel *tlabel3 = [[UILabel alloc]initWithFrame:CGRectMake(width*i, 60, width, 15)];
        if ([weeks containsString:week]) {
            tlabel3.text =@"工作";
        }else
        {
            tlabel3.text =@"休息";
            tlabel.textColor = [UIColor grayColor];
            tlabel2.textColor = [UIColor grayColor];
            tlabel3.textColor = [UIColor grayColor];
        }
        tlabel3.font = [UIFont systemFontOfSize:13];
        tlabel3.textAlignment =NSTextAlignmentCenter;
        [self addSubview:tlabel3];
       
        
    }
    
}

//返回星期
-(NSString*)getweekdayWithnum:(NSInteger)num
{
    NSArray *arr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    return arr[num-1];
    
}


@end
