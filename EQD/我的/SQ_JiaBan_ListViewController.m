//
//  SQ_JiaBan_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQ_JiaBan_ListViewController.h"
#import "JB_AddViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "JB_DetailViewController.h"
@interface SQ_JiaBan_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray  *arr_jiaban;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSString *page_number;
}

@end

@implementation SQ_JiaBan_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"252" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    [WebRequest OverTimes_Get_OverTime_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [arr_jiaban removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page_number =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                JiaBan_ListModel *model =[JiaBan_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_jiaban addObject:model];
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
    [WebRequest OverTimes_Get_OverTime_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:page_number type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
        NSDictionary *dic2 =dic[Y_ITEMS];
        page_number =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
     
            for (int i=0; i<tarr.count; i++) {
                JiaBan_ListModel *model =[JiaBan_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_jiaban addObject:model];
            }
           
            [tableV reloadData];
        
            }
           
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_jiaban =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"加班申请列表";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
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
    return arr_jiaban.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    JiaBan_ListModel *model =arr_jiaban[indexPath.row];
    cell.L_left0.text =@"申请时间";
    cell.L_right0.text =model.createTime;
    cell.L_left1.text =@"加班时间段";
    cell.L_right1.text =[NSString stringWithFormat:@"%@ ~%@",model.startTime,model.endTime];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JiaBan_ListModel *model =arr_jiaban[indexPath.row];
    JB_DetailViewController *Dvc =[[JB_DetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}

#pragma  mark - 添加
-(void)addClick
{
    JB_AddViewController *Avc =[[JB_AddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}




@end
