//
//  FCanYuViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FCanYuViewController.h"
#import "CY_DetailViewController.h"
#import "FBThree_noimg122TableViewCell.h"
#import "RenWuListModel.h"

@interface FCanYuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_canyu;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSString *selected_ID;
    NSString *temp_id;
}

@end

@implementation FCanYuViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"142" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    selected_ID = segmentC.selectedSegmentIndex==0?@"1":@"3";
    [WebRequest Get_Task_ByOtherWithuserGuid:user.Guid ID:@"0" status:selected_ID And:^(NSDictionary *dic) {
           if ([dic[Y_STATUS] integerValue]==200) {
        NSArray *tarr =dic[Y_ITEMS];
        [arr_canyu removeAllObjects];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                RenWuListModel *model =[RenWuListModel mj_objectWithKeyValues:tarr[i]];
                [arr_canyu addObject:model];
                if (i==tarr.count-1) {
                    temp_id =model.ID;
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
    [WebRequest Get_Task_ByOtherWithuserGuid:user.Guid ID:temp_id status:selected_ID And:^(NSDictionary *dic) {
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
                [arr_canyu addObject:model];
                if (i==tarr.count-1) {
                    temp_id =model.ID;
                }
            }
           [tableV reloadData];
        }
           }
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    selected_ID =@"1";
    temp_id=@"0";
    self.navigationItem.title=@"我参与的任务";
    user =[WebRequest GetUserInfo];
    adjustsScrollViewInsets_NO(tableV, self);
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未完成",@"已完成"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    arr_canyu=[NSMutableArray arrayWithCapacity:0];
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
    return arr_canyu.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBThree_noimg122TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBThree_noimg122TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    RenWuListModel *model =arr_canyu[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RenWuListModel *model =arr_canyu[indexPath.row];
    CY_DetailViewController *Dvc =[[CY_DetailViewController alloc]init];
    Dvc.renwuID =model.ID;
    [self.navigationController pushViewController:Dvc animated:NO];
    
}




@end
