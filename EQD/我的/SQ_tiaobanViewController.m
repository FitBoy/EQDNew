//
//  SQ_tiaobanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQ_tiaobanViewController.h"
#import "TB_AddViewController.h"
#import "TiaoBan_DetailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
@interface SQ_tiaobanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UserModel *user;
    UISegmentedControl *segmentC;
    UITableView *tableV;
    NSString *page_number;
    NSMutableArray *arr_tiaoban;
}

@end

@implementation SQ_tiaobanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"122" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    [WebRequest Get_ChangeShft_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_tiaoban removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            NSArray *tarr =dic2[@"list"];
            page_number =dic2[@"page"];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    TiaoBan_ListModel *model =[TiaoBan_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_tiaoban addObject:model];
                }
            }
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        }
    }];
    
}
-(void)loadOtherData
{
    [WebRequest Get_ChangeShft_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:page_number type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            NSArray *tarr =dic2[@"list"];
            if(tarr.count==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page_number =dic2[@"page"];
           
                for (int i=0; i<tarr.count; i++) {
                    TiaoBan_ListModel *model =[TiaoBan_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_tiaoban addObject:model];
                }
         
            [tableV reloadData];
            }
            
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"调班申请列表";
    
    page_number =@"0";
    user =[WebRequest GetUserInfo];
    arr_tiaoban =[NSMutableArray arrayWithCapacity:0];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未审核",@"已审核"]];
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
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];

}
-(void)addClick
{
    TB_AddViewController *Avc =[[TB_AddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_tiaoban.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    TiaoBan_ListModel *model =arr_tiaoban[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TiaoBan_ListModel *model =arr_tiaoban[indexPath.row];
    TiaoBan_DetailViewController *Dvc =[[TiaoBan_DetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}


@end
