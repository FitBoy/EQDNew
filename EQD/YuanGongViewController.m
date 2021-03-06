//
//  YuanGongViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "YuanGongViewController.h"
#import "YGZaiZhiViewController.h"
#import "YGLiZhiViewController.h"
#import "YGJiaShiCangViewController.h"

@interface YuanGongViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
}

@end

@implementation YuanGongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"员工状况";
    arr_names =[NSMutableArray arrayWithArray:@[@"在职员工",@"离职员工",@"驾驶舱"]];
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
    cell.textLabel.text=arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //在职人员
            YGZaiZhiViewController *ZZvc =[[YGZaiZhiViewController alloc]init];
            [self.navigationController pushViewController:ZZvc animated:NO];
            
        }
            break;
        case 1:
        {
            //离职人员
            YGLiZhiViewController *lZvc =[[YGLiZhiViewController alloc]init];
            [self.navigationController pushViewController:lZvc animated:NO];
        }
            break;
        case 2:
        {
           //驾驶舱
            YGJiaShiCangViewController *JCvc =[[YGJiaShiCangViewController alloc]init];
            [self.navigationController pushViewController:JCvc animated:NO];
        }
            break;
            
        default:
            break;
    }
}




@end
