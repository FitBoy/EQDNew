//
//  CKHD_LIstBaomingViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CKHD_LIstBaomingViewController.h"
#import "FBOne_img1TableViewCell.h"
#import "CKHD_ListModel.h"
@interface CKHD_LIstBaomingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    NSString *page1;
    NSMutableArray *arr_mdoel1;
}

@end

@implementation CKHD_LIstBaomingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if(self.temp ==0)
    {
        //活动报名的人
    [WebRequest  Activity_Get_ActiveBaoMingWithpage:@"0" activityId:self.activeId status:@"1"  And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if([dic[Y_STATUS] integerValue]==200)
        {
            [arr_model removeAllObjects];
            page = dic[@"page"];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                CKHD_ListModel *model = [CKHD_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }else
    {
        //活动签到的人
        [WebRequest Activity_Sign_Get_SignWithpage:@"0" activityId:self.activeId And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if([dic[Y_STATUS] integerValue]==200)
            {
                [arr_mdoel1 removeAllObjects];
                page = dic[@"page"];
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    CKHD_ListModel *model = [CKHD_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_mdoel1 addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }
}
-(void)loadMoreData
{
    if(self.temp ==0)
    {
        
    [WebRequest  Activity_Get_ActiveBaoMingWithpage:page activityId:self.activeId status:@"1"  And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if([dic[Y_STATUS] integerValue]==200)
        {
           
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
             page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                CKHD_ListModel *model = [CKHD_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
    }else
    {
        //活动签到的人
        
        [WebRequest Activity_Sign_Get_SignWithpage:page1 activityId:self.activeId And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if([dic[Y_STATUS] integerValue]==200)
            {
                
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    CKHD_ListModel *model = [CKHD_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_mdoel1 addObject:model];
                }
                [tableV reloadData];
            }
            }
        }];
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.temp==0?@"报名情况":@"签到情况";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page = @"0";
    page1=@"0";
    arr_mdoel1 = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.temp ==0? arr_model.count:arr_mdoel1.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    if (self.temp ==0) {
        CKHD_ListModel  *model = arr_model[indexPath.row];
        cell.textLabel.text = model.username;
    }else
    {
        CKHD_ListModel  *model = arr_mdoel1[indexPath.row];
        cell.textLabel.text = model.username;
    }
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
