//
//  MyRenWuViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MyRenWuViewController.h"
#import "MRW_DetailViewController.h"
#import "FBThree_noimg122TableViewCell.h"
@interface MyRenWuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_renwu;
    UISegmentedControl *segmentC;
    UserModel *user ;
    NSString *selectd_id;
    NSString *selected_Str;
}

@end

@implementation MyRenWuViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"140" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    if (segmentC.selectedSegmentIndex==2) {
        selected_Str =@"3";
    }
    else
    {
        selected_Str =[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex];
    }
    [WebRequest Get_Task_ByRecipientWithuserGuid:user.Guid ID:@"0" status:selected_Str And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
        [arr_renwu removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                RenWuListModel *model =[RenWuListModel mj_objectWithKeyValues:tarr[i]];
                [arr_renwu addObject:model];
                if (i==tarr.count-1) {
                    selectd_id =model.ID;
                }
            }
        }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
            
        });
    }];
    
}
-(void)loadOtherData
{
    [WebRequest Get_Task_ByRecipientWithuserGuid:user.Guid ID:selectd_id status:selected_Str And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
           if ([dic[Y_STATUS] integerValue]==200) {
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count==0) {
            [tableV.mj_footer endRefreshingWithNoMoreData];
        }else
        {
            for (int i=0; i<tarr.count; i++) {
                RenWuListModel *model =[RenWuListModel mj_objectWithKeyValues:tarr[i]];
                [arr_renwu addObject:model];
                if (i==tarr.count-1) {
                    selectd_id =model.ID;
                }
            }
              [tableV reloadData];
        }
           }
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"我的任务";
    selectd_id =@"0";
    selected_Str=@"0";
    adjustsScrollViewInsets_NO(tableV, self);
    user =[WebRequest GetUserInfo];
    segmentC = [[UISegmentedControl alloc]initWithItems:@[@"新任务",@"未完成",@"已完成"]];
    [self.view addSubview:segmentC];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    
    arr_renwu = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
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
    MRW_DetailViewController *Dvc =[[MRW_DetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
