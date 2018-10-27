//
//  S_NeedSearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "S_NeedSearchViewController.h"
#import "FBHeadScrollTitleView.h"
#import "PXNeedModel.h"
#import "EQDR_labelTableViewCell.h"
#import "EQD_SearchAllViewController.h"
#import "PXNeedDetailViewController.h"
@interface S_NeedSearchViewController ()<UITableViewDelegate,UITableViewDataSource,FBHeadScrollTitleViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_tuijian;
    NSMutableArray *arr_new;
    NSString *page;
    NSString *page1;
    FBHeadScrollTitleView *headScroll;
    NSInteger temp;
    UserModel  *user;
}

@end

@implementation S_NeedSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
/*
 {
 "Id": 1,
 "companyId": 46,
 "thecategory": "引导技术,课程开发",
 "thetheme": "思维导图",
 "thedateStart": "2018/8/1",
 "thedateEnd": "2018/9/1",
 "company": "郑州易企点",
 "theplace": "河南省郑州市",
 "createTime": "2018-08-28 10:00:46"
 }
 
 
 */
-(void)loadRequestData{
    if(temp ==0)
    {
        //需求匹配
        [WebRequest Training_TrainingMatch_Get_LectureTrainMatchWithlectureGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page = dic[@"page"];
                [arr_tuijian  removeAllObjects];
                for(int i=0;i<tarr.count;i++)
                {
                    PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight = 60;
                    [arr_tuijian addObject:model];
                }
                [tableV reloadData];
            }
            
        }];
        
    }else
    {
        //最新需求
        [WebRequest Training_Trains_Get_TrainingByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_new  removeAllObjects];
                page1 = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_new addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
    }
}
-(void)loadMoreData{
    if(temp ==0)
    {
        //需求匹配
        [WebRequest Training_TrainingMatch_Get_LectureTrainMatchWithlectureGuid:user.Guid page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = dic[@"page"];
                for(int i=0;i<tarr.count;i++)
                {
                    PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight = 60;
                    [arr_tuijian addObject:model];
                }
                [tableV reloadData];
                }
            }
            
        }];
        
    }else
    {
        //最新需求
        [WebRequest Training_Trains_Get_TrainingByTimeWithpage:page1 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page1 = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_new addObject:model];
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
    self.navigationItem.title = @"需求";
    user = [WebRequest GetUserInfo];
    arr_tuijian = [NSMutableArray   arrayWithCapacity:0];
    arr_new = [NSMutableArray arrayWithCapacity:0];
    page = @"0";
    temp = 0;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    [self setFooter];
    headScroll = [[FBHeadScrollTitleView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    headScroll.delegate_head = self;
    [headScroll setArr_titles:@[@"需求匹配",@"最新需求"]];
    [self.view addSubview:headScroll];
    [self loadRequestData];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchNeedCLick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)searchNeedCLick{
    EQD_SearchAllViewController *Avc = [[EQD_SearchAllViewController alloc]init];
    Avc.temp0 =2;
    [self.navigationController pushViewController:Avc animated:NO];
}
-(void)getSelectedIndex:(NSInteger)index
{
    temp = index;
    switch (index) {
        case 0:
        {
            if (arr_tuijian.count ==0) {
                [self loadRequestData];
            }
            [tableV reloadData];
        }
            break;
            
        case 1:
        {
            if (arr_new.count==0) {
                [self loadRequestData];
            }
            [tableV reloadData];
        }
            break;
            
        default:
            break;
    }
}
-(void)setFooter{
  
        tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return temp == 0? arr_tuijian.count:arr_new.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (temp ==0) {
        static NSString *cellId=@"cellID0";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        PXNeedModel *model =arr_tuijian[indexPath.row];
        [cell setModel_need2:model];
        
        
        return cell;
    }else
    {
    
    static NSString *cellId=@"cellID1";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        PXNeedModel  *model =arr_new[indexPath.row];
        [cell setModel_need2:model];
    return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (temp ==0) {
        PXNeedModel  *model = arr_tuijian[indexPath.row];
        return model.cellHeight;
    }else
    {
        PXNeedModel *model = arr_new[indexPath.row];
        return model.cellHeight;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (temp ==0) {
        PXNeedModel *model =arr_tuijian[indexPath.row];
        PXNeedDetailViewController *dvc=[[PXNeedDetailViewController alloc]init];
        dvc.Id = model.Id;
        [self.navigationController pushViewController:dvc animated:NO];
    }else
    {
        PXNeedModel *model = arr_new[indexPath.row];
        PXNeedDetailViewController *dvc=[[PXNeedDetailViewController alloc]init];
        dvc.Id = model.Id;
        [self.navigationController pushViewController:dvc animated:NO];
    }
}




@end
