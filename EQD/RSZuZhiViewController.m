//
//  RSZuZhiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RSZuZhiViewController.h"
#import "TZuZhiViewController.h"
#import "ZZZhiZeDetailViewController.h"
#import "ZZGangWeiDDViewController.h"
@interface RSZuZhiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
}

@end

@implementation RSZuZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"组织管理";
    arr_names =[NSMutableArray arrayWithArray:@[@"组织架构设置"]];
    //,@"岗位职责描述",@"流程查询"
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
            //组织架构设置

            TZuZhiViewController *ZZvc =[[TZuZhiViewController alloc]init];
            
            [self.navigationController pushViewController:ZZvc animated:NO];
        }
            break;
        case 1:
        {
           //岗位职责描述
            ZZZhiZeDetailViewController  *ZZDvc =[[ZZZhiZeDetailViewController alloc]init];
            [self.navigationController pushViewController:ZZDvc animated:NO];
            
        }
            break;
        case 2:
        {
           //流程查询
            
        }
            break;
        default:
            break;
    }
}




@end
