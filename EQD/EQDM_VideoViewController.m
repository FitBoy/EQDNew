//
//  EQDM_VideoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDM_VideoViewController.h"

@interface EQDM_VideoViewController ()

@end

@implementation EQDM_VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"视频圈";
    self.view.backgroundColor = [UIColor greenColor];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItems:@[right,right1]];
    UIBarButtonItem *Left =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClcik)];
    [self.navigationItem setLeftBarButtonItem:Left];
}
#pragma  mark - 返回
-(void)leftClcik{
   //返回
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma  mark - 搜索视频
-(void)searchClick
{
    
}
#pragma  mark - 添加视频
-(void)tianjiaCLick
{
    
}

@end
