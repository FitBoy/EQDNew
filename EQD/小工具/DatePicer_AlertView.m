//
//  DatePicer_AlertView.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "DatePicer_AlertView.h"
#import <Masonry/Masonry.h>
@implementation DatePicer_AlertView
-(void)setDate:(NSString *)date;
{
    self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.3];
    _date =date;
    NSDateFormatter *formattor =[[NSDateFormatter alloc]init];
    [formattor setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date2 =[formattor dateFromString:date];
    [self.picker setDate:date2];
   
}
-(void)setDate2:(NSString *)date2
{
    self.picker.datePickerMode =UIDatePickerModeTime;
    self.backgroundColor =self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.3];
    _date2 =date2;
    NSDateFormatter *formattor =[[NSDateFormatter alloc]init];
    [formattor setDateFormat:@"HH:mm"];
    NSDate *date1 =[formattor dateFromString:date2];
    [self.picker setDate:date1];
}

-(void)setDate3:(NSString *)date3
{
   self.backgroundColor =self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.3];
    _date3 =date3;
    self.picker.datePickerMode =UIDatePickerModeDate;
    NSDateFormatter *formattor =[[NSDateFormatter alloc]init];
    [formattor setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 =[formattor dateFromString:date3];
    [self.picker setDate:date1];
}

-(UIDatePicker*)picker
{
    if (!_picker) {
        _picker =[[UIDatePicker alloc]init];
        _picker.layer.masksToBounds=YES;
        _picker.layer.cornerRadius=6;
        [_picker setDate:[NSDate date]];
        _picker.backgroundColor =[UIColor whiteColor];
        _picker.datePickerMode =UIDatePickerModeDate;
        [self addSubview:_picker];
        [_picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-70);
            make.height.mas_equalTo(240);
        }];
        
    }
    return _picker;
}

-(FBTwoButtonView*)two_btn
{
    if (!_two_btn) {
        _two_btn =[[FBTwoButtonView alloc]init];
        _two_btn.backgroundColor =[UIColor whiteColor];
         [self.two_btn setleftname:@"取消" rightname:@"确定"];
        [self addSubview:_two_btn];
        [_two_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-5);
            make.height.mas_equalTo(50);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        }];
        
    }
    return _two_btn;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
