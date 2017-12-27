//
//  SQLiZhiListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQLiZhiListViewController.h"
#import "FBThree_noimg122TableViewCell.h"
#import "LZLDetailViewController.h"
@interface SQLiZhiListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UISegmentedControl *segmentControl;
    NSMutableArray *arr_lizhiList;
    UserModel *user;
    NSString *page;
}

@end

@implementation SQLiZhiListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"302" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    [WebRequest  User_MyQuitInfoWithcompanyId:user.companyId userGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentControl.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_lizhiList removeAllObjects];
            NSDictionary *dic1 = dic[Y_ITEMS];
            page = dic1[@"page"];
            NSArray *tarr = dic1[@"list"];
            for(int i=0;i<tarr.count;i++)
            {
                LiZhiModel *model =[LiZhiModel mj_objectWithKeyValues:tarr[i]];
                [arr_lizhiList  addObject:model];
            }
            [tableV reloadData];
           
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        
    }];
    
}
-(void)loadOtherData
{
    [WebRequest  User_MyQuitInfoWithcompanyId:user.companyId userGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentControl.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic1 = dic[Y_ITEMS];
            
            NSArray *tarr = dic1[@"list"];
            if(tarr.count==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page = dic1[@"page"];
            for(int i=0;i<tarr.count;i++)
            {
                LiZhiModel *model =[LiZhiModel mj_objectWithKeyValues:tarr[i]];
                [arr_lizhiList  addObject:model];
            }
            [tableV reloadData];
            
            }
        }
      
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"离职申请列表";
    user =[WebRequest GetUserInfo];
    page =@"0";
    arr_lizhiList =[NSMutableArray arrayWithCapacity:0];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"申请中",@"已通过",@"未通过"]];
    segmentControl.frame = CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    [self.view addSubview:segmentControl];
    segmentControl.selectedSegmentIndex=0;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(RightaddClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    [segmentControl addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    
    
   
}
-(void)chooseClick
{
    [self loadRequestData];
}
-(void)RightaddClick
{
    //添加离职申请
    SQLiZhiViewController *LZvc =[[SQLiZhiViewController alloc]init];
    [self.navigationController pushViewController:LZvc animated:NO];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_lizhiList.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBThree_noimg122TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBThree_noimg122TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    LiZhiModel *model =arr_lizhiList[indexPath.row];
    [cell setModel:model];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiZhiModel *model =arr_lizhiList[indexPath.row];
    LZLDetailViewController *Dvc =[[LZLDetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
