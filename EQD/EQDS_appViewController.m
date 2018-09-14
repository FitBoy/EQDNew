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
#import "EQDR_Article_DetailViewController.h"
#import "EQDS_teacherInfoModel.h"
#import "EQDS_BaseModel.h"
#import "CK_CKPersonZoneViewController.h"
#import "EQDR_Article_DetailViewController.h"
#import "PXNeedModel.h"
#import "PXNeedDetailViewController.h"
#import "CK_personAppViewController.h"
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
   
}
-(void)loadRequestData{
    UITableView *tableV = arr_tableV[temp];
    if (temp==0) {
        //首页
        // 活跃讲师
        [WebRequest Makerspacey_MakerArticle_Get_ActiveMakerWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshingWithNoMoreData];
            [arr_model00 removeAllObjects];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_teacherInfoModel  *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model00 addObject:model];
                }
                 [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        ///最新文章
        [WebRequest Articles_LectureArticle_Get_ArticlesByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model01 removeAllObjects];
                for ( int i=0; i<tarr.count; i++) {
                    EQDS_BaseModel *model =[EQDS_BaseModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model01 addObject:model];
                }
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        ///最新课程
        [WebRequest Lectures_course_Get_CourseByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model02 removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_BaseModel  *model = [EQDS_BaseModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model02 addObject:model];
                }
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        /*
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
        */
        
    }else if (temp==1)
    {
        
        ///活跃讲师
        [WebRequest Makerspacey_MakerArticle_Get_ActiveMakerWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [arr_model1 removeAllObjects];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page1 = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_teacherInfoModel  *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model1 addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
        
        /*
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
            }];*/
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
        ///需求广场
        [WebRequest Training_Trains_Get_TrainingByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr  = dic[Y_ITEMS];
                page3 = dic[@"page"];
                [arr_model3 removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    PXNeedModel  *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model3 addObject:model];
                }
                [tableV reloadData];
            }
        }];
        /*/品视频
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
        }];*/
        
    }else if (temp==4)
    {
        
        [WebRequest Makerspacey_MakerArticle_Get_MakerArticleWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model4 removeAllObjects];
                page4 = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel  *model = [EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model4 addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
        /*
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
        }];*/
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
        //活跃讲师
        [WebRequest Makerspacey_MakerArticle_Get_ActiveMakerWithpage:page1 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page1 = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_teacherInfoModel  *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model1 addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
       
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
        //需求广场
        [WebRequest Training_Trains_Get_TrainingByTimeWithpage:page3 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page3 = dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model3 addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
        
        /*
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
        }];*/
    }else if (temp==4)
    {
        
        [WebRequest Makerspacey_MakerArticle_Get_MakerArticleWithpage:page4 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
    
                NSArray *tarr = dic[Y_ITEMS];
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page4 = dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        EQDS_articleModel  *model = [EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                        model.cellHeight =60;
                        [arr_model4 addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
        
        /*
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
        }];*/
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
    [titleView setArr_titles:@[@"首页",@"活跃讲师",@"最新课程",@"需求广场",@"最新文章"]];
    [self.view addSubview:titleView];
  
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItems:@[right,right1]];
    [self getTeacherinfo];
    [self setScrollViewWithCount:5];
    
     [self loadRequestData];
   
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
      
        
        if (i>0) {
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
    
    CK_personAppViewController  *Avc = [[CK_personAppViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
    
    /*
    UIAlertController  *alert = [[UIAlertController alloc]init];
    NSArray *tarr = @[@"个人中心",@"添加讲师课程",@"添加讲师文章"];
    for (int i=0; i<tarr.count; i++) {
        [alert  addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (i==0) {
               
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
     */
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
        UITableView *ttableV = arr_tableV[temp];
        [ttableV reloadData];
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
        NSArray *tarr = @[@"活跃讲师",@"最新文章",@"最新课程"];
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
            //活跃讲师
            static NSString *cellId=@"cellID00";
            EQDS_TeacherTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDS_TeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            EQDS_teacherInfoModel  *model =arr_model00[indexPath.row];
            cell.delegate =self;
            [cell setModel2:model];
            return cell;
        }else if (indexPath.section==1)
        {
            //最新文章
            static NSString *cellId=@"cellID01";
            EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            EQDS_BaseModel *model =arr_model01[indexPath.row];
            [cell setModel_base:model];
            
            return cell;
            
        }else if (indexPath.section==2)
        {
            //最新课程
            static NSString *cellId=@"cellID02";
            EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            EQDS_BaseModel *model =arr_model02[indexPath.row];
//            cell.delegate =self;
            [cell setModel_base2:model];
            
            return cell;
        }else
        {
            return nil;
        }
    }else if (temp==1)
    {
     
            //活跃的讲师
        static NSString *cellId=@"cellID1";
        EQDS_TeacherTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDS_TeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        EQDS_teacherInfoModel  *model =arr_model1[indexPath.row];
        [cell setModel2:model];
        cell.delegate =self;
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
        //最新需求
        static NSString *cellId=@"cellID3";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        PXNeedModel *model =arr_model3[indexPath.row];
        NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.thetheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:3]}];
        name.yy_alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"需求类别：%@\n预算：%@元\n结束时间：%@",model.thecategory,model.budgetedExpense,model.thedateEnd] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [name appendAttributedString:contents];
        name.yy_lineSpacing =6;
        cell.YL_label.attributedText = name;
        CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model.cellHeight = size.height+20;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
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
        }else if (indexPath.section ==1)
        {
            EQDS_BaseModel  *model =arr_model01[indexPath.row];
            
            return model.cellHeight;
        }else if (indexPath.section ==2)
        {
            EQDS_BaseModel  *model =arr_model02[indexPath.row];
            
            return model.cellHeight;
        }
        else
        {
            return 60;
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
        PXNeedModel *model =arr_model3[indexPath.row];
        return model.cellHeight;
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
        
        EQDR_Article_DetailViewController  *Dvc = [[EQDR_Article_DetailViewController alloc]init];
        Dvc.temp =0;
        Dvc.articleId = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
        
     /*   EQDS_ArticleDetailViewController *Dvc = [[EQDS_ArticleDetailViewController alloc]init];
        Dvc.Id = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];*/
    }else if (temp==3)
    {
        PXNeedModel *model = arr_model3[indexPath.row];
        PXNeedDetailViewController *Dvc = [[PXNeedDetailViewController alloc]init];
        Dvc.Id = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
        
     /*
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
        */
    }else if (temp==2)
    {
        PX_courseManageModel *model =arr_model2[indexPath.row];
        EQDS_CourseDetailViewController *Dvc = [[EQDS_CourseDetailViewController alloc]init];
        Dvc.courseId = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
        
    }else if (temp==0)
    {
        if (indexPath.section==0) {
            //讲师详情
            EQDS_teacherInfoModel  *model = arr_model00[indexPath.row];
            CK_CKPersonZoneViewController  *PPvc = [[CK_CKPersonZoneViewController alloc]init];
            PPvc.userGuid =model.userGuid;
            [self.navigationController pushViewController:PPvc animated:NO];
            
        }else if (indexPath.section==1)
        {
            //文章详情
            EQDS_articleModel *model =arr_model01[indexPath.row];
           EQDR_Article_DetailViewController  *Dvc = [[EQDR_Article_DetailViewController alloc]init];
            Dvc.articleId = model.Id;
            Dvc.temp = EQDArticle_typeRead;
            [self.navigationController pushViewController:Dvc animated:NO];
        }else if(indexPath.section ==2)
        {
            //课程详情
            EQDS_BaseModel *model  =arr_model02[indexPath.row];
            EQDS_CourseDetailViewController *Dvc = [[EQDS_CourseDetailViewController alloc]init];
            Dvc.courseId = model.Id;
            [self.navigationController pushViewController:Dvc animated:NO];
        }else
        {
            
        }
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
