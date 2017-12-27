//
//  FYanShouViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FYanShouViewController.h"
#import "YSDetailViewController.h"
#import "FBThree_noimg122TableViewCell.h"
@interface FYanShouViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_yanshou;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSString *iswancheng;
    NSString *select_ID;
}

@end

@implementation FYanShouViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"141" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    if (segmentC.selectedSegmentIndex==0) {
        iswancheng =@"false";
    }
    else
    {
        iswancheng =@"true";
    }
    [WebRequest Get_Task_ByCheckerWithuserGuid:user.Guid ID:@"0" status:iswancheng And:^(NSDictionary *dic) {
           if ([dic[Y_STATUS] integerValue]==200) {
        [arr_yanshou removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                RenWuListModel *model =[RenWuListModel mj_objectWithKeyValues:tarr[i]];
                [arr_yanshou addObject:model];
                if (i==tarr.count-1) {
                    select_ID =model.ID;
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
    [WebRequest Get_Task_ByCheckerWithuserGuid:user.Guid ID:select_ID status:iswancheng And:^(NSDictionary *dic) {
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
                [arr_yanshou addObject:model];
                if (i==tarr.count-1) {
                    select_ID =model.ID;
                }
            }
             [tableV reloadData];
        }
               
           }
     
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    select_ID=@"0";
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"我验收的任务";
    iswancheng =@"false";
    
    arr_yanshou =[NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未验收",@"已验收"]];
    segmentC.selectedSegmentIndex =0;
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentC];
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
    
    return arr_yanshou.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        static NSString *cellId=@"cellID";
        FBThree_noimg122TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBThree_noimg122TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        RenWuListModel *model =arr_yanshou[indexPath.row];
        [cell setModel:model];
        return cell;
   
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        RenWuListModel *model=arr_yanshou[indexPath.row];
        YSDetailViewController *YSDvc =[[YSDetailViewController alloc]init];
        YSDvc.model =model;
    YSDvc.isyanshou =[iswancheng isEqualToString:@"false"]?NO:YES;
        [self.navigationController pushViewController:YSDvc animated:NO];
}



@end
