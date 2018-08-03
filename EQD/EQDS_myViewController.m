//
//  EQDS_myViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_myViewController.h"
#import "FBHeadScrollTitleView.h"
#import "FBOne_img2TableViewCell.h"
#import <UIImageView+WebCache.h>
#import "LoadWordViewController.h"
#import "FBShowimg_moreViewController.h"
#import "EQDR_ArticleTableViewCell.h"
#import "EQDS_searchHighViewController.h"

#import "EQDR_labelTableViewCell.h"

#import "EQDS_VideoTableViewCell.h"
#import "PhotoModel.h"
#import <UIImageView+WebCache.h>
#import "FBTwo_img11TableViewCell.h"
#import "EQDS_AddArticleViewController.h"
#import "EQDS_addCourseViewController.h"
#import "EQDS_addVideoViewController.h"
#import "EQDS_ArticleDetailViewController.h"
#import "EQDS_PhotoDetailViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "EQDS_videoChooseViewController.h"
#import "EQDS_CourseDetailViewController.h"
#import "PlayerViewController.h"
#import "PXNeedModel.h"
#import "EQDS_needDetailViewController.h"
@interface EQDS_myViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,FBHeadScrollTitleViewDelegate,UIScrollViewDelegate,EQDR_ArticleTableViewCellDelegate,EQDR_labelTableViewCellDelegate,EQDS_videoChooseViewControllerDelegate>
{
    TeacherInfo_EQDS   *teacherInfo;
    NSArray *arr_name0;
    NSMutableArray *arr_contents0;
    NSInteger temp;
    UIScrollView *ScrollView;
    NSMutableArray *arr_tableV;
    FBHeadScrollTitleView  *titleV;
    UserModel *user;
    NSMutableArray *arr_model1;
    NSMutableArray *arr_model2;
    NSMutableArray *arr_model3;
    NSMutableArray *arr_model4;
    NSMutableArray *arr_model5;
    NSString *page1;
    NSString *page2;
    NSString *page3;
    NSString *page4;
    NSString *page5;
    NSString *courseId;
    
}

@end

@implementation EQDS_myViewController
-(void)getTapTypeWithtype:(NSString*)type model:(id)model
{
    EQDS_searchHighViewController *Hvc= [[EQDS_searchHighViewController alloc]init];
    Hvc.temp=1;
    Hvc.searchKey = type;
    [self.navigationController pushViewController:Hvc animated:NO];
}
#pragma  mark - 视频label的点击事件
-(void)getlabel:(NSString*)label WithModel:(id)model
{
    EQDS_searchHighViewController *Hvc= [[EQDS_searchHighViewController alloc]init];
    Hvc.temp=2;
    Hvc.searchKey = label;
    [self.navigationController pushViewController:Hvc animated:NO];
}
#pragma  mark - 点击文章的类别
-(void)getLabel:(NSString*)label model:(id)model
{
    EQDS_searchHighViewController *Hvc= [[EQDS_searchHighViewController alloc]init];
    Hvc.temp=3;
    Hvc.searchKey = label;
    [self.navigationController pushViewController:Hvc animated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
    UITableView  *tableV = arr_tableV[temp];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
    
    if (temp==1) {
        //文章管理
        
        [WebRequest Lectures_article_Get_Article_ByLectureWithlectureGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[@"items"];
                NSArray *tarr = tdic[@"rows"];
                page1 = tdic[@"page"];
                [arr_model1 removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel *model = [EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model1 addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (temp ==2)
    {
        //课程管理
        [WebRequest Lectures_course_Get_MyCourseWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if([dic[Y_STATUS] integerValue]==200)
            {
                NSDictionary *tdic = dic[Y_ITEMS];
                [arr_model2 removeAllObjects];
                NSArray *tarr = tdic[@"rows"];
                page2 = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PX_courseManageModel *model =[PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model2 addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (temp == 3)
    {
        //视频管理
        [WebRequest Lectures_Get_LectureVideo_ByLectureWithlectureGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                page3 = tdic[@"page"];
                [arr_model3 removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_VideoModel *model = [EQDS_VideoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model3 addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (temp == 4)
    {
        //照片管理
        [WebRequest Lectures_Get_LecturePhoto_MenuWithlectureGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                [arr_model4 removeAllObjects];
                NSArray *tarr = tdic[@"rows"];
                page4 = tdic[@"page"];
                for(int i=0;i<tarr.count;i++)
                {
                    PhotoModel *model =[PhotoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model4 addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (temp ==5)
    {
        NSTimeInterval time = -30*24*60*60;
        NSDate *before30 = [[NSDate alloc]initWithTimeInterval:time sinceDate:[NSDate date]];
        NSDateFormatter  *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date = [formatter stringFromDate:before30];
        [WebRequest Training_Get_TrainingDemand_BySearchWithpage:@"0" para:teacherInfo.ResearchField date:@"2019-02-03" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model5 removeAllObjects];
                page5 = dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight=60;
                    [arr_model5 addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
    }
    else
    {
        
    }
}
-(void)loadOtherData{
     UITableView  *tableV = arr_tableV[temp];
    if (temp==1) {
        //文章管理
        [WebRequest Lectures_article_Get_Article_ByLectureWithlectureGuid:user.Guid page:page1 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[@"items"];
                NSArray *tarr = tdic[@"rows"];
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page1 = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel *model = [EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model1 addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
        
    }else if (temp ==2)
    {
        //课程管理
        [WebRequest Lectures_course_Get_MyCourseWithuserGuid:user.Guid page:page2 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if([dic[Y_STATUS] integerValue]==200)
            {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page2 = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PX_courseManageModel *model =[PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model2 addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
        
    }else if (temp == 3)
    {
        //视频管理
        [WebRequest Lectures_Get_LectureVideo_ByLectureWithlectureGuid:user.Guid page:page3 And:^(NSDictionary *dic) {
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
                page3 = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_VideoModel *model = [EQDS_VideoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model3 addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (temp == 4)
    {
        //照片管理
        [WebRequest Lectures_Get_LecturePhoto_MenuWithlectureGuid:user.Guid page:page4 And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page4 = tdic[@"page"];
                for(int i=0;i<tarr.count;i++)
                {
                    PhotoModel *model =[PhotoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model4 addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (temp ==5)
    {
        NSTimeInterval time = -30*24*60*60;
        NSDate *before30 = [[NSDate alloc]initWithTimeInterval:time sinceDate:[NSDate date]];
        NSDateFormatter  *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date = [formatter stringFromDate:before30];
        [WebRequest Training_Get_TrainingDemand_BySearchWithpage:page5 para:teacherInfo.ResearchField date:@"2019-02-03" And:^(NSDictionary *dic) {
            
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page5 = dic[@"nextpage"];
                for (int i=0; i<tarr.count; i++) {
                    PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight=60;
                    [arr_model5 addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
        
    }
    
    
    else
    {
        
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
#pragma  mark - 标题的协议代理
-(void)getSelectedIndex:(NSInteger)index
{
    temp = index;
     [ScrollView setContentOffset:CGPointMake(DEVICE_WIDTH*index, 0) animated:YES];
 
    if (index==0) {
       //讲师信息
       
        
    }else if (index==1 && arr_model1.count==0)
    {
        //文章管理
        [self loadRequestData];
    }else if (index==2 && arr_model2.count==0)
    {
        //课程管理
        [self loadRequestData];
    }else if (index ==3 && arr_model3.count==0)
    {
        // 视频管理
        [self loadRequestData];
    }else if (index==4 && arr_model4.count ==0)
    {
        //照片管理
        [self loadRequestData];
    }else if (index==5 && arr_model5.count==0)
    {
      [self loadRequestData];
    }
    else
    {
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model1 = [NSMutableArray arrayWithCapacity:0];
    arr_model2 = [NSMutableArray arrayWithCapacity:0];
    arr_model3 = [NSMutableArray arrayWithCapacity:0];
    arr_model4 = [NSMutableArray arrayWithCapacity:0];
    arr_model5 = [NSMutableArray arrayWithCapacity:0];
    page1 =@"0";
    page2=@"0";
    page3 =@"0";
    page4 =@"0";
    page5 =@"0";
    user = [WebRequest GetUserInfo];
    arr_tableV = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"个人中心";
    teacherInfo = [WebRequest getTeacherInfo];
    titleV = [[FBHeadScrollTitleView alloc]initWithFrame:CGRectMake(0,DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:titleV];
    titleV.delegate_head =self;
    
    [titleV setArr_titles:@[@"讲师信息",@"文章管理",@"课程管理",@"视频管理",@"照片管理",@"需求推荐"]];
    [self setTableVData];
    temp =0;
    [self setScrollViewWithCount:6];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    [self.navigationItem setRightBarButtonItem:right];
}
#pragma  mark - 添加按钮
-(void)tianjiaCLick
{
    if(temp==1)
    {
        ///添加文章
        
        EQDS_AddArticleViewController *Avc = [[EQDS_AddArticleViewController alloc]init];
        [self.navigationController pushViewController:Avc animated:NO];
    }else if (temp ==2)
    {
        //添加课程
        EQDS_addCourseViewController  *Avc = [[EQDS_addCourseViewController alloc]init];
        [self.navigationController pushViewController:Avc animated:NO];
    }else if (temp ==3)
    {
        //添加视频
        EQDS_addVideoViewController  *Vvc = [[EQDS_addVideoViewController alloc]init];
        [self.navigationController pushViewController:Vvc animated:NO];
    }else if (temp ==4 )
    {
        ///添加照片目录
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"添加相册" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入相册名称";
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在添加";
            [WebRequest Lectures_Add_LecturePhoto_MenuWithuserGuid:user.Guid title:alert.textFields[0].text And:^(NSDictionary *dic) {
                [hud hideAnimated:NO];
             if([dic[Y_STATUS] integerValue]==200)
             {
                 PhotoModel *model = [PhotoModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                 [arr_model4 addObject:model];
                 UITableView *tableV= arr_tableV[temp];
                 [tableV reloadData];
             }
            }];
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
        
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"暂无该功能";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
}
#pragma  mark - scroll的协议代理

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView ==ScrollView) {
        NSInteger  index = scrollView.contentOffset.x/ DEVICE_WIDTH;
        [titleV setClickTapIndex:index];
    }
   
    
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
       UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*i, 0, DEVICE_WIDTH, height_scroll) style:UITableViewStylePlain];
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

-(void)setTableVData{
    arr_name0 = @[@"头像",@"助理",@"助理手机",@"个人手机",@"邮箱",@"QQ",@"微信",@"常驻城市",@"个人简介",@"主讲课程",@"课程价格/元",@"授课风格",@"研究领域",@"客户案例",@"服务过的企业",@"资质证明"];
    arr_contents0 = [NSMutableArray arrayWithArray:@[teacherInfo.headimage,teacherInfo.Assistant,teacherInfo.AssistantPhone,teacherInfo.phone,teacherInfo.email,teacherInfo.QQ,teacherInfo.wechat,teacherInfo.address,@"查看",teacherInfo.courses,teacherInfo.CooperativePrice,@"查看",teacherInfo.ResearchField,@"查看",@"查看",@"查看"]];
   
    

}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (temp==0) {
        return 60;
    }else if (temp==1)
    {
        EQDS_articleModel *model =arr_model1[indexPath.row];
        return model.cellHeight;
    }else if (temp==2)
    {
        PX_courseManageModel *model =arr_model2[indexPath.row];
        return model.cell_height;
    }else if (temp ==3)
    {
        return 100;
    }else if (temp ==4)
    {
        return 60;
    }else if (temp ==5)
    {
        PXNeedModel *model = arr_model5[indexPath.row];
        return model.cellHeight;
    }
    else
    {
        return 0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(temp==0){
        return arr_contents0.count;
    }else if (temp==1)
    {
        return arr_model1.count;
    }else if (temp==2)
    {
        return arr_model2.count;
    }else if (temp==3)
    {
        return arr_model3.count;
    }else if (temp==4)
    {
        return arr_model4.count;
    }else if (temp==5)
    {
        return arr_model5.count;
    }
    else
    {
         return 0;
    }
 
  
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (temp==0) {
        if (indexPath.row==0) {
            
            FBOne_img2TableViewCell  *cell = [[FBOne_img2TableViewCell alloc]init];
            cell.L_left0.text =arr_name0[0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:arr_contents0[0]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
            return cell;
        }else
        {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        }
            if(indexPath.row==8 || indexPath.row==11 || indexPath.row==13 || indexPath.row==14 || indexPath.row==15)
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.text =arr_name0[indexPath.row];
            cell.detailTextLabel.text =arr_contents0[indexPath.row];
        return cell;
        }
    }else if (temp==1)
    {
        static NSString *cellId=@"cellID1";
        EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        EQDS_articleModel *model =arr_model1[indexPath.row];
        cell.delegate =self;
        [cell setModel_S:model];
        return cell;
    }else if (temp ==2 )
    {// 课程
        static NSString *cellId=@"cellID2";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        PX_courseManageModel *model =arr_model2[indexPath.row];
        cell.delegate =self;
        [cell setModel_course:model];
        
        FBindexpathLongPressGestureRecognizer *longPress= [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress2Click:)];
        longPress.indexPath =indexPath;
        [cell addGestureRecognizer:longPress];
        return cell;
    }else if (temp ==3 )
    {
        static NSString *cellId=@"cellID3";
        EQDS_VideoTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDS_VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        EQDS_VideoModel *model =arr_model3[indexPath.row];
        cell.delegate =self;
        [cell setModel:model];
        return cell;
    }else if (temp ==4)
    {
        static NSString *cellId=@"cellID4";
        FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        PhotoModel *model =arr_model4[indexPath.row];
        [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"eqd"]];
        cell.L_left0.text = model.title;
        cell.L_left1.text =[NSString stringWithFormat:@"%@张",model.imageCount];
        FBindexpathLongPressGestureRecognizer *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressCLick:)];
        longPress.indexPath = indexPath;
        [cell addGestureRecognizer:longPress];
        return cell;
    }else if (temp==5)
    {
        static NSString *cellId=@"cellID5";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        PXNeedModel *model =arr_model5[indexPath.row];
        [cell setModel_need:model];
    
        return cell;
    }
    else
    {
        return nil;
    }
   
}
//课程长按
-(void)longPress2Click:(FBindexpathLongPressGestureRecognizer*)longPress{
    UITableView *tableV =arr_model2[temp];
    PX_courseManageModel *model =arr_model2[longPress.indexPath.row];
    
    UIAlertController *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"关联视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //关联视频
        courseId = model.Id;
        EQDS_videoChooseViewController *Vvc = [[EQDS_videoChooseViewController alloc]init];
        Vvc.delegate =self;
        [self.navigationController pushViewController:Vvc animated:NO];
      
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"您确认删除该课程吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            [WebRequest Lectures_course_Delete_LectureCourseWithuserGuid:user.Guid courseId:model.Id And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model2 removeObject:model];
                        [tableV reloadData];
                    }
                });
            }];
        }]];
        
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert2 animated:NO completion:nil];
        });
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
}
-(void)longPressCLick:(FBindexpathLongPressGestureRecognizer*)longPress{
    UITableView *tableV = arr_tableV[temp];
    PhotoModel  *model =arr_model4[longPress.indexPath.row];
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"修改相册名字" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController  *alert2 = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"原名称:%@",model.title] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入相册新名称";
        }];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在修改";
            [WebRequest Lectures_Update_PhotoMenuNameWithuserGuid:user.Guid menuId:model.Id menuName:alert2.textFields[0].text And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                if ([dic[Y_STATUS] integerValue]==200) {
                    FBTwo_img11TableViewCell *cell = [tableV cellForRowAtIndexPath:longPress.indexPath];
                    cell.L_left0.text = alert2.textFields[0].text;
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                   
                });
            }];
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert2 animated:NO completion:nil];
        });
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确认删除【%@】相册?",model.title] message:@"删除之后，该相册里面的照片也会被相应的删除" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            [WebRequest Lectures_Delete_Lecture_ImageMenuWithuserGuid:user.Guid menuId:model.menuId And:^(NSDictionary *dic) {
                hud.label.text = dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
            }];
        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert2 animated:NO completion:nil];
        });
        
      
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
}
#pragma  mark - 视频的选择 delegate
-(void)getVideoArr:(NSArray *)arr_Video
{
    NSMutableString  *videoId = [NSMutableString string];
    for (int i=0; i<arr_Video.count; i++) {
        EQDS_VideoModel *model = arr_Video[i];
        if (i==arr_Video.count-1) {
            [videoId appendString:model.Id];
        }else
        {
           [videoId appendString:[NSString stringWithFormat:@"%@,",model.Id]];
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在关联视频";
    [WebRequest Lectures_course_Add_Course_VideoWithuserGuid:user.Guid courseId:courseId videoId:videoId And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (temp==0) {
        if (indexPath.row==0) {
            //头像
            UIImagePickerController  *picker = [[UIImagePickerController alloc]init];
            picker.delegate =self;
            picker.allowsEditing = YES;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:picker animated:NO completion:nil];
                });
            }
          
            
        }else if (indexPath.row ==8)
        {
            //个人简介
            LoadWordViewController *Lvc=[[LoadWordViewController alloc]init];
            Lvc.contentTitle = @"个人简介";
            Lvc.html = teacherInfo.LecturerBackground;
            [self.navigationController pushViewController:Lvc animated:NO];
        }else if (indexPath.row==13)
        {
            //客户案例
            LoadWordViewController *Lvc=[[LoadWordViewController alloc]init];
            Lvc.contentTitle = @"客户案例";
            Lvc.html = teacherInfo.CustCase;
            [self.navigationController pushViewController:Lvc animated:NO];
        }else if (indexPath.row==14)
        {
            //服务企业
            LoadWordViewController *Lvc=[[LoadWordViewController alloc]init];
            Lvc.contentTitle = @"服务企业";
            Lvc.html = teacherInfo.ServiceCom;
            [self.navigationController pushViewController:Lvc animated:NO];
        }else if (indexPath.row==11)
        {
            //授课风格
            LoadWordViewController *Lvc=[[LoadWordViewController alloc]init];
            Lvc.contentTitle = @"授课风格";
            Lvc.content = teacherInfo.TeachStyle;
            [self.navigationController pushViewController:Lvc animated:NO];
            
        }else if (indexPath.row==15)
        {
            //资质
            FBShowimg_moreViewController *Svc =[[FBShowimg_moreViewController alloc]init];
            NSMutableArray  *tarr = [NSMutableArray arrayWithArray:[teacherInfo.Qualifications componentsSeparatedByString:@";"]];
            [tarr removeLastObject];
            Svc.arr_imgs = tarr;
            [self.navigationController pushViewController:Svc animated:NO];
        }
        
        
    }else if (temp==1)
    {
        //文章
        EQDS_articleModel *Model= arr_model1[indexPath.row];
        EQDS_ArticleDetailViewController  *Dvc = [[EQDS_ArticleDetailViewController alloc]init];
        Dvc.Id =Model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (temp==4)
    {
        //相册
        PhotoModel *Model =arr_model4[indexPath.row];
        EQDS_PhotoDetailViewController *Dvc =[[EQDS_PhotoDetailViewController alloc]init];
        Dvc.menuId =Model.Id;
        Dvc.name_photo = Model.title;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (temp==3)
    {
        //视频
        EQDS_VideoModel *model =arr_model3[indexPath.row];
        PlayerViewController *Pvc = [[PlayerViewController alloc]initWithVid:model.vid platform:@"youku" quality:nil];
        Pvc.islocal =NO;
        Pvc.supportPortraitOnly =YES;
        [self.navigationController pushViewController:Pvc animated:NO];
        
    }else if (temp==2)
    {
        //课程
        PX_courseManageModel *model =arr_model2[indexPath.row];
        EQDS_CourseDetailViewController *Dvc = [[EQDS_CourseDetailViewController alloc]init];
        
        Dvc.courseId =model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
        
    }else if (temp ==5)
    {
        PXNeedModel  *model =arr_model5[indexPath.row];
        EQDS_needDetailViewController  *Dvc = [[EQDS_needDetailViewController alloc]init];
        Dvc.model = model;
        [self.navigationController pushViewController:Dvc animated:NO];
    }
    else
    {
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:NO completion:nil];
    UIImage  *image  = [info objectForKey:UIImagePickerControllerEditedImage];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Lectures_Update_LectureImage_ByCreaterWithuserGuid:teacherInfo.userGuid image:image And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
            UITableView *tableV = arr_tableV[0];
            FBOne_img2TableViewCell *cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
            dispatch_async(dispatch_get_main_queue(), ^{
               cell.IV_img.image = image;
            });
            [self getTeacherinfo];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
}



@end
