//
//  S_courseSearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "S_courseSearchViewController.h"
#import "FBHeadScrollTitleView.h"
#import "EQDS_CourseModel.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "EQD_SearchAllViewController.h"
#import "EQDS_CourseDetailViewController.h"
@interface S_courseSearchViewController ()<UITableViewDelegate,UITableViewDataSource,FBHeadScrollTitleViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model_tuijian;
    NSMutableArray *arr_model_new;
    NSString *page1;
    FBHeadScrollTitleView *headtitle;
    NSInteger temp;
}

@end

@implementation S_courseSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if (temp ==0) {
        //推荐的课程
        [WebRequest Lectures_course_Get_LectCourse_ByRecommendAnd:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshingWithNoMoreData];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                [arr_model_tuijian removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_CourseModel  *model = [EQDS_CourseModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model_tuijian addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else
    {
        //最新的课程
        [WebRequest Lectures_course_Get_CourseByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page1 = dic[@"page"];
                [arr_model_new removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_CourseModel *model = [EQDS_CourseModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model_new addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }
}
-(void)loadMoreData{
    if (temp!=0) {
        
    [WebRequest Lectures_course_Get_CourseByTimeWithpage:page1 And:^(NSDictionary *dic) {
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
                EQDS_CourseModel *model = [EQDS_CourseModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model_new addObject:model];
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
    self.navigationItem.title = @"课程";
    arr_model_tuijian = [NSMutableArray arrayWithCapacity:0];
    arr_model_new = [NSMutableArray arrayWithCapacity:0];
    page1 = @"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    temp = 0;
    headtitle = [[FBHeadScrollTitleView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [headtitle setArr_titles:@[@"推荐的课程",@"最新的课程"]];
    headtitle.delegate_head = self;
    [headtitle setClickTapIndex:0];
    [self.view addSubview:headtitle];
    [self settableFooter];
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchrightClick)];
    [self.navigationItem setRightBarButtonItem:searchBtn];

}
-(void)searchrightClick
{
    EQD_SearchAllViewController  *Svc = [[EQD_SearchAllViewController alloc]init];
    Svc.temp0 =1;
    [self.navigationController pushViewController:Svc animated:NO];
}
-(void)getSelectedIndex:(NSInteger)index
{
    temp =index;
    [self settableFooter];
    switch (index) {
        case 0:
            {
               //推荐课程
                if(arr_model_tuijian.count ==0)
                {
                    [self loadRequestData];
                }
                [tableV reloadData];
            }
            break;
        case 1:
        {
            //最新课程
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
-(void)settableFooter{
    if (temp ==0) {
        tableV.mj_footer = nil;
    }else
    {
        tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (temp ==0) {
        return arr_model_tuijian.count;
    }else
    {
        return arr_model_new.count;
    }
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (temp ==0) {
        EQDS_CourseModel *model = arr_model_tuijian[indexPath.row];
        return model.cell_height;
    }else
    {
        EQDS_CourseModel *model = arr_model_new[indexPath.row];
        return model.cell_height;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (temp==0) {
        static NSString *cellId=@"cellID0";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        EQDS_CourseModel *model = arr_model_tuijian[indexPath.row];
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.lectCourseTitle] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        
        NSMutableAttributedString *type = [[NSMutableAttributedString alloc]initWithString:@"  " attributes:nil];
        NSArray *tarr = [model.lectCourseType componentsSeparatedByString:@","];
        for (int i=0; i<tarr.count; i++) {
            NSMutableAttributedString *type1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
            NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"  " attributes:nil];
            [type appendAttributedString:type1];
            [type appendAttributedString:kong];
            
        }
        [name appendAttributedString:type];
        name.yy_lineSpacing =6;
        cell.YL_label.attributedText = name;
        CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model.cell_height = size.height +15;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        return cell;
    }else
    {
        static NSString *cellId=@"cellID1";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        EQDS_CourseModel *model = arr_model_new[indexPath.row];
        NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.courseTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
        time.yy_alignment = NSTextAlignmentRight;
        [name appendAttributedString:time];
        name.yy_lineSpacing =6;
        CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        cell.YL_label.attributedText = name;
        model.cell_height = size.height+15;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
            make.height.mas_equalTo(size.height+10);
        }];
        return cell;
    }
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(temp ==0)
    {
        //推荐的课程
        EQDS_CourseModel *model = arr_model_tuijian[indexPath.row];
        EQDS_CourseDetailViewController *dvc = [[EQDS_CourseDetailViewController alloc]init];
        dvc.courseId = model.Id;
        [self.navigationController pushViewController:dvc animated:NO];
    }else
    {
        EQDS_CourseModel *model = arr_model_new[indexPath.row];
        EQDS_CourseDetailViewController *dvc = [[EQDS_CourseDetailViewController alloc]init];
        dvc.courseId = model.Id;
        [self.navigationController pushViewController:dvc animated:NO];
    }
}



@end
