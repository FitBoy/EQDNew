//
//  SQChuChaViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQChuChaViewController.h"
#import "SQChuChaAddViewController.h"
#import "SQ_ChuChuai_DetailViewController.h"

#import "FBFour_noimgTableViewCell.h"
@interface SQChuChaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSMutableArray *arr_chuchai;
    NSString *page_number;
}

@end

@implementation SQChuChaViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"112" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    [WebRequest travel_Get_Travel_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [arr_chuchai removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page_number =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                ChuChai_ListModel *model =[ChuChai_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_chuchai addObject:model];
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
    [WebRequest travel_Get_Travel_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:page_number type:[NSString stringWithFormat:@"%ld",(long)segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page_number =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        if (tarr.count==0) {
            [tableV.mj_footer endRefreshingWithNoMoreData];
        }else
        {
            for (int i=0; i<tarr.count; i++) {
                ChuChai_ListModel *model =[ChuChai_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_chuchai addObject:model];
            }
              [tableV reloadData];
        }
        
     
    }];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_chuchai =[NSMutableArray arrayWithCapacity:0];
    page_number=@"0";
    self.navigationItem.title =@"出差申请";
   
    segmentC = [[UISegmentedControl alloc]initWithItems:@[@"待审批",@"已审批"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentC];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
     adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    
    tableV.rowHeight=50;
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)addClick
{
    
    SQChuChaAddViewController *Avc =[[SQChuChaAddViewController alloc]init];
    
    [self.navigationController pushViewController:Avc animated:NO];
    
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_chuchai.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    ChuChai_ListModel *model =arr_chuchai[indexPath.row];
    cell.L_left0.text=@"提交时间";
    cell.L_right0.text =model.createTime;
    cell.L_left1.text =@"出差地点";
    cell.L_right1.text =model.travelAddress;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChuChai_ListModel *model =arr_chuchai[indexPath.row];
    SQ_ChuChuai_DetailViewController *Dvc =[[SQ_ChuChuai_DetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
