//
//  TongZhi_listViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TongZhi_listViewController.h"
#import "TongZhi_addViewController.h"
#import "TongZhi_DetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
@interface TongZhi_listViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
}

@end

@implementation TongZhi_listViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString *code = self.isShenPi==1?@"221":@"222";
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    
    if(self.isShenPi==1)
    {
        [WebRequest Newss_Get_News_ByCheckerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
            [arr_model removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            NSArray *tarr =dic2[@"list"];
            page =dic2[@"page"];
            for (int i=0; i<tarr.count; i++) {
                GongGao_ListModel  *model = [GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        }];
        
        
    }else
    {
    
    [WebRequest Newss_Get_News_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        NSArray *tarr =dic2[@"list"];
        page =dic2[@"page"];
        for (int i=0; i<tarr.count; i++) {
            GongGao_ListModel  *model = [GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
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
    if (self.isShenPi==1) {
        
        [WebRequest Newss_Get_News_ByCheckerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page And:^(NSDictionary *dic) {
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
            page =dic2[@"page"];
            for (int i=0; i<tarr.count; i++) {
                GongGao_ListModel  *model = [GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
           
          
            [tableV reloadData];
                }
                
            }
        }];
        
    }else
    {
    
    [WebRequest Newss_Get_News_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            
        NSDictionary *dic2 =dic[Y_ITEMS];
        NSArray *tarr =dic2[@"list"];
            if(tarr.count==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
        page =dic2[@"page"];
        for (int i=0; i<tarr.count; i++) {
            GongGao_ListModel  *model = [GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
       
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
            }
             [tableV.mj_header endRefreshing];
        }
    }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page =@"0";
    self.navigationItem.title =@"通知列表";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"待审核",@"已同意",@"已拒绝"]];
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
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)addClick
{
    //添加通知
    TongZhi_addViewController  *Avc =[[TongZhi_addViewController alloc]init];
    
    [self.navigationController pushViewController:Avc animated:NO];
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
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    GongGao_ListModel *model =arr_model[indexPath.row];
    cell.L_left0.text =[NSString stringWithFormat:@"通知名称:%@",model.name];
    cell.L_left1.text =[NSString stringWithFormat:@"主题:%@",model.theme];
    cell.L_right1.text =model.createTime;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongGao_ListModel *model =arr_model[indexPath.row];
    TongZhi_DetailViewController *Dvc =[[TongZhi_DetailViewController alloc]init];
    if (segmentC.selectedSegmentIndex==0&& self.isShenPi==1) {
        Dvc.isShenpi=1;
    }
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
