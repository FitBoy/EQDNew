//
//  FX_dingDanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FX_dingDanViewController.h"
#import "FX_personModel.h"
#import "Person_caiGouViewController.h"
#import "FBHeadScrollTitleView.h"
@interface FX_dingDanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
}

@end

@implementation FX_dingDanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)loadMoreData{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    page = @"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    if([user.isAdmin integerValue] >0)
    {
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"设置销售人员" style:UIBarButtonItemStylePlain target:self action:@selector(shezhiClick)];
        [self.navigationItem setRightBarButtonItem:right];
    }else
    {
        
    }
}
-(void)shezhiClick
{
    Person_caiGouViewController  *CGvc = [[Person_caiGouViewController alloc]init];
    CGvc.type = @"0";
    [self.navigationController pushViewController:CGvc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
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
