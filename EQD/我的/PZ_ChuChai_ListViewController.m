//
//  PZ_ChuChai_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZ_ChuChai_ListViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "SQ_ChuChuai_DetailViewController.h"
@interface PZ_ChuChai_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_chuchai;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSString* page_number;
}

@end

@implementation PZ_ChuChai_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString *code = self.isRenShi==1?@"111":@"110";
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    if (self.isRenShi ==1) {
        [WebRequest travel_Get_Travel_ByHRWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_chuchai removeAllObjects];
                NSDictionary *dic2 =dic[Y_ITEMS];
                page_number = dic2[@"page"];
                NSArray *tarr =dic2[@"list"];
                if (tarr.count) {
                    for (int i=0; i<tarr.count; i++) {
                        ChuChai_ListModel *model =[ChuChai_ListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_chuchai addObject:model];
                    }
                }
               
            }
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
           
        }];
        
        
    }else
    {
    [WebRequest  travel_Get_Travel_ByLeaderWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
        
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_chuchai removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            page_number = dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    ChuChai_ListModel *model =[ChuChai_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_chuchai addObject:model];
                }
            }
           
        }
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        [tableV reloadData];
       
    }];
    }
    
}
-(void)loadOtherData
{
    if (self.isRenShi ==1) {
        [WebRequest travel_Get_Travel_ByHRWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page_number And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *dic2 =dic[Y_ITEMS];
               
                NSArray *tarr =dic2[@"list"];
                if (tarr.count==0) {
                    [tableV.mj_header endRefreshing];
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
               page_number = dic2[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        ChuChai_ListModel *model =[ChuChai_ListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_chuchai addObject:model];
                    }
                  
                    [tableV reloadData];
                
            }
            
            }
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
        }];
        
    }else
    {
    [WebRequest  travel_Get_Travel_ByLeaderWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page_number And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            page_number = dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    ChuChai_ListModel *model =[ChuChai_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_chuchai addObject:model];
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
    self.navigationItem.title =@"出差列表";
    user =[WebRequest GetUserInfo];
    arr_chuchai =[NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
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
    cell.L_left0.text =@"申请时间";
    cell.L_right0.text =model.createTime;
//    cell.L_left1.text =@"出差地点:";
    cell.L_right1.text =model.travelAddress;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChuChai_ListModel *model =arr_chuchai[indexPath.row];
    SQ_ChuChuai_DetailViewController *Dvc =[[SQ_ChuChuai_DetailViewController alloc]init];
    Dvc.model =model;
    Dvc.isShenPi =segmentC.selectedSegmentIndex+1;
    Dvc.isRenShi =self.isRenShi;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
