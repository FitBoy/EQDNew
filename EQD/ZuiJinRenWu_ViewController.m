//
//  ZuiJinRenWu_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "ZuiJinRenWu_ViewController.h"
#import "RenWuListModel.h"
#import "MRW_DetailViewController.h"
#import "YSDetailViewController.h"
@interface ZuiJinRenWu_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    UISegmentedControl *segmentC;
    UserModel *user;
}

@end

@implementation ZuiJinRenWu_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest MyTask_Get_DayTaskWithuserGuid:user.Guid type:[NSString stringWithFormat:@"%ld",segmentC.selectedSegmentIndex] And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                RenWuListModel  *model = [RenWuListModel mj_objectWithKeyValues:tarr[i]];
                model.height_cell=60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"当天任务";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"未完成",@"未验收"]];
    segmentC.frame =CGRectMake(0, DEVICE_HEIGHT-kBottomSafeHeight-40, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
   
  
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    RenWuListModel  *model = arr_model[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"创建时间：%@",model.creatTime];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RenWuListModel  *model = arr_model[indexPath.row];
    if (segmentC.selectedSegmentIndex ==0) {
        MRW_DetailViewController *Dvc = [[MRW_DetailViewController alloc]init];
        Dvc.model = model;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (segmentC.selectedSegmentIndex ==1 )
    {
        YSDetailViewController *Dvc = [[YSDetailViewController alloc]init];
        Dvc.model = model;
        Dvc.isyanshou = NO;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else
    {
        
    }
    
}




@end
