//
//  YGShanXuanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "YGShanXuanViewController.h"
#import "Bumen_ChooseViewController.h"
#import "DatePicer_AlertView.h"
@interface YGShanXuanViewController ()<UITableViewDelegate,UITableViewDataSource,Bumen_ChooseViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_contetnts;
    DatePicer_AlertView *date_alert;
    NSString *bumenId;
}

@end

@implementation YGShanXuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"筛选条件";
    arr_one = [NSMutableArray arrayWithArray:@[@"部门",@"入职时间开始时间",@"入职结束时间"]];
    arr_contetnts =[NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请选择"]];
    
    tableV = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];

    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    bumenId =@"请选择";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingClick
{
    if ([self.delegate respondsToSelector:@selector(bumen:startTime:endTime:)]) {
        [self.delegate bumen:bumenId startTime:arr_contetnts[1] endTime:arr_contetnts[2]];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    [arr_contetnts replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [date_alert removeFromSuperview];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_one.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
    }
    cell.textLabel.text =arr_one[indexPath.row];
    cell.detailTextLabel.text =arr_contetnts[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //部门
        Bumen_ChooseViewController *BMvc =[[Bumen_ChooseViewController alloc]init];
        BMvc.delegate =self;
        BMvc.indexPath =indexPath;
        [self.navigationController pushViewController:BMvc animated:NO];
    }else if (indexPath.row==1)
    {
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
        
    }else if (indexPath.row==2)
    {
        date_alert.two_btn.B_right.indexpath =indexPath;
        date_alert.picker.maximumDate = [NSDate date];
        [self.view addSubview:date_alert];
    }
   
}

-(void)getBumenModel:(ZuZhiModel *)model indexPath:(NSIndexPath *)indexPath
{
    bumenId =model.departId;
    [arr_contetnts replaceObjectAtIndex:indexPath.row withObject:model.departName];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}



@end
