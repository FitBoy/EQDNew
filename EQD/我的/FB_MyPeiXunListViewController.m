//
//  FB_MyPeiXunListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_MyPeiXunListViewController.h"
#import "FB_My_PeiXunAddViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "FB_PeiXun_ListModel.h"
#import "FB_MyPXSQ_DetailViewController.h"
@interface FB_MyPeiXunListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    UISegmentedControl  *segmentC;
    NSString *page;
}

@end

@implementation FB_MyPeiXunListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    if(self.isRenshi==2)
    {
        [WebRequest  Training_Get_trainingApply_byLeaderWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeAllObjects];
                NSArray *tarr = dic[Y_ITEMS];
                page =dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    FB_PeiXun_ListModel  *model =[FB_PeiXun_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
        
    }else if (self.isRenshi==1)
    {
        [WebRequest Training_Get_trainingApply_byHRWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeAllObjects];
                NSArray *tarr = dic[Y_ITEMS];
                page =dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    FB_PeiXun_ListModel  *model =[FB_PeiXun_ListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }
    else
    {
    [WebRequest Training_Get_trainingApply_OwnerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            page =dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                FB_PeiXun_ListModel  *model =[FB_PeiXun_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }
    
}
-(void)loadOtherData{
    if (self.isRenshi==2) {
        [WebRequest  Training_Get_trainingApply_byLeaderWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page =dic[@"nextpage"];
                    for (int i=0; i<tarr.count; i++) {
                        FB_PeiXun_ListModel  *model =[FB_PeiXun_ListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
    }else if (self.isRenshi==1)
    {
        [WebRequest Training_Get_trainingApply_byHRWithuserGuid:user.Guid comid:user.companyId type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page =dic[@"nextpage"];
                    for (int i=0; i<tarr.count; i++) {
                        FB_PeiXun_ListModel  *model =[FB_PeiXun_ListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
    }else
    {
    [WebRequest Training_Get_trainingApply_OwnerWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page =dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                FB_PeiXun_ListModel  *model =[FB_PeiXun_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page =@"0";
    self.navigationItem.title =@"培训申请列表";
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批"]];
    segmentC.frame =CGRectMake(0,DEVICE_HEIGHT-40-kBottomSafeHeight, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];

}

-(void)rightCLick
{
    FB_My_PeiXunAddViewController  *Avc =[[FB_My_PeiXunAddViewController alloc]init];
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
    FB_PeiXun_ListModel  *model = arr_model[indexPath.row];
    cell.L_left0.text = model.theTheme;
    cell.L_left1.text = [NSString stringWithFormat:@"申请培训时间段:%@ ~ %@",model.thedateStart,model.thedateEnd];
    if([model.status integerValue] ==1)
    {
        cell.L_right1.text = @"等待人事审批";
        
    }else if ([model.status integerValue]==2)
    {
        cell.L_right1.text = @"已同意";
    }
    else if ([model.status integerValue]==-1)
    {
        cell.L_right1.text = @"已拒绝";
    }else
    {
        cell.L_right1.text = @"未审批";
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FB_PeiXun_ListModel  *model = arr_model[indexPath.row];
    FB_MyPXSQ_DetailViewController  *Dvc = [[FB_MyPXSQ_DetailViewController alloc]init];
    Dvc.ID = model.ID;
    if (segmentC.selectedSegmentIndex==0 && self.isRenshi==2) {
        Dvc.isRenshi = 2;
    }else if (segmentC.selectedSegmentIndex==0 && self.isRenshi==1)
    {
        Dvc.isRenshi =1;
    }
    else
    {
        Dvc.isRenshi =0;
    }
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
