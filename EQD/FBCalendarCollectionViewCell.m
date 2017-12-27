//
//  FBCalendarCollectionViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBCalendarCollectionViewCell.h"

@implementation FBCalendarCollectionViewCell
-(void)setModel:(CalendarModel*)model
{
    _model = model;
    width = DEVICE_WIDTH/7;
    self.V_bg.backgroundColor =[UIColor whiteColor];
    self.V_dian.hidden = !model.isShow;
    if (model.isSelectedBlue!=NO) {
        self.V_bg.backgroundColor = [UIColor blueColor];
        self.L_num.textColor = [UIColor whiteColor];
        self.L_name.textColor = [UIColor whiteColor];
    }
    
    if (model.isNow!=NO) {
        self.V_bg.layer.borderColor = [UIColor blueColor].CGColor;
        self.V_bg.layer.borderWidth=2;
    }
    else
    {
        self.V_bg.layer.borderWidth=0.0;
    }
    self.L_num.text =model.day==0?nil: [NSString stringWithFormat:@"%ld",(long)model.day];
    self.L_name.textColor = model.weekday%6==1?[UIColor grayColor]:[UIColor blackColor];
    self.L_num.textColor=self.L_name.textColor;
    self.L_name.text = [self riqiWithmodel:model];
    
    if([self YinLiWithModel:model]!=nil)
    {
        self.L_name.text =[self YinLiWithModel:model];
        self.L_name.textColor=[UIColor orangeColor];
    }
    else
    {
        if ([self YangLiJieRiWithModel:model]!=nil) {
            self.L_name.text = [self YangLiJieRiWithModel:model];
            self.L_name.textColor=[UIColor orangeColor];
        }
    }
    
   
    
    
}
//将数字转换成汉字
-(NSString*)riqiWithmodel:(CalendarModel*)model
{
    switch (model.day_yinli) {
        case 1:
        {
            switch (model.month_yinli) {
                case 1:
                    return @"正月";
                    break;
                case 2:
                    return @"二月";
                    break;
                case 3:
                    return @"三月";
                    break;
                case 4:
                    return @"四月";
                    break;
                case 5:
                    return @"五月";
                    break;
                case 6:
                    return @"六月";
                    break;
                case 7:
                    return @"七月";
                    break;
                case 8:
                    return @"八月";
                    break;
                case 9:
                    return @"九月";
                    break;
                case 10:
                    return @"十月";
                    break;
                case 11:
                    return @"冬月";
                    break;
                case 12:
                    return @"腊月";
                    break;
                    
                default:
                    return nil;
                    break;
            }
        }
            break;
        case 2:
            return @"初二";
            break;
        case 3:
            return @"初三";
            break;
        case 4:
            return @"初四";
            break;
        case 5:
            return @"初五";
            break;
        case 6:
            return @"初六";
            break;
        case 7:
            return @"初七";
            break;
        case 8:
            return @"初八";
            break;
        case 9:
            return @"初九";
            break;
        case 10:
            return @"初十";
            break;
        case 11:
            return @"十一";
            break;
        case 12:
            return @"十二";
            break;
        case 13:
            return @"十三";
            break;
        case 14:
            return @"十四";
            break;
        case 15:
            return @"十五";
            break;
        case 16:
            return @"十六";
            break;
        case 17:
            return @"十七";
            break;
        case 18:
            return @"十八";
            break;
        case 19:
            return @"十九";
            break;
        case 20:
            return @"二十";
            break;
        case 21:
            return @"廿一";
            break;
        case 22:
            return @"廿二";
            break;
        case 23:
            return @"廿三";
            break;
        case 24:
            return @"廿四";
            break;
        case 25:
            return @"廿五";
            break;
        case 26:
            return @"廿六";
            break;
        case 27:
            return @"廿七";
            break;
        case 28:
            return @"廿八";
            break;
        case 29:
            return @"廿九";
            break;
            case 30:
            return @"三十";
            break;
        default:
            return nil;
            break;
    }
}
//返回阳历的节日
-(NSString*)YangLiJieRiWithModel:(CalendarModel*)model
{
    switch (model.month) {
        case 1:
        {
            if (model.day==1) {
                return @"元旦";
            }
            return nil;
        }
             break;
            case 2:
        {
            if (model.day==14) {
                return @"情人节";
            }
            return nil;
        }
           break;
        case 3:
        {
            if (model.day==8) {
                return @"妇女节";
            }
            else if(model.day==12)
            {
                return @"植树节";
            }
            else
            {
                return nil;
            }
        }
            break;
        case 4:
        {
            if (model.day==1) {
                return @"愚人节";
            }
            else if (model.day ==5)
            {
                return @"清明节";
            }
            else
            {
                return nil;
            }
        }
            break;
        case 5:
        {
            if (model.day==1) {
                return @"劳动节";
            }
            else if (model.day==4)
            {
                return @"青年节";
            }
            else
            {
                return nil;
            }
        }
            break;
        case 6:
        {
            if (model.day==1) {
                return @"儿童节";
            }
            return nil;
        }
            break;
        case 7:
        {
            if (model.day==1) {
                return @"建党节";
            }
            return nil;
        }
            break;
        case 8:
        {
            if (model.day==1) {
                return @"建军节";
            }
            return nil;
        }
            break;
        case 9:
        {
            if (model.day==10) {
                return @"教师节";
            }
            return nil;
        }
            break;
        case 10:
        {
            if(model.day==1)
            {
                return @"国庆节";
            }
            else if (model.day==31)
            {
                return @"鬼节";
            }else
            {
                return nil;
            }
        }
            break;
        case 11:
        {
            if (model.day==1) {
                return @"万圣节";
            }
            else if(model.day==11)
            {
                return @"单身节";
            }
            else
            {
                return nil;
            }
        }
            break;
        case 12:
        {
            if (model.day==24) {
                return @"平安夜";
            }
            else if (model.day==25)
            {
                return  @"圣诞节";
            }
            else
            {
                return nil;
            }
        }
            break;
            
        default:
            return nil;
            break;
    }
}
//返回阴历的节日
-(NSString*)YinLiWithModel:(CalendarModel*)model
{
    switch (model.month_yinli) {
        case 1:
        {
            if (model.day_yinli==1) {
                return @"春节";
            }
            else if (model.day_yinli==15)
            {
                return @"元宵节";
            }
            else
            {
                return nil;
            }
        }
            break;
        case 2:
        {
            if (model.day_yinli==2) {
                return @"龙抬头";
            }
            return nil;
        }
            break;
       
        case 5:
        {
            if (model.day_yinli==5) {
                return @"端午节";
            }
            return nil;
        }
            break;
       
        case 7:
        {
            if (model.day_yinli==7) {
                return @"乞巧节";
            }
            return nil;
        }
            break;
        case 8:
        {
            if (model.day_yinli==15) {
                return @"中秋节";
            }
            return nil;
        }
            break;
        case 9:
        {
            if (model.day_yinli==9) {
                return @"重阳节";
            }
            return nil;
        }
            break;
       
        case 12:
        {
            if (model.day_yinli==8) {
                return @"腊八";
            }
            else if(model.day_yinli==23)
            {
                return @"小年";
            }
            else if(model.day_yinli>28)
            {
                if (model.day_yinli==30) {
                    return @"除夕";
                }
                else
                {
                    NSDate *tdate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:model.date];
                    NSCalendar  *calender1=[NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
                    NSDateComponents *compontent1 = [calender1 components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:tdate];
                    if (compontent1.day==1) {
                        return @"除夕";
                    }
                    else
                    {
                        return nil;
                    }
                }
            }
            else
            {
                return nil;
            }
        }
            break;
            
            
        default:
            return nil;
            break;
    }
}

-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg=[[UIView alloc]initWithFrame:CGRectMake((width-41)/2.0,(width-41)/2.0 , 41, 41)];
        [self addSubview:_V_bg];
        _V_bg.userInteractionEnabled=YES;
        _V_bg.layer.masksToBounds=YES;
        _V_bg.layer.cornerRadius=20.5;
    }
    return _V_bg;
}
-(UILabel*)L_num
{
    if (!_L_num) {
        _L_num = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 41, 20)];
        _L_num.font=[UIFont systemFontOfSize:17];
        [self.V_bg addSubview:_L_num];
        _L_num.textAlignment=NSTextAlignmentCenter;
    }
    return _L_num;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 41, 15)];
        [self.V_bg addSubview:_L_name];
        _L_name.font=[UIFont systemFontOfSize:10];
        _L_name.textAlignment = NSTextAlignmentCenter;
    }
    return _L_name;
}
-(UIView*)V_dian
{
    if (!_V_dian) {
        _V_dian = [[UIView alloc]initWithFrame:CGRectMake((41-5)/2.0, 35, 6, 6)];
        _V_dian.layer.masksToBounds=YES;
        _V_dian.layer.cornerRadius = 3;
        _V_dian.layer.backgroundColor = [UIColor redColor].CGColor;
        [self.V_bg addSubview:_V_dian];
        _V_dian.hidden=YES;
    }
    return _V_dian;
}
@end
