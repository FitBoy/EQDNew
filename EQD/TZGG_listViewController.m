//
//  TZGG_listViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TZGG_listViewController.h"
#import "LLBook_OtherDetailViewController.h"
#import "FBFour_noimgTableViewCell.h"

@interface TZGG_listViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentC;
    UserModel *user;
    NSMutableArray *arr_model;
    NSString *page;
}

@end

@implementation TZGG_listViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    
    [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"210" And:^(NSDictionary *dic) {
        
    }];
    [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"220" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    if (segmentC.selectedSegmentIndex==0) {
        
        [WebRequest Newss_Get_News_ByAllWithcompanyId:user.companyId departId:user.departId page:@"0" And:^(NSDictionary *dic) {
            [arr_model removeAllObjects];
            NSDictionary *dic1 =dic[Y_ITEMS];
            NSArray *tarr =dic1[@"list"];
            page =dic1[@"page"];
            for ( int i=0; i<tarr.count; i++) {
                GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];

        }];
        
        
    }else
    {
        /// 公告
    [WebRequest Notices_Get_Notice_ByAllWithcompanyId:user.companyId departId:user.departId page:@"0" And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSDictionary *dic1 =dic[Y_ITEMS];
        NSArray *tarr =dic1[@"list"];
        page =dic1[@"page"];
        for ( int i=0; i<tarr.count; i++) {
            GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
    }];
    }
    
}
-(void)loadOtherData
{
    if (segmentC.selectedSegmentIndex==0) {
        
        [WebRequest Newss_Get_News_ByAllWithcompanyId:user.companyId departId:user.departId page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                
            NSDictionary *dic1 =dic[Y_ITEMS];
            NSArray *tarr =dic1[@"list"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
            page =dic1[@"page"];
            for ( int i=0; i<tarr.count; i++) {
                GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            
            [tableV reloadData];
                }
            }
            
        }];
        
        
    }else
    {
        /// 公告
        [WebRequest Notices_Get_Notice_ByAllWithcompanyId:user.companyId departId:user.departId page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic1 =dic[Y_ITEMS];
            NSArray *tarr =dic1[@"list"];
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
            page =dic1[@"page"];
            for ( int i=0; i<tarr.count; i++) {
                GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
           
            [tableV reloadData];
                }
            }
        }];
         }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page=@"0";
    self.navigationItem.title =@"通知-公告";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"通知",@"公告"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
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
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    GongGao_ListModel *model =arr_model[indexPath.row];
    
    cell.L_left0.text =[NSString stringWithFormat:@"%@",model.name];
    cell.L_left1.text =[NSString stringWithFormat:@"主题:%@",model.theme];
    cell.L_right1.text =model.createTime;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongGao_ListModel *model =arr_model[indexPath.row];
    LLBook_OtherDetailViewController *Dvc =[[LLBook_OtherDetailViewController alloc]init];
    Dvc.isLianLuoBook =segmentC.selectedSegmentIndex+1;
    Dvc.model_TG = model;
    [self.navigationController pushViewController:Dvc animated:NO];
    
}



@end
