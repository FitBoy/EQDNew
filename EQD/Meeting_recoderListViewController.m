//
//  Meeting_recoderListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Meeting_recoderListViewController.h"
#import "Meeting_recoderViewController.h"
#import "RenWu_DetailModel.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "YSDetailViewController.h"
@interface Meeting_recoderListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation Meeting_recoderListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
    [WebRequest Meeting_task_Get_MeetingTaskWithmeetingNoticeId:self.settingId companyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            page =dic[@"page"];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                RenWu_DetailModel *model = [RenWu_DetailModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData{
    
    [WebRequest Meeting_task_Get_MeetingTaskWithmeetingNoticeId:self.settingId companyId:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            page =dic[@"page"];
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                RenWu_DetailModel *model = [RenWu_DetailModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
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
    page =@"0";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"会议记录";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
 [self loadRequestData];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RenWu_DetailModel  *model =arr_model[indexPath.row];
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
    RenWu_DetailModel *model = arr_model[indexPath.row];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:model.TaskName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cell_height = size.height+20;
    cell.YL_label.attributedText = name;
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(cell.mas_centerY);
    }];
    
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RenWu_DetailModel *model = arr_model[indexPath.row];
    YSDetailViewController  *Dvc= [[YSDetailViewController alloc]init];
    RenWuListModel *model2 = [[RenWuListModel alloc]init];
    model2.ID = model.ID;
    Dvc.model = model2;
    Dvc.isyanshou = YES;
    [self.navigationController pushViewController:Dvc animated:NO];
}

-(void)tianjiaClick
{
    Meeting_recoderViewController  *Mvc = [[Meeting_recoderViewController alloc]init];
    Mvc.settingId = self.settingId;
    [self.navigationController pushViewController:Mvc animated:NO];
}



@end
