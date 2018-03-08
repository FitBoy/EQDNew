//
//  EQDS_appViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_TYPE_IPAD  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#import "EQDS_appViewController.h"
#import "FBHeadScrollTitleView.h"
#import <Masonry.h>
#import "EQD_SearchAllViewController.h"
#import "EQDS_myViewController.h"
#import "EQDS_AddArticleViewController.h"
#import "EQDS_addVideoViewController.h"
#import "EQDS_addCourseViewController.h"
#import "eQDS_teacherAndSearchModel.h"
#import "EQDS_TeacherTableViewCell.h"
#import "PX_courseManageModel.h"
#import "EQDR_labelTableViewCell.h"
#import "EQDS_VideoModel.h"
#import "EQDS_VideoTableViewCell.h"
#import "EQDS_articleModel.h"
#import "EQDR_ArticleTableViewCell.h"
#import "EQDS_CourseModel.h"
#import "EQDS_searchHighViewController.h"
#import "EQDS_ArticleDetailViewController.h"
#import "PlayerViewController.h"
#import "PorxyNavigationController.h"
#import "EQDS_CourseDetailViewController.h"
@interface EQDS_appViewController ()<FBHeadScrollTitleViewDelegate,UITableViewDelegate,UITableViewDataSource,EQDS_TeacherTableViewCellDelegate,EQDR_labelTableViewCellDelegate,EQDS_VideoTableViewCellDelegate,EQDR_ArticleTableViewCellDelegate>
{
    UIScrollView  *ScrollView;
    UserModel *user;
    NSMutableArray *arr_tableV;
    NSInteger temp;
    FBHeadScrollTitleView  *titleView ;
//    NSMutableArray *arr_bool;
    NSMutableArray *arr_model1;
    NSMutableArray *arr_model2;
    NSMutableArray *arr_model3;
    NSMutableArray *arr_model4;
    NSMutableArray *arr_model00;
    NSMutableArray *arr_model01;
    NSMutableArray *arr_model02;
    NSString *page0;
    NSString *page1;
    NSString *page2;
    NSString *page3;
    NSString *page4;
    
}

@end

@implementation EQDS_appViewController
#pragma  mark - 推荐讲师
-(void)getlable:(NSString *)label Withmodel:(id)model
{
    EQDS_searchHighViewController *Hvc =[[EQDS_searchHighViewController alloc]init];
    Hvc.temp =0;
    Hvc.searchKey = label;
    [self.navigationController pushViewController:Hvc animated:NO];
}
#pragma  mark - 课程
-(void)getTapTypeWithtype:(NSString *)type model:(id)model
{
    EQDS_searchHighViewController *Hvc =[[EQDS_searchHighViewController alloc]init];
    Hvc.temp =1;
    Hvc.searchKey = type;
    [self.navigationController pushViewController:Hvc animated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    UITableView *tableV = arr_tableV[temp];
    if (temp==0) {
        //首页
        [WebRequest Lectures_recommend_Get_LectureRecommendAnd:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshingWithNoMoreData];
            [arr_model00 removeAllObjects];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    eQDS_teacherAndSearchModel  *model = [eQDS_teacherAndSearchModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model00 addObject:model];
                }
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        [WebRequest Lectures_video_Get_LectureVideo_RecommendAnd:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model01 removeAllObjects];
                for ( int i=0; i<tarr.count; i++) {
                    EQDS_VideoModel *model =[EQDS_VideoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model01 addObject:model];
                }
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
       
        [WebRequest Lectures_course_Get_LectCourse_ByRecommendAnd:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model02 removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_CourseModel  *model = [EQDS_CourseModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model02 addObject:model];
                }
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        
    }else if (temp==1)
    {
    //推荐讲师
            [WebRequest Lectures_recommend_Get_LectureRecommendAnd:^(NSDictionary *dic) {
                [tableV.mj_header endRefreshing];
                [tableV.mj_footer endRefreshingWithNoMoreData];
                [arr_model1 removeAllObjects];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr = dic[Y_ITEMS];
                    for (int i=0; i<tarr.count; i++) {
                        eQDS_teacherAndSearchModel  *model = [eQDS_teacherAndSearchModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model1 addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
    }else if (temp==2)
    {
        //看课程
        [WebRequest Lectures_course_Get_LectureCourse_ByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model2 removeAllObjects];
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                page2 = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PX_courseManageModel *model = [PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model2 addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (temp==3)
    {
        //品视频
        [WebRequest Lectures_video_Get_LectureVideo_ByTimeWithPage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic =dic[Y_ITEMS];
                page3 =tdic[@"page"];
                NSArray *tarr = tdic[@"rows"];
                [arr_model3 removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_VideoModel *model =[EQDS_VideoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model3 addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
    }else if (temp==4)
    {
        //评文章
        [WebRequest Lectures_article_Get_LectureArticle_ByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                [arr_model4 removeAllObjects];
                page4 = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel  *model = [EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model4 addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else
    {
        
    }
}
-(void)loadOtherData{
    UITableView *tableV = arr_tableV[temp];
    if (temp==0) {
        //首页
    }else if (temp==1)
    {
       
    }else if (temp==2)
    {
        //看课程
        [WebRequest Lectures_course_Get_LectureCourse_ByTimeWithpage:page2 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if (tarr.count==0) {
                    [tableV.mj_footer  endRefreshingWithNoMoreData];
                }else
                {
                page2 = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PX_courseManageModel *model = [PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model2 addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (temp==3)
    {
        //品视频
        [WebRequest Lectures_video_Get_LectureVideo_ByTimeWithPage:page3 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic =dic[Y_ITEMS];
                
                NSArray *tarr = tdic[@"rows"];
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                   page3 =tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_VideoModel *model =[EQDS_VideoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model3 addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (temp==4)
    {
        //评文章
        [WebRequest Lectures_article_Get_LectureArticle_ByTimeWithpage:page4 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page4 = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel  *model = [EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model4 addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else
    {
        
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model1 = [NSMutableArray arrayWithCapacity:0];
    arr_model00 =[NSMutableArray arrayWithCapacity:0];
    arr_model01 = [NSMutableArray arrayWithCapacity:0];
    arr_model02 = [NSMutableArray arrayWithCapacity:0];
    arr_model2 = [NSMutableArray arrayWithCapacity:0];;
    arr_model3 = [NSMutableArray arrayWithCapacity:0];;
    arr_model4 = [NSMutableArray arrayWithCapacity:0];
    page0=@"0";
    page1=@"0";
    page2=@"0";
    page3=@"0";
    page4=@"0";
    temp =0;
    arr_tableV = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"易企学";
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClcik)];
    [self.navigationItem setLeftBarButtonItem:left];
    titleView = [[FBHeadScrollTitleView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    titleView.delegate_head =self;
    [titleView setArr_titles:@[@"首页",@"推荐讲师",@"最新课程",@"最新视频",@"最新文章"]];
    [self.view addSubview:titleView];
  
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItems:@[right,right1]];
    [self getTeacherinfo];
    [self setScrollViewWithCount:5];
   
}
-(void)setScrollViewWithCount:(NSInteger)count{
    float height_scroll = DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40;
    ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, height_scroll)];
    [self.view addSubview:ScrollView];
    ScrollView.delegate =self;
    ScrollView.contentSize = CGSizeMake(DEVICE_WIDTH*count,height_scroll);
    ScrollView.showsHorizontalScrollIndicator =NO;
    adjustsScrollViewInsets_NO(ScrollView, self);
    ScrollView.pagingEnabled =NO;
    for (int i=0; i<count; i++) {
        UITableView *tableV =nil;
        if (i==0) {
            tableV =  [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*i, 0, DEVICE_WIDTH, height_scroll) style:UITableViewStyleGrouped];
            tableV.contentInset= UIEdgeInsetsMake(15, 0, 0, 0);
        }else
        {
            tableV= [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*i, 0, DEVICE_WIDTH, height_scroll) style:UITableViewStylePlain];
        }
       
        tableV.delegate=self;
        tableV.dataSource=self;
        tableV.rowHeight=60;
      
        
        if (i>1) {
            tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
            tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
        }
        
        [arr_tableV addObject:tableV];
        [ScrollView addSubview:tableV];
    }
    
}
#pragma  mark - 点击视频上的分类
-(void)getlabel:(NSString *)label WithModel:(id)model
{
    EQDS_searchHighViewController  *Hvc =[[EQDS_searchHighViewController alloc]init];
    Hvc.temp =2;
    Hvc.searchKey =label;
    [self.navigationController pushViewController:Hvc animated:NO];
}
#pragma  mark - 点击文章的类别
-(void)getLabel:(NSString *)label model:(id)model
{
    EQDS_searchHighViewController  *Hvc =[[EQDS_searchHighViewController alloc]init];
    Hvc.temp =3;
    Hvc.searchKey =label;
    [self.navigationController pushViewController:Hvc animated:NO];
}
#pragma  mark - + 添加功能
-(void)tianjiaCLick{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    NSArray *tarr = @[@"个人中心",@"添加课程",@"添加视频",@"添加文章"];
    for (int i=0; i<tarr.count; i++) {
        [alert  addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (i==0) {
                //个人中心
                EQDS_myViewController  *Mvc =[[EQDS_myViewController alloc]init];
                [self.navigationController pushViewController:Mvc animated:NO];
            }else if(i==1)
            {
                //添加课程
                EQDS_addCourseViewController  *Avc = [[EQDS_addCourseViewController alloc]init];
                [self.navigationController pushViewController:Avc animated:NO];
            }else if (i==2)
            {
                //添加视频
                EQDS_addVideoViewController  *Vvc = [[EQDS_addVideoViewController alloc]init];
                [self.navigationController pushViewController:Vvc animated:NO];
            }else if (i==3)
            {
                //添加文章
                EQDS_AddArticleViewController *Avc = [[EQDS_AddArticleViewController alloc]init];
                [self.navigationController pushViewController:Avc animated:NO];
            }
        }]];
        
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
#pragma  mark - 搜索
-(void)searchClick{
    EQD_SearchAllViewController  *Svc =[[EQD_SearchAllViewController alloc]init];
    Svc.temp0 =temp==0? 0:temp-1;
    [self.navigationController pushViewController:Svc animated:NO];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView ==ScrollView) {
        NSInteger  index = (scrollView.contentOffset.x+DEVICE_WIDTH/2)/ DEVICE_WIDTH;
        [titleView setClickTapIndex:index];
    }
    
    
}
#pragma  mark - 头部点击事件的协议代理
-(void)getSelectedIndex:(NSInteger)index
{
    temp =index;
     [ScrollView setContentOffset:CGPointMake(DEVICE_WIDTH*index, 0) animated:YES];
    
    

    if(index==0)
    {
        //首页
        [self loadRequestData];
   
    }else if(index==1 && arr_model1.count==0)
    {
        //讲师
        [self loadRequestData];
    }else if (index==2 && arr_model2.count==0)
    {
        //课程
        [self loadRequestData];
    }else if (index==3 && arr_model3.count==0)
    {
        //视频
        [self loadRequestData];
    }else if (index==4 && arr_model4.count==0)
    {
        //文章
        [self loadRequestData];
    }else
    {
        
    }
}

#pragma  mark - 返回
-(void)leftClcik
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (temp ==0) {
        return 3;
    }else
    {
    return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (temp==0) {
        if (section==0) {
            return arr_model00.count;
        }else if(section==1)
        {
            return arr_model01.count;
        }else if (section==2)
        {
            return arr_model02.count;
        }else
        {
            return 0;
        }
    }else if(temp==1)
    {
        return arr_model1.count;
    }else if (temp==2)
    {
        return arr_model2.count;
    }else if (temp==3)
    {
        return arr_model3.count;
    }else if (temp ==4)
    {
        return arr_model4.count;
    }else
    {
        return 0;
    }
   
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (temp==0) {
        return 24;
    }
    return 1;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (temp==0) {
        NSArray *tarr = @[@"推荐讲师",@"推荐视频",@"推荐课程"];
        return tarr[section];
    }else
    {
        return nil;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(temp==0)
    {
        //首页
        if (indexPath.section==0) {
            //推荐讲师
            static NSString *cellId=@"cellID00";
            EQDS_TeacherTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDS_TeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            eQDS_teacherAndSearchModel  *model =arr_model00[indexPath.row];
            cell.delegate =self;
            [cell setModel:model];
            return cell;
        }else if (indexPath.section==1)
        {
            //推荐的视频
            static NSString *cellId=@"cellID01";
            EQDS_VideoTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDS_VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            EQDS_VideoModel *model =arr_model01[indexPath.row];
            cell.delegate =self;
            [cell setModel2:model];
            
            return cell;
            
        }else if (indexPath.section==2)
        {
            //推荐的课程
            static NSString *cellId=@"cellID02";
            EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            EQDS_CourseModel *model =arr_model02[indexPath.row];
            cell.delegate =self;
            [cell setModel_tuijian:model];
            
            return cell;
        }else
        {
            return nil;
        }
    }else if (temp==1)
    {
     
            //推荐的讲师
            static NSString *cellId=@"cellID1";
            EQDS_TeacherTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDS_TeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            eQDS_teacherAndSearchModel  *model =arr_model1[indexPath.row];
              cell.delegate =self;
            [cell setModel:model];
            return cell;
       
    }else if (temp==2)
    {
        //课程
        static NSString *cellId=@"cellID2";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        PX_courseManageModel  *model =arr_model2[indexPath.row];
        cell.delegate =self;
        [cell setModel_courseMin:model];
        
        return cell;
    }else if (temp==3)
    {
        //最新视频
        static NSString *cellId=@"cellID3";
        EQDS_VideoTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDS_VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        EQDS_VideoModel *model =arr_model3[indexPath.row];
        cell.delegate =self;
        [cell setModel:model];
        
        return cell;
    }else if (temp==4)
    {
        //最新文章
        static NSString *cellId=@"cellID3";
        EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        EQDS_articleModel *model =arr_model4[indexPath.row];
        cell.delegate =self;
        [cell setModel_S:model];
        
        
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (temp==0) {
        if (indexPath.section==0) {
            return 120;
        }else if (indexPath.section==1)
        {
            return 100;
        }else
        {
            EQDS_CourseModel  *model =arr_model02[indexPath.row];
            
            return model.cell_height;
        }
        
    }else if (temp==1)
    {
        return 120;
    }else if (temp==2)
    {
        PX_courseManageModel  *model =arr_model2[indexPath.row];
        return model.cell_height;
    }else if (temp==3)
    {
        return 100;
    }else if (temp==4)
    {
        EQDM_ArticleModel *model =arr_model4[indexPath.row];
        return model.cellHeight;
    }else
    {
        return 0;
    }
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (temp ==4) {
        //文章详情
        EQDS_articleModel *model =arr_model4[indexPath.row];
        EQDS_ArticleDetailViewController *Dvc = [[EQDS_ArticleDetailViewController alloc]init];
        Dvc.Id = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (temp==3)
    {
        EQDS_VideoModel *model =arr_model3[indexPath.row];
        //视频
        NSArray *tarr = [model.videoUrl componentsSeparatedByString:@"id_"];
        NSString  *vid2 =[tarr lastObject];
        NSString *vid = [vid2 stringByReplacingOccurrencesOfString:@".html" withString:@""];
        if (!DEVICE_TYPE_IPAD) {
            [self setNewOrientation:NO];
        }
        PlayerViewController *Pvc = [[PlayerViewController alloc]initWithVid:vid platform:@"youku" quality:nil];
        Pvc.islocal =NO;
        
        [self.navigationController pushViewController:Pvc animated:NO];
       
        
    }else if (temp==2)
    {
        PX_courseManageModel *model =arr_model2[indexPath.row];
        EQDS_CourseDetailViewController *Dvc = [[EQDS_CourseDetailViewController alloc]init];
        Dvc.courseId = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
        
    }
}
- (void)setNewOrientation:(BOOL)fullscreen
{
    UIDeviceOrientation lastDeviceOrien = [UIDevice currentDevice].orientation;
    UIDeviceOrientation deviceOiren = fullscreen ?
    UIDeviceOrientationLandscapeLeft : UIDeviceOrientationPortrait;
    
   /* if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice]performSelector:@selector(setOrientation:)
                                      withObject:deviceOiren];
    }*/
    if (lastDeviceOrien == deviceOiren) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 5.0) {
            [UIViewController attemptRotationToDeviceOrientation];
        }
    }
}


@end
