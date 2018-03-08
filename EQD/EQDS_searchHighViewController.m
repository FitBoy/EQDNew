//
//  EQDS_searchHighViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/1.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_searchHighViewController.h"
#import "EQDS_TeacherTableViewCell.h"
#import "EQDS_teacherInfoModel.h"
#import "EQDR_labelTableViewCell.h"
#import "PX_courseManageModel.h"

#import "EQDS_VideoModel.h"
#import "EQDS_VideoTableViewCell.h"

///文章
#import "EQDR_ArticleTableViewCell.h"
#import "EQDS_ArticleDetailViewController.h"
@interface EQDS_searchHighViewController ()<UITableViewDelegate,UITableViewDataSource,EQDS_TeacherTableViewCellDelegate,EQDR_labelTableViewCellDelegate,EQDS_VideoTableViewCellDelegate,EQDR_ArticleTableViewCellDelegate>
{
    UITableView *tableV;
    NSArray *arr_leibie;
    NSMutableArray *arr_model;
    NSString *page;
}

@end

@implementation EQDS_searchHighViewController
#pragma  mark - 点击文章
-(void)getLabel:(NSString *)label model:(id)model
{
    self.searchKey = label;
    [self searchWithKey:label];
}
#pragma  mark - 讲师
-(void)getlable:(NSString *)label Withmodel:(id)model
{
      self.searchKey = label;
    [self searchWithKey:label];
    
  
}
#pragma  mark - 课程
-(void)getTapTypeWithtype:(NSString *)type model:(id)model
{
    self.searchKey = type;
    [self searchWithKey:type];
}
#pragma  mark - 视频
-(void)getlabel:(NSString *)label WithModel:(id)model
{
    self.searchKey = label;
    [self searchWithKey:label];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)loadOtherData{
 
    if (self.temp==0) {
        //讲师
        [WebRequest Lectures_GetLecture_BySearchsWithpage:page researchField:self.searchKey province:@" " city:@" " minPrice:@"0" maxPrice:@"1000000" And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if([dic[Y_STATUS] integerValue]==200)
            {
                NSArray *tarr =dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_teacherInfoModel *model =[EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
        
    }else if (self.temp==1)
    {
        //课程
        [WebRequest Lectures_course_GetLectureCourse_BySearchsWithpage:page courseType:self.searchKey minTimes:@"0" maxTimes:@"1000" minPrice:@"0" maxPrice:@"500000" And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PX_courseManageModel *model = [PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height=60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (self.temp==2)
    {
        //视频
        
        [WebRequest Lectures_video_Get_LectureVideo_ByTypeWithpage:page type:self.searchKey And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic=dic[Y_ITEMS];
                NSArray *tarr=tdic[@"rows"];
              
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                  page = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_VideoModel *model = [EQDS_VideoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (self.temp==3)
    {
        //文章
        [WebRequest Lectures_article_Get_LectureArticle_BylabelWithpage:page label:self.searchKey And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page =tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel *model =[EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight=60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else
    {
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    arr_leibie = @[@"讲师",@"课程",@"视频",@"文章"];
    self.navigationItem.title  = arr_leibie[self.temp];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    page=@"0";
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    [self searchWithKey:self.searchKey];
}
-(void)searchWithKey:(NSString*)key
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
    if (self.temp==0) {
        //讲师
        [WebRequest Lectures_GetLecture_BySearchsWithpage:@"0" researchField:key province:@" " city:@" " minPrice:@"0" maxPrice:@"1000000" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if([dic[Y_STATUS] integerValue]==200)
            {
                [arr_model removeAllObjects];
                NSArray *tarr =dic[Y_ITEMS];
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_teacherInfoModel *model =[EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
    }else if (self.temp==1)
    {
        //课程
        [WebRequest Lectures_course_GetLectureCourse_BySearchsWithpage:@"0" courseType:key minTimes:@"0" maxTimes:@"1000" minPrice:@"0" maxPrice:@"500000" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeAllObjects];
                NSArray *tarr = dic[Y_ITEMS];
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PX_courseManageModel *model = [PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
    }else if (self.temp==2)
    {
        //视频
        [WebRequest Lectures_video_Get_LectureVideo_ByTypeWithpage:@"0" type:key And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic=dic[Y_ITEMS];
                NSArray *tarr=tdic[@"rows"];
                page = tdic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_VideoModel *model = [EQDS_VideoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (self.temp==3)
    {
        //文章
        [WebRequest Lectures_article_Get_LectureArticle_BylabelWithpage:@"0" label:self.searchKey And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                page =tdic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel *model =[EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else
        
    {
        
    }
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.temp==0) {
        return 120;
    }else if (self.temp==1)
    {
        PX_courseManageModel *model =arr_model[indexPath.row];
        
        return model.cell_height;
    }else if (self.temp==2)
    {
        return 100;
    }else if (self.temp==3)
    {
        EQDS_articleModel *model =arr_model[indexPath.row];
        return model.cellHeight;
    }else
    {
        return 0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.temp==0)
    {
        //讲师
        static NSString *cellId=@"cellID0";
        EQDS_TeacherTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDS_TeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        EQDS_teacherInfoModel *model =arr_model[indexPath.row];
        cell.delegate =self;
        [cell setModel2:model];
        return cell;
    }else if (self.temp==1)
    {
       //课程
        static NSString *cellId=@"cellID1";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        PX_courseManageModel *model =arr_model[indexPath.row];
        cell.delegate =self;
        [cell setModel_courseMin:model];
        return cell;
    }else if (self.temp==2)
    {
        //视频
        static NSString *cellId=@"cellID2";
        EQDS_VideoTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDS_VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.delegate =self;
        EQDS_VideoModel *model =arr_model[indexPath.row];
        [cell setModel:model];
        return cell;
    }else if (self.temp==3)
    {
        //文章
        static NSString *cellId=@"cellID3";
        EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        EQDS_articleModel *model =arr_model[indexPath.row];
        cell.delegate =self;
        [cell setModel_S:model];
        return cell;
    }else
    {
        return nil;
    }
   
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.temp==3) {
        //文章详情
        EQDS_articleModel *model =arr_model[indexPath.row];
        EQDS_ArticleDetailViewController *Dvc = [[EQDS_ArticleDetailViewController alloc]init];
        Dvc.Id = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
    }
}




@end
