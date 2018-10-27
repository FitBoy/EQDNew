//
//  ActiveClassViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "ActiveClassViewController.h"

@interface ActiveClassViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray *arr_names;
}

@end

@implementation ActiveClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动类型";
    arr_names = @[@"论坛",@"大会",@"研讨会",@"培训",@"市场活动",@"展览",@"聚会",@"酒会",@"其他"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
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
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate_activity respondsToSelector:@selector(getClass:withIndexPath:)]) {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate_activity getClass:arr_names[indexPath.row] withIndexPath:self.indexPath];
    }
}




@end
