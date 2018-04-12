//
//  FBTrainTellViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBTrainTellViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "FBPingJiaForCourseViewController.h"
#import "PX_courseManageModel.h"
@interface FBTrainTellViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
    NSString *page;
}

@end

@implementation FBTrainTellViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Training_Get_trainCourseListWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page =dic[@"nextpage"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                PX_courseManageModel  *model =[PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    
  
}
-(void)loadOtherData{
    [WebRequest Training_Get_trainCourseListWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page =dic[@"nextpage"];
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
    self.navigationItem.title = @"选择一个课程进行评价";
    user = [WebRequest GetUserInfo];
    page =@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    

}
#pragma  mark - 表的数据源

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    PX_courseManageModel  *model =arr_model[indexPath.row];
    [cell setModel_course:model];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PX_courseManageModel  *model = arr_model[indexPath.row];
    FBPingJiaForCourseViewController  *PJvc = [[FBPingJiaForCourseViewController alloc]init];
    PJvc.courseId = model.Id;
    [self.navigationController pushViewController:PJvc animated:NO];
}




@end
