//
//  GongGao_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GongGao_ListViewController.h"
#import "GongGao_DetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
@interface GongGao_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
}

@end

@implementation GongGao_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString *code =self.ischeker==1?@"211":@"0";
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    if (self.ischeker==1) {
        [WebRequest Notices_Get_Notice_ByCheckerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
            [arr_model removeAllObjects];
            NSDictionary *dic2 =dic[Y_ITEMS];
            page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
            for (int i=0; i<tarr.count; i++) {
                GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        }];
        
    }
    else
    {
    
    
    [WebRequest Notices_Get_Notice_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        for (int i=0; i<tarr.count; i++) {
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
    
    if (self.ischeker==1) {
        [WebRequest Notices_Get_Notice_ByCheckerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                
            NSDictionary *dic2 =dic[Y_ITEMS];
            page =dic2[@"page"];
            NSArray *tarr =dic2[@"list"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
            for (int i=0; i<tarr.count; i++) {
                GongGao_ListModel *model =[GongGao_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
           
            [tableV reloadData];
                }
            }
        }];
        
    }
    else
    {

    [WebRequest Notices_Get_Notice_ByCreaterWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] companyId:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
        
        NSDictionary *dic2 =dic[Y_ITEMS];
       
        NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                 page =dic2[@"page"];
        for (int i=0; i<tarr.count; i++) {
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
    arr_model =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    page =@"0";
    adjustsScrollViewInsets_NO(tableV, self);
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"待审批",@"已同意",@"已拒绝"]];
    
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.title =@"发布的公告";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
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
    cell.L_left0.text =[NSString stringWithFormat:@"公告名称:%@",model.name];
    NSLog(@"时间%@",model .createTime);
     cell.L_right1.text = model .createTime;
    cell.L_left1.text =[NSString stringWithFormat:@"主题:%@",model.theme];
   
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongGao_ListModel *model =arr_model[indexPath.row];
    GongGao_DetailViewController *Dvc =[[GongGao_DetailViewController alloc]init];
    Dvc.model =model;
    if(segmentC.selectedSegmentIndex==0 && self.ischeker==1)
    {
        Dvc.isShenpi=1;
    }else
    {
        Dvc.isShenpi=0;
    }
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
