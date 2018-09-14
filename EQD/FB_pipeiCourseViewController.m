//
//  FB_pipeiCourseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_pipeiCourseViewController.h"
#import "EQDS_CourseModel.h"
#import "EQDR_labelTableViewCell.h"
#import "EQDS_CourseDetailViewController.h"
@interface FB_pipeiCourseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSString *page;
    NSMutableArray *arr_model;
}

@end

@implementation FB_pipeiCourseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Training_TrainingMatch_Get_CourseMatchWithtrainingDemandId:self.demandId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr= dic[Y_ITEMS];
            page = dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                EQDS_CourseModel  *model = [EQDS_CourseModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadMoreData{
    [WebRequest Training_TrainingMatch_Get_CourseMatchWithtrainingDemandId:self.demandId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr= dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDS_CourseModel  *model = [EQDS_CourseModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"根据需求匹配的课程";
    page =@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDS_CourseModel  *model = arr_model[indexPath.row];
    return model.cell_height;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
     EQDR_labelTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    EQDS_CourseModel *model = arr_model[indexPath.row];
    [cell setModel_pipei:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDS_CourseModel  *model = arr_model[indexPath.row];
    EQDS_CourseDetailViewController *Dvc = [[EQDS_CourseDetailViewController alloc]init];
    Dvc.courseId = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
