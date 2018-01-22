//
//  EQDM_NeedViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDM_NeedViewController.h"

@interface EQDM_NeedViewController ()

@end

@implementation EQDM_NeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"需求广场";
    self.view.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
   /* UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];*/
    [self.navigationItem setRightBarButtonItems:@[right]];
    UIBarButtonItem *Left =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClcik)];
    [self.navigationItem setLeftBarButtonItem:Left];
}
#pragma  mark - 返回
-(void)leftClcik
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma  mark - 添加需求
-(void)tianjiaCLick
{
    
}
#pragma  mark - 搜索需求
-(void)searchClick
{
    
}

@end
