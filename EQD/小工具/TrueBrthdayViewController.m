//
//  TrueBrthdayViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TrueBrthdayViewController.h"

@interface TrueBrthdayViewController ()
{
    UISegmentedControl *segmentC;
    NSString *str_name;
    UIDatePicker *picjer;
    NSDateFormatter *formatter;
    UILabel *L_date;
}
@end

@implementation TrueBrthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    segmentC = [[UISegmentedControl alloc]initWithItems:@[@"阳历",@"阴历"]];
    segmentC.frame =CGRectMake(DEVICE_WIDTH-120, 74-64+DEVICE_TABBAR_Height, 100, 35);
    [self.view addSubview:segmentC];
    L_date =[[UILabel alloc]initWithFrame:CGRectMake(15, 74-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-120, 35)];
    L_date.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:L_date];
    segmentC.selectedSegmentIndex=0;
    [segmentC addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    picjer =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 110-64+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_WIDTH*3/4.0)];
    [self.view addSubview:picjer];
     str_name =@"阳历";
    picjer.datePickerMode = UIDatePickerModeDate;
    [picjer setDate:[NSDate date]];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingCLick)];
    [self.navigationItem setRightBarButtonItem:right];
     picjer.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    if ([self.content containsString:@"-"]) {
        NSArray *arr = [self.content componentsSeparatedByString:@"-"];
        NSString *str1 =arr[0];
        formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date1 =[formatter dateFromString:str1];
        [picjer setDate:date1];
        L_date.text =str1;
        NSString *str2 =arr[1];
        if ([str2 isEqualToString:@"阴历"]) {
            segmentC.selectedSegmentIndex=1;
            str_name =str2;
        }
        else
        {
            segmentC.selectedSegmentIndex=0;
            str_name =@"阳历";
            
        }
    }
    else
    {
        NSDateFormatter *formatter1 =[[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"MM-dd"];
        L_date.text =[formatter1 stringFromDate:picjer.date];
    }
    
    [picjer addTarget:self action:@selector(dateClick) forControlEvents:UIControlEventValueChanged];
    
}
-(void)quedingCLick
{
    //确定
    if ([self.delegate respondsToSelector:@selector(birthDayWithcontent:indexPath:)]) {
        
        NSString *date =[NSString stringWithFormat:@"%@-%@",L_date.text,str_name];
        [self.delegate birthDayWithcontent:date indexPath:self.indexpath];
        [self.navigationController popViewControllerAnimated:NO];
    }
}
-(void)dateClick
{
    
    if ([str_name isEqualToString:@"阴历"]) {
      NSCalendar *calender = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
        NSDateComponents  *componets = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:picjer.date];
        
        L_date.text = [NSString stringWithFormat:@"%ld/%ld",(long)componets.month,(long)componets.day];
        
    }
    else
    {
        NSDateFormatter *formatter1 =[[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"MM-dd"];
       L_date.text= [formatter1 stringFromDate:picjer.date];
    }

}
-(void)chooseClick
{
    if (segmentC.selectedSegmentIndex==1) {
        str_name = @"阴历";
        picjer.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
        
        NSCalendar *calender = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
        NSDateComponents  *componets = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:picjer.date];
        
        L_date.text = [NSString stringWithFormat:@"%ld/%ld",(long)componets.month,(long)componets.day];
        
    }
    else
    {
        str_name =@"阳历";
        picjer.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateFormatter *formatter1 =[[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"MM-dd"];
        L_date.text= [formatter1 stringFromDate:picjer.date];
    }
}


@end
