//
//  EQDB_appViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDB_appViewController.h"
#import "FBButton.h"
#import <Masonry.h>
#import "EQDB_searchViewController.h"
@interface EQDB_appViewController ()
{
    FBButton *tbtn_product;
    FBButton *tbtn_need;
}

@end

@implementation EQDB_appViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"易企购";
    tbtn_product = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn_product setTitle:@"搜索产品" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:19]];
    [self.view addSubview:tbtn_product];
    [tbtn_product mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(-10);
    }];
    [tbtn_product addTarget:self action:@selector(productClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    tbtn_need = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn_need setTitle:@"搜索需求" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:19]];
    [self.view addSubview:tbtn_need];
    
    [tbtn_need mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_centerY).mas_offset(10);
    }];
    [tbtn_need addTarget:self action:@selector(needClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *left  = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)productClick
{
    //产品
    EQDB_searchViewController  *Svc =[[EQDB_searchViewController alloc]init];
    Svc.temp =0;
    [self.navigationController pushViewController:Svc animated:NO];
}
-(void)needClick
{
    //需求
    EQDB_searchViewController  *Svc =[[EQDB_searchViewController alloc]init];
    Svc.temp =1;
    [self.navigationController pushViewController:Svc animated:NO];
}



@end
