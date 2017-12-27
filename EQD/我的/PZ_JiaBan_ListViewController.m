//
//  PZ_JiaBan_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZ_JiaBan_ListViewController.h"
#import "JB_DetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
@interface PZ_JiaBan_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_jiaban;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page_number;
}

@end

@implementation PZ_JiaBan_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString *code =self.isRenShi==1?@"251":@"250";
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    //人事的审批
    if (self.isRenShi==1) {
        [WebRequest OverTimes_Get_OverTime_ByHRWithtype:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] userGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_jiaban removeAllObjects];
                NSDictionary *dic2=dic[Y_ITEMS];
                page_number =dic2[@"page"];
                NSArray *tarr =dic2[@"list"];
                if (tarr.count) {
                    for (int i=0; i<tarr.count; i++) {
                        JiaBan_ListModel *model =[JiaBan_ListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_jiaban addObject:model];
                    }
                }
            }
            
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
            
        }];
        
    }
    else
    {
    [WebRequest OverTimes_Get_OverTime_ByCheckerWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_jiaban removeAllObjects];
            NSDictionary *dic2=dic[Y_ITEMS];
            page_number =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    JiaBan_ListModel *model =[JiaBan_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_jiaban addObject:model];
                }
            }
           
            [tableV reloadData];
        }
      
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
    }];
    }
}
-(void)loadOtherData
{
    if (self.isRenShi==1) {
        [WebRequest OverTimes_Get_OverTime_ByHRWithtype:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] userGuid:user.Guid page:page_number And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *dic2=dic[Y_ITEMS];
               
                NSArray *tarr =dic2[@"list"];
                if (tarr.count==0) {
                    [tableV.mj_header endRefreshing];
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                 page_number =dic2[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        JiaBan_ListModel *model =[JiaBan_ListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_jiaban addObject:model];
                    }
                
                 
                    [tableV reloadData];
            }
            }
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
        }];
        
    }else
    {
    [WebRequest OverTimes_Get_OverTime_ByCheckerWithcompanyId:user.companyId userGuid:user.Guid page:page_number type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2=dic[Y_ITEMS];
            page_number =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    JiaBan_ListModel *model =[JiaBan_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_jiaban addObject:model];
                }
            }
        }
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        [tableV reloadData];
        
    }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"加班申请列表";
    
    user =[WebRequest GetUserInfo];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    arr_jiaban =[NSMutableArray arrayWithCapacity:0];
    page_number =@"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
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
    cell.L_left1.text =@"加班时间段";
    cell.L_right0.text =model.createTime;
    cell.L_right1.text =[NSString stringWithFormat:@"%@~%@",model.startTime,model.endTime];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JiaBan_ListModel *model =arr_jiaban[indexPath.row];
    JB_DetailViewController *Dvc =[[JB_DetailViewController alloc]init];
    Dvc.isShenPi=segmentC.selectedSegmentIndex+1;
    Dvc.model =model;
    Dvc.isRenShi =self.isRenShi;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
