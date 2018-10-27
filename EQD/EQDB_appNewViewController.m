//
//  EQDB_appNewViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 热门 推荐的产品，热门 推荐的需求，热门 推荐的企业

#import "EQDB_appNewViewController.h"
#import "FBScrollView.h"
#import "FBButton.h"
#import <Masonry.h>
#import "EQDB_searchViewController.h"

@interface EQDB_appNewViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    FBScrollView *head_scrollV;
    UIView *head_view;
}

@end

@implementation EQDB_appNewViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"易企购";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];

    ///tableV的顶部
    head_view = [[UIView alloc]init];
    head_scrollV = [[FBScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_WIDTH*2/3.0)];
    [head_scrollV setArr_urls:@[@"www.eqidd.com"]];
    [head_view addSubview:head_scrollV];
    FBButton *tbtn1 =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn1 setTitle:@"搜产品" titleColor:[UIColor blackColor] backgroundColor:[UIColor orangeColor] font:[UIFont systemFontOfSize:17 weight:3]];
    [head_view addSubview:tbtn1];
    [tbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 40));
        make.bottom.mas_equalTo(head_view.mas_bottom).mas_offset(-10);
        make.right.mas_equalTo(head_view.mas_centerX).mas_offset(-10);
    }];
    tbtn1.layer.masksToBounds = YES;
    tbtn1.layer.cornerRadius = 60;
    
    FBButton *tbtn2 =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn2 setTitle:@"搜需求" titleColor:[UIColor blackColor] backgroundColor:[UIColor orangeColor] font:[UIFont systemFontOfSize:17 weight:3]];
    [head_view addSubview:tbtn2];
    [tbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 40));
        make.bottom.mas_equalTo(head_view.mas_bottom).mas_offset(-10);
        make.left.mas_equalTo(head_view.mas_centerX).mas_offset(10);
    }];
    tbtn2.layer.masksToBounds = YES;
    tbtn2.layer.cornerRadius = 60;
    
    head_view.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_WIDTH*2/3.0+60);
    tableV.tableHeaderView = head_view;
    
    UIBarButtonItem *left =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backCLickB)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    [tbtn1 addTarget:self action:@selector(productClick) forControlEvents:UIControlEventTouchUpInside];
    [tbtn2 addTarget:self action:@selector(NeedClick) forControlEvents:UIControlEventTouchUpInside];

}
-(void)productClick
{
    //产品
    EQDB_searchViewController  *Svc =[[EQDB_searchViewController alloc]init];
    Svc.temp =0;
    [self.navigationController pushViewController:Svc animated:NO];
}
-(void)NeedClick
{
    //需求
    EQDB_searchViewController  *Svc =[[EQDB_searchViewController alloc]init];
    Svc.temp =1;
    [self.navigationController pushViewController:Svc animated:NO];
}
-(void)backCLickB
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
