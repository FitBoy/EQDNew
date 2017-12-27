//
//  FBTimeView.h
//  EQD
//
//  Created by 梁新帅 on 2017/6/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBTimeView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)  NSMutableArray *datasorce;
@property (nonatomic,strong)  UIPickerView *pickerView;
///小时  分
@property (nonatomic,strong)  NSMutableArray *arr_time;
@property (nonatomic,strong)  UIButton *B_queding;
@property (nonatomic,strong)  UIButton *B_quxiao;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)setime:(NSArray *)time;
@end
