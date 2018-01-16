//
//  FB_TimeSectionViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_TimeSectionViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "ThreeSectionModel.h"
#import "FBButton.h"
#import "DatePicer_AlertView.h"
#import <Masonry.h>
@interface FB_TimeSectionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    DatePicer_AlertView  *date_alert;
    NSIndexPath *indexPath_selected;
    DatePicer_AlertView *date_alert1;
    NSInteger time_selected;
}

@end

@implementation FB_TimeSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"培训时间";
   arr_model = [NSMutableArray arrayWithArray:self.arr_IthreeSectionModel];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
    if (!self.arr_IthreeSectionModel.count) {
      [self addModel];
    }
   
  
    
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    date_alert1 =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter1 =[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"HH:mm"];
    NSString *date_str1 = [formatter1 stringFromDate:[NSDate date]];
    [date_alert1 setDate2:date_str1];
    date_alert1.picker.datePickerMode =UIDatePickerModeTime;
    [date_alert1.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert1.two_btn.B_left addTarget:self action:@selector(leftClick1) forControlEvents:UIControlEventTouchUpInside];
    [date_alert1.two_btn.B_right addTarget:self action:@selector(rightClick1) forControlEvents:UIControlEventTouchUpInside];
}
-(void)leftClick1
{
    [date_alert1 removeFromSuperview];
}
-(void)rightClick1
{
    ThreeSectionModel  *model =arr_model[indexPath_selected.row];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *date_str = [formatter stringFromDate:date_alert1.picker.date];
    if (time_selected==1) {
        model.time1 =date_str;
    }else
    {
        model.time2 =date_str;
    }
    [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
   [date_alert1 removeFromSuperview];
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    ThreeSectionModel  *model =arr_model[indexPath_selected.row];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    model.date =date_str;
    [arr_model replaceObjectAtIndex:indexPath_selected.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[indexPath_selected] withRowAnimation:UITableViewRowAnimationNone];
    [date_alert removeFromSuperview];
}
-(void)quedingClick
{
    if([self.delegate respondsToSelector:@selector(getThreeSectionModel:)])
    {
        [self.delegate getThreeSectionModel:arr_model];
        
    }
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)addModel{
    ThreeSectionModel  *model =[[ThreeSectionModel alloc]init];
    model.date = @"培训日期";
    model.time1 = @"培训时间";
    model.time2 = @"培训时间";
      [arr_model addObject:model];
    [tableV reloadData];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FBButton  *tbtn = [FBButton  buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:@"添加培训时间段" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:21]];
    [tbtn addTarget:self action:@selector(addModel) forControlEvents:UIControlEventTouchUpInside];
    return tbtn;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ThreeSectionModel  *model =arr_model[indexPath.row];
    NSMutableAttributedString  *date = [[NSMutableAttributedString alloc]initWithString:model.date attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [date yy_setTextHighlightRange:date.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor redColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
         [date_alert1 removeFromSuperview];
        [self.view addSubview:date_alert];
        indexPath_selected =indexPath;
    }];
    NSMutableAttributedString *text1 = [[NSMutableAttributedString alloc]initWithString:@"    从  " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    text1.yy_alignment = NSTextAlignmentRight;
    text1.yy_color = [UIColor grayColor];
    [date appendAttributedString:text1];
    NSMutableAttributedString  *time1 =[[NSMutableAttributedString alloc]initWithString:model.time1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    time1.yy_alignment = NSTextAlignmentRight;
    [time1 yy_setTextHighlightRange:time1.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor redColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        time_selected =1;
         [date_alert removeFromSuperview];
        [self.view addSubview:date_alert1];
        indexPath_selected = indexPath;
    }];
    [date appendAttributedString:time1];
    
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc]initWithString:@"  到  " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    text2.yy_alignment = NSTextAlignmentRight;
    text2.yy_color = [UIColor grayColor];
    [date appendAttributedString:text2];
    
    NSMutableAttributedString  *time2 = [[NSMutableAttributedString alloc]initWithString:model.time2 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    time2.yy_alignment = NSTextAlignmentRight;
    [time2 yy_setTextHighlightRange:time2.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor redColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        time_selected =2;
        [date_alert removeFromSuperview];
        [self.view addSubview:date_alert1];
        indexPath_selected =indexPath;
    }];
    [date appendAttributedString:time2];
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_equalTo(-15);
    }];
    
    cell.YL_label.attributedText = date;
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除
        [arr_model removeObjectAtIndex:indexPath.row];
        [tableV reloadData];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}





@end
