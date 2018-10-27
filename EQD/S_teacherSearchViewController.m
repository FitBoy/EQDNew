//
//  S_teacherSearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 推荐的  最新的 搜索的

#import "S_teacherSearchViewController.h"
#import "FBHeadScrollTitleView.h"
#import "EQD_SearchAllViewController.h"
#import "eQDS_teacherAndSearchModel.h"
#import "EQDS_teacherInfoModel.h"
#import "FBimage_name_text_btnTableViewCell.h"
#import "CK_CKPersonZoneViewController.h"
@interface S_teacherSearchViewController ()<UITableViewDelegate,UITableViewDataSource,FBHeadScrollTitleViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model_tuijian;
    NSMutableArray *arr_model_new;
    NSMutableArray *arr_model_hot;
    NSMutableArray *arr_model_active;
    
    NSInteger temp;
    NSString *page3;
    NSString *page2;
    
}

@end

@implementation S_teacherSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    switch (temp) {
        case 0:
        {
           //讲师推荐
            [WebRequest Lectures_recommend_Get_LectureRecommendWithtype:@"0" And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshingWithNoMoreData];
                [arr_model_tuijian removeAllObjects];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    for (int i=0; i<tarr.count; i++) {
                        eQDS_teacherAndSearchModel  *model = [eQDS_teacherAndSearchModel mj_objectWithKeyValues:tarr[i]];
                        model.cell_height =60;
                        [arr_model_tuijian addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
        }
            break;
            case 1:
        {
            //热门讲师
            [WebRequest Lectures_recommend_Get_LectureRecommendWithtype:@"1" And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshingWithNoMoreData];
                [arr_model_hot removeAllObjects];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    for (int i=0; i<tarr.count; i++) {
                        eQDS_teacherAndSearchModel  *model = [eQDS_teacherAndSearchModel mj_objectWithKeyValues:tarr[i]];
                        model.cell_height =60;
                        [arr_model_hot addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
        }
            break;
        case 2:
        {
            //活跃讲师
            [WebRequest Makerspacey_MakerArticle_Get_ActiveMakerWithpage:@"0" And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    [arr_model_active removeAllObjects];
                    page2 = dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        EQDS_teacherInfoModel *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                        model.cellHeight =60;
                        [arr_model_active addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
        }
            break;
            case 3:
        {
            ///最新的讲师
            [WebRequest Makerspacey_Get_LectureByCheckTimeWithpage:@"0" And:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    page3 = dic[@"page"];
                    [arr_model_new removeAllObjects];
                    for(int i=0;i<tarr.count;i++)
                    {
                        EQDS_teacherInfoModel *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                        model.cellHeight =60;
                        [arr_model_new addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
        }
            break;
            
        default:
            break;
    }
}
-(void)loadMoreData{
    if (temp ==3) {
        [WebRequest Makerspacey_Get_LectureByCheckTimeWithpage:page3 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page3 = dic[@"page"];
                for(int i=0;i<tarr.count;i++)
                {
                    EQDS_teacherInfoModel *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model_new addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (temp ==2)
    {
        [WebRequest Makerspacey_MakerArticle_Get_ActiveMakerWithpage:page2 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page2 = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_teacherInfoModel *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model_active addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }
    else
    {
        [tableV.mj_footer endRefreshingWithNoMoreData];
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)getSelectedIndex:(NSInteger)index
{
    temp = index;
    [self setFooter];
    switch (index) {
        case 0:
        {
            //讲师推荐
            if (arr_model_tuijian.count ==0) {
                [self loadRequestData];
            }
            [tableV reloadData];
        }
            break;
            
        case 1:
        {
           //热门讲师
            if (arr_model_hot.count ==0) {
                [self loadRequestData];
            }
            [tableV reloadData];
        }
            break;
        case 2:
        {
            //活跃讲师
            if (arr_model_active.count==0) {
                [self loadRequestData];
            }
            [tableV reloadData];
        }
            break;
        case 3:
        {
            //最新讲师
            if (arr_model_new.count ==0) {
                [self loadRequestData];
            }
            [tableV reloadData];
        }
            break;
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找讲师";
    arr_model_new = [NSMutableArray arrayWithCapacity:0];
    arr_model_tuijian = [NSMutableArray arrayWithCapacity:0];
    arr_model_hot = [NSMutableArray arrayWithCapacity:0];
    arr_model_active = [NSMutableArray arrayWithCapacity:0];
    page2 = @"0";
    page3 = @"0";
    ///分类
    FBHeadScrollTitleView  *headS  =[[FBHeadScrollTitleView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    headS.delegate_head = self;
    [headS setArr_titles:@[@"讲师推荐",@"热门讲师",@"活跃讲师",@"最新讲师"]];
    [self.view addSubview:headS];
    [headS setClickTapIndex:0];
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    [self setFooter];
    
///搜索
    UIBarButtonItem *rightsearch = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItem:rightsearch];
    

}
-(void)setFooter{
    if (temp ==0 || temp ==1) {
        tableV.mj_footer = nil;
    }else
    {
        tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
}
-(void)searchClick
{
    EQD_SearchAllViewController *Svc = [[EQD_SearchAllViewController alloc]init];
    Svc.temp0 = 0;
    [self.navigationController pushViewController:Svc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(temp ==0 )
    {
        return arr_model_tuijian.count;
    }else if (temp == 1)
    {
        return arr_model_hot.count;
    }else if (temp == 2)
    {
        return arr_model_active.count;
    }else if (temp ==3)
    {
        return arr_model_new.count;
    }
    else{
    return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(temp ==0 )
    {
        eQDS_teacherAndSearchModel  *model = arr_model_tuijian[indexPath.row];
        return model.cell_height;
    }else if (temp == 1)
    {
        eQDS_teacherAndSearchModel  *model = arr_model_hot[indexPath.row];
        return model.cell_height;
        
    }else if (temp ==2)
    {
        EQDS_teacherInfoModel *model = arr_model_active[indexPath.row];
        return model.cellHeight;
    }
    else if (temp == 3)
    {
        EQDS_teacherInfoModel *model = arr_model_new[indexPath.row];
        
        return model.cellHeight;
    }else{
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (temp ==0) {
        ///推荐讲师
        static NSString *cellId=@"cellID0";
        FBimage_name_text_btnTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBimage_name_text_btnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        eQDS_teacherAndSearchModel  *model = arr_model_tuijian[indexPath.row];
        [cell setModel_teacher:model];
        return cell;
    }else if(temp ==1)
    {
        ///热门讲师
        static NSString *cellId=@"cellID1";
        FBimage_name_text_btnTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBimage_name_text_btnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        eQDS_teacherAndSearchModel *model = arr_model_hot[indexPath.row];
        [cell setModel_teacher:model];
        return cell;
    }else if (temp ==2)
    {
        static NSString *cellId=@"cellID2";
        FBimage_name_text_btnTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBimage_name_text_btnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        EQDS_teacherInfoModel *model = arr_model_active[indexPath.row];
        [cell setModel_info:model];
        
        return cell;
    }else if (temp ==3)
    {
        static NSString *cellId=@"cellID3";
        FBimage_name_text_btnTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBimage_name_text_btnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        EQDS_teacherInfoModel *model = arr_model_new[indexPath.row];
        [cell setModel_info:model];
        
        return cell;
    }
    else
    {
        return nil;
    }
  
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (temp) {
        case 0:
        {
            eQDS_teacherAndSearchModel  *model = arr_model_tuijian[indexPath.row];
            
            CK_CKPersonZoneViewController *Pvc = [[CK_CKPersonZoneViewController alloc]init];
            Pvc.userGuid = model.lectureGuid;
            [self.navigationController pushViewController:Pvc animated:NO];
        }
            break;
        case 1:
        {
            eQDS_teacherAndSearchModel  *model = arr_model_hot[indexPath.row];
            
            CK_CKPersonZoneViewController *Pvc = [[CK_CKPersonZoneViewController alloc]init];
            Pvc.userGuid = model.lectureGuid;
            [self.navigationController pushViewController:Pvc animated:NO];
        }
            break;
            case 2:
        {
            EQDS_teacherInfoModel *model = arr_model_active[indexPath.row];
            CK_CKPersonZoneViewController *Pvc = [[CK_CKPersonZoneViewController alloc]init];
            Pvc.userGuid = model.userGuid;
            [self.navigationController pushViewController:Pvc animated:NO];
        }
            break;
        case 3:
        {
            EQDS_teacherInfoModel *model = arr_model_new[indexPath.row];
            CK_CKPersonZoneViewController *Pvc = [[CK_CKPersonZoneViewController alloc]init];
            Pvc.userGuid = model.userGuid;
            [self.navigationController pushViewController:Pvc animated:NO];
        }
            break;
            
        default:
            break;
    }
    
}





@end
