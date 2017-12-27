//
//  DGuanLiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "DGuanLiViewController.h"
#import "GLRecordViewController.h"
#import "GLChanceViewController.h"
#import "GLLianXiRenViewController.h"
#import "GLFanKuiViewController.h"
@interface DGuanLiViewController ()
{
    NSMutableArray *arr_names;
}

@end

@implementation DGuanLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"客户名称";
    self.view.backgroundColor =[UIColor whiteColor];
    GLRecordViewController *Rvc =[[GLRecordViewController alloc]init];
    Rvc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"回访记录" image:[[UIImage imageNamed:@"eqd_huifang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"eqd_huifang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    GLChanceViewController *cvc=[[GLChanceViewController alloc]init];
    cvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"销售机会" image:[[UIImage imageNamed:@"eqd_chance"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"eqd_chance"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
   
    
    GLLianXiRenViewController *LXvc =[[GLLianXiRenViewController alloc]init];
    LXvc.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"联系人" image:[[UIImage imageNamed:@"tongxunlu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tongxunlu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  
    
    GLFanKuiViewController *FKvc =[[GLFanKuiViewController alloc]init];
    FKvc.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"反馈记录" image:[[UIImage imageNamed:@"eqd_fankui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"eqd_fankui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.selectedIndex = 0;
    self.viewControllers=@[cvc,Rvc,FKvc,LXvc];
    
    arr_names=[NSMutableArray arrayWithArray:@[@"销售机会",@"回访记录",@"反馈记录",@"联系人"]];
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    
}
-(void)addClick
{
    switch (self.selectedIndex) {
        case 0:
        {
            //销售机会
            CAddViewController *Avc =[[CAddViewController alloc]init];
            Avc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:Avc animated:NO];
        }
            break;
        case 1:
        {
            //回访记录
            RAddViewController *RAvc =[[RAddViewController alloc]init];
            RAvc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:RAvc animated:NO];
            
        }
            break;
        case 2:
        {
           //反馈记录
            FKAddViewController *Avc =[[FKAddViewController alloc]init];
            Avc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:Avc animated:NO];
        }
            break;
        case 3:
        {
                //联系人
                LXRAddViewController *Avc =[[LXRAddViewController alloc]init];
            Avc.model =self.model;
                Avc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:Avc animated:NO];
            
        }
            break;
            
        default:
            break;
    }
}


@end
