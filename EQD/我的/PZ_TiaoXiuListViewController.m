//
//  PZ_TiaoXiuListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZ_TiaoXiuListViewController.h"
#import "TX_DetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
@interface PZ_TiaoXiuListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page_number;
    NSMutableArray *arr_list;
}

@end

@implementation PZ_TiaoXiuListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString  *code =self.isRenShi==1?@"241":@"240";
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    if(self.isRenShi==1)
    {
       [WebRequest Get_Off_ByHRWithuserGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
           if ([dic[Y_STATUS] integerValue]==200) {
           [arr_list removeAllObjects];
           NSDictionary *dic2 =dic[Y_ITEMS];
           page_number =dic2[@"page"];
           NSArray *tarr =dic2[@"list"];
           if (tarr.count) {
               for (int i=0; i<tarr.count; i++) {
                   TiaoXiu_listModel  *model =[TiaoXiu_listModel mj_objectWithKeyValues:tarr[i]];
                   [arr_list addObject:model];
               }
              
           }
           }
           dispatch_async(dispatch_get_main_queue(), ^{
               [tableV.mj_footer endRefreshing];
               [tableV.mj_header endRefreshing];
               [tableV reloadData];
           });
       }];
        
    }else
    {
    
     [WebRequest Get_Off_ByCheckerWithcompanyId:user.companyId userGuid:user.Guid page:@"0" type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
         if ([dic[Y_STATUS] integerValue]==200) {
        
         [arr_list removeAllObjects];
         NSDictionary *dic2 =dic[Y_ITEMS];
         page_number =dic2[@"page"];
         NSArray *tarr =dic2[@"list"];
         if (tarr.count) {
             for (int i=0; i<tarr.count; i++) {
                 TiaoXiu_listModel  *model =[TiaoXiu_listModel mj_objectWithKeyValues:tarr[i]];
                 [arr_list addObject:model];
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
    
}
-(void)loadOtherData
{
    
    if (self.isRenShi ==1) {
        [WebRequest Get_Off_ByHRWithuserGuid:user.Guid page:page_number type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
           
            NSArray *tarr =dic2[@"list"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
            page_number =dic2[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    TiaoXiu_listModel  *model =[TiaoXiu_listModel mj_objectWithKeyValues:tarr[i]];
                    [arr_list addObject:model];
                }
                  
                    [tableV reloadData];
            
            }
            }
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
        }];
        
    }else
    {
    [WebRequest Get_Off_ByCheckerWithcompanyId:user.companyId userGuid:user.Guid page:page_number type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
        NSDictionary *dic2 =dic[Y_ITEMS];
        page_number =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
       
            for (int i=0; i<tarr.count; i++) {
                TiaoXiu_listModel  *model =[TiaoXiu_listModel mj_objectWithKeyValues:tarr[i]];
                [arr_list addObject:model];
            }
                   
                  [tableV reloadData];
        }
        }
      
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
    }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"调休申请列表";
    arr_list =[NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
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
    return arr_list.count ;
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
    TiaoXiu_listModel *model=arr_list[indexPath.row];
    TX_DetailViewController *dvc =[[TX_DetailViewController alloc]init];
    dvc.isShenPi =segmentC.selectedSegmentIndex+1;
    dvc.model =model;
    dvc.isRenShi =self.isRenShi;
    [self.navigationController pushViewController:dvc animated:NO];
}




@end
