//
//  KHShaiXuanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "KHShaiXuanViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "KHDetailViewController.h"
#import "FBAddressViewController.h"
@interface KHShaiXuanViewController ()<UITableViewDelegate,UITableViewDataSource,FBAddressViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_kehu;
}

@end

@implementation KHShaiXuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"筛选";
    arr_one =[NSMutableArray arrayWithArray:@[@"客户类型",@"客户区域"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return arr_one.count;
    }
    return arr_kehu.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
    {
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
    }
    else
    {
        static NSString *cellid2 =@"cellid2";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell =[[FBFour_noimgTableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.L_left0.text = @"客户名称";
        
        
        return cell;
        
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //客户类型
        }
        else
        {
            //销售区域
            FBAddressViewController *Avc =[[FBAddressViewController alloc]init];
            Avc.indexPath =indexPath;
            Avc.delegate =self;
            [self.navigationController pushViewController:Avc animated:NO];
            
        }
    }
    else
    {
        KHDetailViewController *Dvc =[[KHDetailViewController alloc]init];
        [self.navigationController pushViewController:Dvc animated:NO];
    }
}

#pragma  mark -自定义的协议代理
-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    [arr_one replaceObjectAtIndex:indexPath.row withObject:address];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
}


@end
