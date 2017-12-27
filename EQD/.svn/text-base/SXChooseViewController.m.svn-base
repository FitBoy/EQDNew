//
//  SXChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SXChooseViewController.h"

@interface SXChooseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_lexing;
    NSMutableArray *arr_xuanzhong;
}

@end

@implementation SXChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"客户类型";
    arr_lexing =[NSMutableArray arrayWithArray:@[@"未知客户",@"潜在客户",@"目标客户",@"交易客户",@"持续交易客户",@"后续介绍客户"]];
    arr_xuanzhong =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=40;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingCliK)];
    [self.navigationItem setRightBarButtonItem:right];
   
}
-(void)quedingCliK
{
    //筛选后的结果
    if ([self.delegate respondsToSelector:@selector(choose:)]) {
        [self.delegate choose:arr_xuanzhong];
    }
    self.delegate =self;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_lexing.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text =arr_lexing[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType ==UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [arr_xuanzhong addObject:arr_lexing[indexPath.row]];
    }
    else
    {
        [arr_xuanzhong removeObject:arr_lexing[indexPath.row]];
        
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
}




@end
