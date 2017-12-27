//
//  TZhaoPinViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TZhaoPinViewController.h"
#import "ZPLaoDongHeTongViewController.h"
@interface TZhaoPinViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
}

@end

@implementation TZhaoPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title =@"招聘管理";
    arr_names =[NSMutableArray arrayWithArray:@[@"劳动合同",@"简历库"]];
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
            //劳动合同
            ZPLaoDongHeTongViewController *LDvc =[[ZPLaoDongHeTongViewController alloc]init];
            [self.navigationController pushViewController:LDvc animated:NO];
        }
            break;
        case 1:
        {
            //简历库
        }
        default:
            break;
    }
}



@end
