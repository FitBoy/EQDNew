//
//  Need_searchNewViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/22.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "Need_searchNewViewController.h"
#import "Need_searchTableViewCell.h" //培训需求的展示样式
#import "PXNeedDetailViewController.h"
@interface Need_searchNewViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
   
    UITableView  *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    
    ///参数设定
    NSString *para;
    NSString *priceMin;
    NSString *priceMax;
    NSString *type;
    NSString *place;
    NSString *days;
    NSString *sex;
    NSString *ageMin;
    NSString *workBg;
    NSString *post;
    NSString *isauthen;
}

@end

@implementation Need_searchNewViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)setParaInit
{
    priceMin=@"0";
    priceMax = @"100000";
    type=@" ";
    place=@" ";
    days=@"365";
    sex = @"-1";
    ageMin=@"0";
    workBg=@" ";
    post=@" ";
    isauthen=@"-1";
}
-(void)loadRequestData{
    [WebRequest Training_searchDemadTrainingWithpage:@"0" para:para priceMin:priceMin priceMax:priceMax type:type place:place days:days sex:sex ageMin:ageMin workBg:workBg post:post isauthen:isauthen And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count <12) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page = dic[@"page"];
            [tableV reloadData];
        }
    }];
}
-(void)loadMoreData
{
    [WebRequest Training_searchDemadTrainingWithpage:page para:para priceMin:priceMin priceMax:priceMax type:type place:place days:days sex:sex ageMin:ageMin workBg:workBg post:post isauthen:isauthen And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }
            for (int i=0; i<tarr.count; i++) {
                PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page = dic[@"page"];
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
     [super viewDidLoad];
    self.navigationItem.title = @"需求广场";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    para = @" ";
    [self setParaInit];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    

    [self loadRequestData];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    para =searchBar.text;
    [self loadRequestData];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PXNeedModel  *model = arr_model[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    Need_searchTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[Need_searchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    PXNeedModel *model = arr_model[indexPath.row];
    [cell setModel_need:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PXNeedModel *model = arr_model[indexPath.row];
    PXNeedDetailViewController *Dvc = [[PXNeedDetailViewController alloc]init];
    Dvc.Id = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
