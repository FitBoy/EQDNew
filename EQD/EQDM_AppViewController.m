//
//  EQDM_AppViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDM_AppViewController.h"
#import "EQDM_ArticleViewController.h"
#import "EQDM_VideoViewController.h"
#import "EQDM_NeedViewController.h"
#import "EQDMMy_ViewController.h"
@interface EQDM_AppViewController ()

@end

@implementation EQDM_AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EQDM_ArticleViewController  *Avc =[[EQDM_ArticleViewController alloc]init];
    UINavigationController *nav1 =[[UINavigationController alloc]initWithRootViewController:Avc]; //创文圈
    EQDM_VideoViewController *Vvc =[[EQDM_VideoViewController alloc]init];
    UINavigationController *nav2 =[[UINavigationController alloc]initWithRootViewController:Vvc]; // 视频圈
    EQDM_NeedViewController *Nvc =[[EQDM_NeedViewController alloc]init];
    UINavigationController *nav3 =[[UINavigationController alloc]initWithRootViewController:Nvc]; //需求广场
    EQDMMy_ViewController  *Mvc =[[EQDMMy_ViewController alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:Mvc];
    
    [self setArr_vicontrollers:@[nav1,nav2,nav3,nav4] Witharr_titles:@[@"创文圈",@"视频圈",@"需求广场",@"我的"]];
    
    
 
    
    
}


@end
