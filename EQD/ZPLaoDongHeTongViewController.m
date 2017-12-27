//
//  ZPLaoDongHeTongViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ZPLaoDongHeTongViewController.h"
#import "LDHTFaQiViewController.h"
#import "HeTong_DetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
@interface ZPLaoDongHeTongViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_hetong;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
}

@end

@implementation ZPLaoDongHeTongViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"161" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
   [WebRequest Contracts_Get_Contract_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
       NSDictionary *dic2 =dic[Y_ITEMS];
       NSArray *tarr =dic2[@"list"];
       page =dic2[@"page"];
       [arr_hetong removeAllObjects];
       if (tarr.count) {
           for ( int i=0; i<tarr.count; i++) {
               HeTong_ListModel *model =[HeTong_ListModel mj_objectWithKeyValues:tarr[i]];
               [arr_hetong addObject:model];
           }
       }
       [tableV.mj_header endRefreshing];
       [tableV.mj_footer endRefreshing];
       [tableV reloadData];
   }];
    
}
-(void)loadOtherData
{
    [WebRequest Contracts_Get_Contract_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
        NSDictionary *dic2 =dic[Y_ITEMS];
        NSArray *tarr =dic2[@"list"];
        page =dic2[@"page"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else{
            for ( int i=0; i<tarr.count; i++) {
                HeTong_ListModel *model =[HeTong_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_hetong addObject:model];
            }
                 [tableV reloadData];
        }
     
       
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"劳动合同列表";
    arr_hetong =[NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"待确认",@"已通过",@"发起的"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    
    [self.navigationItem setRightBarButtonItem:right];
   
}
-(void)tianjiaCLick
{
    //添加
    LDHTFaQiViewController  *FQvc =[[LDHTFaQiViewController alloc]init];
    [self.navigationController pushViewController:FQvc animated:NO];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_hetong.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    HeTong_ListModel *model =arr_hetong[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeTong_ListModel *model =arr_hetong[indexPath.row];
    HeTong_DetailViewController *HTvc =[[HeTong_DetailViewController alloc]init];
    HTvc.model =model;
    HTvc.isQianDing =segmentC.selectedSegmentIndex==0?2:0;
    [self.navigationController pushViewController:HTvc animated:NO];
    
}



@end
