//
//  TRSWenHuaViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TRSWenHuaViewController.h"
#import "Com_XuanChuanViewController.h"
@interface TRSWenHuaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_name;
}

@end

@implementation TRSWenHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"企业文化";
    //@"核心价值观编辑/发布",@"非核心价值观编辑/发布",@"文化活动编辑/发布",@"领导活动编辑/发布",@"先进事迹编辑/发布",@"荣誉墙编辑/发布"
    arr_name =[NSMutableArray arrayWithArray:@[@"企业宣传"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
 
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_name.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text =arr_name[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //企业宣传
        Com_XuanChuanViewController *XCvc =[[Com_XuanChuanViewController alloc]init];
        [self.navigationController pushViewController:XCvc animated:NO];
    }
}



@end
