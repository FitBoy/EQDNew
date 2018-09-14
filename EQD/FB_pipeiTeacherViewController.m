//
//  FB_pipeiTeacherViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_pipeiTeacherViewController.h"
#import "EQDS_teacherInfoModel.h"
#import "EQDS_TeacherTableViewCell.h"
#import "CK_CKPersonZoneViewController.h"
@interface FB_pipeiTeacherViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSString *page;
    NSMutableArray *arr_model;
}

@end

@implementation FB_pipeiTeacherViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Training_TrainingMatch_Get_LectureMatchWithtrainingDemandId:self.demandId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
             page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDS_teacherInfoModel  *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            
            [tableV reloadData];
        }
        
    }];
}

-(void)loadMoreData{
    [WebRequest Training_TrainingMatch_Get_LectureMatchWithtrainingDemandId:self.demandId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDS_teacherInfoModel  *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
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
    self.navigationItem.title = @"根据需求匹配的讲师";
    page =@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=110;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDS_TeacherTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDS_TeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    EQDS_teacherInfoModel  *model = arr_model[indexPath.row];
    [cell setModel3:model];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDS_teacherInfoModel *model = arr_model[indexPath.row];
    CK_CKPersonZoneViewController  *Pvc  =[[CK_CKPersonZoneViewController alloc]init];
    Pvc.userGuid = model.userGuid;
    [self.navigationController pushViewController:Pvc animated:NO];
}




@end
