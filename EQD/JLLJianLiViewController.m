//
//  JLLJianLiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "JLLJianLiViewController.h"

@interface JLLJianLiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
}

@end

@implementation JLLJianLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"简历详情";
    
}



@end
