//
//  HeTong_listPersonViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "HeTong_listPersonViewController.h"
#import "HeTong_DetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
@interface HeTong_listPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentC;
    NSMutableArray *arr_list;
    UserModel *user;
    NSString *page;
}

@end

@implementation HeTong_listPersonViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"160" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    [WebRequest Contracts_Get_Contract_BySignatoryWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [arr_list removeAllObjects];
        NSDictionary *dic2  =dic[Y_ITEMS];
        NSArray *tarr =dic2[@"list"];
        page =dic2[@"page"];
        if(tarr.count)
        {
            for (int i=0; i<tarr.count; i++) {
                HeTong_ListModel *model =[HeTong_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_list addObject:model];
            }
        }
        [tableV reloadData];
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
    }];
    
}
-(void)loadOtherData
{
    [WebRequest Contracts_Get_Contract_BySignatoryWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
        NSDictionary *dic2  =dic[Y_ITEMS];
        NSArray *tarr =dic2[@"list"];
        page =dic2[@"page"];
        if(tarr.count==0)
        {
            [tableV.mj_footer endRefreshingWithNoMoreData];
        }else
        {
            for (int i=0; i<tarr.count; i++) {
                HeTong_ListModel *model =[HeTong_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_list addObject:model];
            }
              [tableV reloadData];
        }
      
      
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    page=0;
    arr_list =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"合同邀请列表";
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未签订",@"已签订"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_list.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    HeTong_ListModel *model =arr_list[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeTong_ListModel *model =arr_list[indexPath.row];
    HeTong_DetailViewController  *Dvc =[[HeTong_DetailViewController alloc]init];
    Dvc.model =model;
    Dvc.isQianDing =segmentC.selectedSegmentIndex==0?1:0;
    [self.navigationController pushViewController:Dvc animated:NO];
    
}




@end
