//
//  PZLiZhiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZLiZhiViewController.h"
#import "FBThree_noimg122TableViewCell.h"
#import "LZLDetailViewController.h"

@interface PZLiZhiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_shenpi;
    UserModel *user;
    UISegmentedControl *segmentC;
    NSString *page;
}

@end

@implementation PZLiZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    NSString *code =self.isrenshi==2?@"301":@"300";
   
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:code And:^(NSDictionary *dic) {
        
    }];

}
-(void)loadRequestData{
   if(self.isrenshi==2)
   {
       [WebRequest  Quit_Get_Quit_ByHRWithcompanyId:user.companyId userGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
           if ([dic[Y_STATUS] integerValue]==200) {
               [arr_shenpi removeAllObjects];
               NSDictionary *dic1 =dic[Y_ITEMS];
               page =dic1[@"page"];
               
               NSArray *tarr = dic1[@"list"];
               for (int i=0; i<tarr.count; i++) {
                   LiZhiModel  *model =[LiZhiModel mj_objectWithKeyValues:tarr[i]];
                   [arr_shenpi addObject:model];
               }
               [tableV reloadData];
           }
           [tableV.mj_header endRefreshing];
           [tableV.mj_footer endRefreshing];
       }];
   }else
   {
    [WebRequest User_GetQuitRecord_ListWithcompanyId:user.companyId userGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_shenpi removeAllObjects];
            NSDictionary *dic1 =dic[Y_ITEMS];
            page =dic1[@"page"];
            
            NSArray *tarr = dic1[@"list"];
            for (int i=0; i<tarr.count; i++) {
                LiZhiModel  *model =[LiZhiModel mj_objectWithKeyValues:tarr[i]];
                [arr_shenpi addObject:model];
            }
            [tableV reloadData];
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
    }];
 
   }
}
-(void)loadOtherData
{
    if (self.isrenshi==2) {
        [WebRequest Quit_Get_Quit_ByHRWithcompanyId:user.companyId userGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *dic1 =dic[Y_ITEMS];
               
                
                NSArray *tarr = dic1[@"list"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                     page =dic1[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    LiZhiModel  *model =[LiZhiModel mj_objectWithKeyValues:tarr[i]];
                    [arr_shenpi addObject:model];
                }
                    
                [tableV reloadData];
                }
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
        }];
    }else
    {
    [WebRequest User_GetQuitRecord_ListWithcompanyId:user.companyId userGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] page:page And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic1 =dic[Y_ITEMS];
            page =dic1[@"page"];
            
            NSArray *tarr = dic1[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                LiZhiModel  *model =[LiZhiModel mj_objectWithKeyValues:tarr[i]];
                [arr_shenpi addObject:model];
            }
            [tableV reloadData];
            }
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
    }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"离职审批";
    arr_shenpi =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"审批中",@"已通过",@"未通过"]];
    [self.view addSubview:segmentC];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    page =@"0";
    
   }

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_shenpi.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBThree_noimg122TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBThree_noimg122TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    LiZhiModel *model =arr_shenpi[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiZhiModel *model =arr_shenpi[indexPath.row];
    LZLDetailViewController *Dvc =[[LZLDetailViewController alloc]init];
    Dvc.model =model;
    if (segmentC.selectedSegmentIndex==0) {
        if (self.isrenshi==2) {
            Dvc.isshenpi =2;
        }else
        {
            Dvc.isshenpi =1;
        }
        
    }else
    {
        Dvc.isshenpi =0;
    }
   
    [self.navigationController pushViewController:Dvc animated:NO];
    
}



@end
