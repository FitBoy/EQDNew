//
//  PZXZWuZiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZXZWuZiViewController.h"
#import "FBButton.h"
@interface PZXZWuZiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
}

@end

@implementation PZXZWuZiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"行政物资审批";
    arr_names =[NSMutableArray arrayWithArray:@[@"工用具类型",@"物品名称",@"工用具类型",@"型号/规格",@"数量",@"所属部门",@"物品负责人"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
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
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    FBButton *tbtn =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:@"已归还" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:24]];
    [tbtn addTarget:self action:@selector(tbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return tbtn;
    
}
-(void)tbtnClick
{
    //已归还
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
