//
//  FBTimeView.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTimeView.h"

@implementation FBTimeView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self.pickerView.frame = CGRectMake(0, 30, frame.size.width, frame.size.height-30);
        self.backgroundColor =[UIColor whiteColor];
        
        self.B_queding.frame =CGRectMake(frame.size.width-75, 0, 60, 30);
        self.B_quxiao.frame = CGRectMake(15, 0, 60, 30);
        
        
    }
    return self;
    
}

-(void)setime:(NSArray *)time
{
    _arr_time =[NSMutableArray arrayWithArray:time];
    for (int i =0; i<time.count; i++) {
        [self.pickerView selectRow:[time[i] integerValue] inComponent:i*2 animated:NO];
    }

}
-(UIButton*)B_quxiao
{
    if (!_B_quxiao) {
        _B_quxiao = [UIButton buttonWithType:UIButtonTypeSystem];
        [_B_quxiao setTitle:@"取消" forState:UIControlStateNormal];
        [self addSubview:_B_quxiao];
        
    }
    return _B_quxiao;
}
-(UIButton*)B_queding
{
    if (!_B_queding) {
        _B_queding =[UIButton buttonWithType:UIButtonTypeSystem];
        [_B_queding setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:_B_queding];
        
    }
    return _B_queding;
}
-(NSMutableArray*)datasorce
{
    if (!_datasorce) {
        
        _datasorce = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr1 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
        for (int i =0; i<24; i++) {
            [arr1 addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [_datasorce addObject:arr1];
        [_datasorce addObject:@[@"时"]];
        
        for (int i =0; i<60; i++) {
            if (i<10) {
                [arr2 addObject:[NSString stringWithFormat:@"0%d",i]];
            }
            else
            {
            [arr2 addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
        [_datasorce addObject:arr2];
        [_datasorce addObject:@[@"分"]];
        
    }
    return _datasorce;
}
-(UIPickerView*)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate=self;
        _pickerView.dataSource =self;
        [self addSubview:_pickerView];
    }
    return _pickerView;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.datasorce.count;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *arr = self.datasorce[component];
    return arr.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.datasorce[component][row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component==0) {
        [_arr_time replaceObjectAtIndex:0 withObject:self.datasorce[component][row] ];
        
    }
    else if (component==2)
    {
       [_arr_time replaceObjectAtIndex:1 withObject:self.datasorce[component][row] ];
    }
    else
    {
        
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
