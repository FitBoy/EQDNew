//
//  FFaQiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FFaQiViewController.h"
#import "FBThree_noimg122TableViewCell.h"
#import "FQ_RenWuDetailViewController.h"
@interface FFaQiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentC;
    NSMutableArray *arr_renwu;
    NSString *lastId;
    UserModel *user;
    
}

@end

@implementation FFaQiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"143" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    [WebRequest Get_Task_ByCreaterWithuserGuid:user.Guid ID:@"0" status:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
           if ([dic[Y_STATUS] integerValue]==200) {
        [arr_renwu removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                RenWuListModel *model =[RenWuListModel mj_objectWithKeyValues:tarr[i]];
                [arr_renwu addObject:model];
                if (i==tarr.count-1) {
                    lastId =model.ID;
                }
            }
        }
           }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        });
    }];
    
}
-(void)loadOtherData
{
    [WebRequest Get_Task_ByCreaterWithuserGuid:user.Guid ID:lastId status:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
           if ([dic[Y_STATUS] integerValue]==200) {
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count==0) {
            [tableV.mj_footer endRefreshingWithNoMoreData];
        }else
        {
            for (int i=0; i<tarr.count; i++) {
                RenWuListModel *model =[RenWuListModel mj_objectWithKeyValues:tarr[i]];
                [arr_renwu addObject:model];
            }
               [tableV reloadData];
        }
           }
        
    }];
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    lastId =@"0";
    arr_renwu =[NSMutableArray arrayWithCapacity:0];
    
    segmentC = [[UISegmentedControl alloc]initWithItems:@[@"待接受",@"已接受",@"已拒绝",@"已完成"]];
    [self.view addSubview:segmentC];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    segmentC.selectedSegmentIndex=0;
    self.navigationItem.title =@"我发起的任务";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_renwu.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBThree_noimg122TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBThree_noimg122TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    RenWuListModel *model =arr_renwu[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RenWuListModel *model =arr_renwu[indexPath.row];
    FQ_RenWuDetailViewController *Dvc =[[FQ_RenWuDetailViewController  alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
    
}



@end
