//
//  FBTimeDayViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBTimeDayViewController.h"

@interface FBTimeDayViewController ()
{
    UIDatePicker  *datepicker;
}

@end

@implementation FBTimeDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.contentTitle;
    
    datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT/4.0, DEVICE_WIDTH, DEVICE_HEIGHT/2.0)];
    [self.view addSubview:datepicker];
    if (self.pikermode == 0) {
        datepicker.datePickerMode = UIDatePickerModeDate;
    }
    else if(self.pikermode == 1)
    {
        datepicker.datePickerMode = UIDatePickerModeTime;
    }else
    {
         datepicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    
    [datepicker setDate:[NSDate date]];
    
    datepicker.minimumDate = self.D_minDate?self.D_minDate:nil;
    datepicker.maximumDate=self.D_MaxDate?self.D_MaxDate:nil;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)quedingClick{
    if ([self.delegate respondsToSelector:@selector(timeDay:indexPath:)]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *date_str = [formatter stringFromDate:datepicker.date];
        
        [self.delegate timeDay:date_str indexPath:self.indexPath];
    }

    [self.navigationController popViewControllerAnimated:NO];
    
}


@end
