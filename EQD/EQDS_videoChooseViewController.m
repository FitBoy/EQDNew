//
//  EQDS_videoChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_videoChooseViewController.h"
#import "FBOneChooseTableViewCell.h"
#import "EQDS_VideoModel.h"
@interface EQDS_videoChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSString *page3;
    UserModel *user;
    NSMutableArray *arr_model3;
}

@end

@implementation EQDS_videoChooseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
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
}
-(void)loadOtherData{
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
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"我的视频";
    arr_model3 = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(queDingClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)queDingClick
{
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_model3.count; i++) {
        EQDS_VideoModel *model =arr_model3[i];
        if (model.isChoose==YES) {
            [tarr addObject:model];
        }
    }
    if( [self.delegate respondsToSelector:@selector(getVideoArr:)]){
        [self.delegate getVideoArr:tarr];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model3.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOneChooseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOneChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    EQDS_VideoModel *model =arr_model3[indexPath.row];
    cell.L_left0.text =model.videoTitle;
   if(model.isChoose==NO)
   {
       cell.IV_choose.image = [UIImage imageNamed:@"shequ_tluntan"];
   }else
   {
       cell.IV_choose.image = [UIImage imageNamed:@"shequ_landui"];
   }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDS_VideoModel *model = arr_model3[indexPath.row];
    model.isChoose = !model.isChoose;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}




@end
