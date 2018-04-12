//
//  SQTiaoXiuViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQTiaoXiuViewController.h"
#import "TX_AddViewController.h"
#import "TX_DetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
@interface SQTiaoXiuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSString *page_number;
    NSMutableArray *arr_list;
}

@end

@implementation SQTiaoXiuViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"242" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    [WebRequest  Get_Off_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [arr_list removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page_number =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                TiaoXiu_listModel *model =[TiaoXiu_listModel mj_objectWithKeyValues:tarr[i]];
                [arr_list addObject:model];
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
    [WebRequest  Get_Off_ByCreaterWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            page_number =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                for (int i=0; i<tarr.count; i++) {
                    TiaoXiu_listModel *model =[TiaoXiu_listModel mj_objectWithKeyValues:tarr[i]];
                    [arr_list addObject:model];
                }
            }
           
                [tableV reloadData];
 
        }
       
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_list=[NSMutableArray arrayWithCapacity:0];
    
    self.navigationItem.title =@"调休列表";
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
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];

}

-(void)addClick
{
    TX_AddViewController *Avc =[[TX_AddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
    
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
    TiaoXiu_listModel *model =arr_list[indexPath.row];
    cell.L_left0.text =@"申请时间";
    cell.L_right0.text =model.createTime;
    cell.L_left1.text =@"调休时间";
    cell.L_right1.text =[NSString stringWithFormat:@"%@ ~ %@",model.planStartTime,model.planEndTime];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TiaoXiu_listModel *model =arr_list[indexPath.row];
    TX_DetailViewController *Dvc =[[TX_DetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
