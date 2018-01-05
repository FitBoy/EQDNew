//
//  FB_PXCaiGouViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_PXCaiGouViewController.h"

@interface FB_PXCaiGouViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
}

@end

@implementation FB_PXCaiGouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"培训采购列表";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(kuaijiefangshi)];
    [self.navigationItem setRightBarButtonItem:right];
}



@end
