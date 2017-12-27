//
//  CarManagerViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CarManagerViewController.h"
#import "Car_managerOnlyViewController.h"
#import "CarUse_ListViewController.h"
@interface CarManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray *arr_names;
}

@end

@implementation CarManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title= @"车辆管理";
    arr_names = @[@"车辆管理",@"用车审批"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
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
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //车辆管理
        Car_managerOnlyViewController  *Cvc =[[Car_managerOnlyViewController alloc]init];
        [self.navigationController pushViewController:Cvc animated:NO];
        
    }else if (indexPath.row==1)
    {
        //用车审批
        CarUse_ListViewController  *lvc =[[CarUse_ListViewController alloc]init];
        lvc.isrenshi =1;
        [self.navigationController pushViewController:lvc animated:NO];
    }else
    {
    }
}




@end
