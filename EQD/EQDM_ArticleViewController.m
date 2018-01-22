//
//  EQDM_ArticleViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDM_ArticleViewController.h"

@interface EQDM_ArticleViewController ()

@end

@implementation EQDM_ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"创文圈";
    UIBarButtonItem *Left =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClcik)];
    [self.navigationItem setLeftBarButtonItem:Left];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItems:@[right,right1]];
    
}
-(void)leftClcik
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma  mark - 添加创文
-(void)tianjiaCLick
{
    
}
#pragma  mark - 搜索创文
-(void)searchClick
{
    
}


@end
