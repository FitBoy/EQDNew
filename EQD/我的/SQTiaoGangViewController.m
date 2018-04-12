//
//  SQTiaoGangViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SQTiaoGangViewController.h"
#import "SQTiaoGang_addViewController.h"
@interface SQTiaoGangViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView  *tableV;
    NSMutableArray  *arr_model;
}

@end

@implementation SQTiaoGangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightCLick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)rightCLick
{
    //添加调岗申请
    SQTiaoGang_addViewController  *Avc =[[SQTiaoGang_addViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}


@end
