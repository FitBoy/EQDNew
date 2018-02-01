//
//  PX_CourseManagerViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PX_CourseManagerViewController.h"
#import "EQDR_labelTableViewCell.h"
@interface PX_CourseManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString  *page;
}

@end

@implementation PX_CourseManagerViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}
-(void)loadRequestData{
    [WebRequest Courses_Get_Course_ByUserWithuserGuid:user.Guid pageNumber:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            page = tdic[@"page"];
            NSArray *tarr = tdic[@"rows"];
            for (int i=0; i<tarr.count; i++) {
                PX_courseManageModel  *model =[PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData
{
    [WebRequest Courses_Get_Course_ByUserWithuserGuid:user.Guid pageNumber:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
          
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                  page = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                PX_courseManageModel  *model =[PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
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
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"课程列表";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    [tableV.mj_header beginRefreshing];
//    [self loadRequestData];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PX_courseManageModel *model =arr_model[indexPath.row];
    return model.cell_height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    PX_courseManageModel *model =arr_model[indexPath.row];
    [cell setModel_course:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PX_courseManageModel *model = arr_model[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(getCourse:)]) {
        [self.delegate getCourse:model];
        [self.navigationController popViewControllerAnimated:NO];
    }else
    {
        //查看详情
    }
}



@end
