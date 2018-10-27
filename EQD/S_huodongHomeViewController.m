//
//  S_huodongHomeViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "S_huodongHomeViewController.h"
#import "S_huodongAddViewController.h"
@interface S_huodongHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    
}

@end

@implementation S_huodongHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动";
     UIBarButtonItem *right2 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(HDsearchClick)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(HDaddClick)];
    [self.navigationItem setRightBarButtonItems:@[right,right2]];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    [self.navigationItem setLeftBarButtonItem:left];

}
#pragma  mark - 搜索
-(void)HDsearchClick
{
    
}
#pragma  mark - 返回
-(void)leftClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)HDaddClick
{
    S_huodongAddViewController *Avc = [[S_huodongAddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}



@end
