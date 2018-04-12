//
//  RS_CaiWuViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RS_CaiWuViewController.h"
#import "RSCW_baoXiaoSetViewController.h"
@interface RS_CaiWuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray *arr_names;
  
}

@end

@implementation RS_CaiWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"财务管理";
    arr_names =@[@"报销设置"];
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
                //报销设置
                RSCW_baoXiaoSetViewController *BXvc =[[RSCW_baoXiaoSetViewController alloc]init];
                [self.navigationController pushViewController:BXvc animated:NO];
            }
            break;
            
        default:
            break;
    }
}




@end
