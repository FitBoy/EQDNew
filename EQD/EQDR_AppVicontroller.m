//
//  EQDR_AppVicontroller.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_AppVicontroller.h"
#import "EQDR_ShouYeViewController.h"
#import "EQDR_FindViewController.h"
#import "EQDR_MyViewController.h"
@interface EQDR_AppVicontroller()

@end

@implementation EQDR_AppVicontroller
-(void)viewDidLoad
{
    [super viewDidLoad];
    EQDR_ShouYeViewController  *SYvc =[[EQDR_ShouYeViewController alloc]init];

    SYvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"EQDR_shouye"] selectedImage:[UIImage imageNamed:@"EQDR_shouye_focus"]];
    UINavigationController  *nav1 =[[UINavigationController alloc]initWithRootViewController:SYvc];
    EQDR_FindViewController  *Fvc =[[EQDR_FindViewController alloc]init];
    Fvc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"faxian"] selectedImage:[UIImage imageNamed:@"faxian_focu"]];
    UINavigationController *nav2 =[[UINavigationController alloc]initWithRootViewController:Fvc];
    EQDR_MyViewController  *Mvc =[[EQDR_MyViewController alloc]init];
    Mvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"tongxunlu"] selectedImage:[UIImage imageNamed:@"tongxunlu_foucus"] ];
    UINavigationController *nav3 =[[UINavigationController alloc]initWithRootViewController:Mvc];
    
    self.viewControllers = @[nav1,nav2,nav3];
    self.selectedIndex=0;
    
}

@end
