//
//  DaKa_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "DaKa_DetailViewController.h"
#import "FBFive_noimgTableViewCell.h"
@interface DaKa_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    
}

@end

@implementation DaKa_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =self.date;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=90;
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_jilu.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFive_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFive_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    DaKaJiLu *jilul =self.arr_jilu[indexPath.row];
    [cell setModel:jilul];
    return cell;
}






@end
