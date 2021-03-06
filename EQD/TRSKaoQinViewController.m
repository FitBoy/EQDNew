//
//  TRSKaoQinViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TRSKaoQinViewController.h"
#import "KQBanBieViewController.h"
#import "KQ_BanCiViewController.h"
#import "SheZhi_QJ_CCViewController.h"
@interface TRSKaoQinViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
}

@end

@implementation TRSKaoQinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"考勤管理";
    //[@"班别设置",@"班次设置",@"打卡数据",@"考勤统计",@"异常考勤申请待批",@"其他打卡数据",@"流程查询"]
    arr_names = [NSMutableArray arrayWithArray:@[@"班别设置",@"班次设置",@"请假设置",@"出差设置",@"打卡数据",@"考勤统计"]];
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
            //班别设置
            KQBanBieViewController *BBvc =[[KQBanBieViewController alloc]init];
            [self.navigationController pushViewController:BBvc animated:NO];
        }
            break;
          case 1:
        {
            //班次设置
            KQ_BanCiViewController *BCvc =[[KQ_BanCiViewController alloc]init];
            [self.navigationController pushViewController:BCvc animated:NO];
        }
            break;
            case 2:
        {
            //请假设置
            SheZhi_QJ_CCViewController *QCvc=[[SheZhi_QJ_CCViewController alloc]init];
            QCvc.type=@"1";
            [self.navigationController pushViewController:QCvc animated:NO];
        }
            break;
            case 3:
        {
            ///出差设置
            SheZhi_QJ_CCViewController *QCvc=[[SheZhi_QJ_CCViewController alloc]init];
            QCvc.type=@"2";
            [self.navigationController pushViewController:QCvc animated:NO];
        }
            break;
        default:
            break;
    }
}



@end
