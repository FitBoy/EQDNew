//
//  MSafeViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MSafeViewController.h"
#import "FBPhoneViewController.h"
#import "FBPhoneViewController.h"
#import "SJieBangPhoneViewController.h"
@interface MSafeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    
}

@end

@implementation MSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"安全";
    arr_one=[NSMutableArray arrayWithArray:@[@"修改密码",@"解绑手机"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_one.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text=arr_one[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //修改密码
        FBPhoneViewController *Pvc =[[FBPhoneViewController alloc]init];
        [self.navigationController pushViewController:Pvc animated:NO];
        
    }
    else if(indexPath.row==1)
    {
        SJieBangPhoneViewController *JBvc =[[SJieBangPhoneViewController alloc]init];
        [self.navigationController pushViewController:JBvc animated:NO];
    }
    else
    {
        
    }
}



@end
