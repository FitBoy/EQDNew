//
//  FB_PeiXunManagerViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_PeiXunManagerViewController.h"
#import "PXNeedListViewController.h"
#import "PX_PlanViewController.h"
#import "FB_notificationListViewController.h"
#import "PXKaoQinListViewController.h"
@interface FB_PeiXunManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray *arr_model;
}

@end

@implementation FB_PeiXunManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"培训管理";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    arr_model = @[@"培训需求",@"课程管理",@"培训计划",@"培训通知",@"培训考勤",@"培训评价"];

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text =arr_model[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   //  arr_model = @[@"培训采购",@"课程管理",@"培训计划",@"培训通知",@"培训考勤",@"培训评价"];
    switch (indexPath.row) {
        case 0:
        {
         //培训需求
            PXNeedListViewController  *Nvc =[[PXNeedListViewController alloc]init];
            [self.navigationController  pushViewController:Nvc animated:NO];
        }
            break;
        case 1:
        {
         
        }
            break;
        case 2:
        {
            //培训计划
            PX_PlanViewController  *Pvc =[[PX_PlanViewController alloc]init];
            [self.navigationController pushViewController:Pvc animated:NO];
        }
            break;
        case 3:
        {
            //培训通知
            FB_notificationListViewController  *Lvc= [[FB_notificationListViewController alloc]init];
            [self.navigationController pushViewController:Lvc animated:NO];
        }
            break;
        case 4:
        {
           //培训考勤
            PXKaoQinListViewController *KQvc =[[PXKaoQinListViewController alloc]init];
            [self.navigationController pushViewController:KQvc animated:NO];
        }
            break;
        case 5:
        {
            //培训评价
        }
            break;
            
        default:
            break;
    }
}




@end
