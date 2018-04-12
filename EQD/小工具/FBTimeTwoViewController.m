//
//  FBTimeTwoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTimeTwoViewController.h"
#import "GNmodel.h"
@interface FBTimeTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UIDatePicker *dateP;
    NSInteger flag;
    UITableViewCell *cell_selected;
}

@end

@implementation FBTimeTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    flag =0;
    self.navigationItem.title = self.contenttitle;
    arr_names =[NSMutableArray arrayWithArray:@[@"开始时间",@"结束时间"]];
    arr_contents =[NSMutableArray arrayWithArray:@[@"请选择",@"请选择"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 300) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    dateP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 300+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_WIDTH*3/4.0)];
    dateP.datePickerMode =UIDatePickerModeDate ;
    [dateP setDate:[NSDate date]];
    [dateP addTarget:self action:@selector(datePClick) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:dateP];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(qudingCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    [self datePClick];
}
-(void)qudingCLick{
    //确定
    NSInteger temp =0;
    for (NSString *str in arr_contents) {
        if ([str isEqualToString:@"请选择"]) {
            temp=1;
        }
    }
    
    if (temp==0) {
        if([self.delegate respondsToSelector:@selector(timetwo:indexpath:)])
        {
            [self.delegate timetwo:arr_contents indexpath:self.indexpath];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"时间选择不完全";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        });
    }
}
-(void)datePClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:dateP.date];
    [arr_contents replaceObjectAtIndex:flag withObject:date];
    [tableV reloadData];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    if (indexPath.row==0) {
        cell_selected=cell;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    flag =indexPath.row;
    if (indexPath.row==0) {
       
        dateP.backgroundColor = [UIColor whiteColor];
    }
    else
    {
       dateP.backgroundColor =EQDCOLOR;
       
    }
   cell_selected=cell;
    [self datePClick];
    
}




@end
