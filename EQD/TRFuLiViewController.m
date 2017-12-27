//
//  TRFuLiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TRFuLiViewController.h"

@interface TRFuLiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
}

@end

@implementation TRFuLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title=@"薪酬福利管理";
    arr_names = [NSMutableArray arrayWithArray:@[@"薪酬设置",@"薪酬台账",@"调薪申请待批",@"薪资变动",@"薪资发放",@"薪资分析",@"社保管理",@"流程查询"]];
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //薪酬设置
        }
            break;
           case 1:
        {
            //薪酬台账
        }
            break;
        case 2:
        {
            //调薪申请待批
        }
            break;
        case 3:
        {
           //薪资变动
        }
            break;
        case 4:
        {
            //薪资发放
        }
            break;
        case 5:
        {
           //薪资分析
        }
            break;
        case 6:
        {
           //社保管理
        }
            break;
        case 7:
        {
            //流程查询
        }
            break;
        default:
            break;
    }
}



@end
