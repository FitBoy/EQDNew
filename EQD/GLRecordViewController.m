//
//  GLRecordViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GLRecordViewController.h"
#import "FBThree_noimg112TableViewCell.h"
#import "GLRecord_detailViewController.h"
#import "FBindexTapGestureRecognizer.h"
@interface GLRecordViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation GLRecordViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest crmModule_Get_revisitRecordWithowner:user.Guid cusid:[USERDEFAULTS objectForKey:Y_ManagerId] page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                GLRecodeModel *model =[GLRecodeModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page = dic[@"nextpage"];
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
    }];
}
-(void)loadOtherData{
    [WebRequest crmModule_Get_revisitRecordWithowner:user.Guid cusid:[USERDEFAULTS objectForKey:Y_ManagerId] page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if(tarr.count==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                GLRecodeModel *model =[GLRecodeModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page = dic[@"nextpage"];
                 [tableV reloadData];
            }
        }
      
       
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
   
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [WebRequest crmModule_Search_revisitRecordWithparam:searchBar.text And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                GLRecodeModel *model =[GLRecodeModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
    }];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBThree_noimg112TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBThree_noimg112TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    GLRecodeModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    cell.L_right.textColor =EQDCOLOR;
    FBindexTapGestureRecognizer *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.indexPath =indexPath;
    [cell.L_right addGestureRecognizer:tap];
    return cell;
}
-(void)tapClick:(FBindexTapGestureRecognizer*)tap
{
    GLRecodeModel *model =arr_model[tap.indexPath.row];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.contactsPhone];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebView];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 进入详情
    GLRecodeModel *model =arr_model[indexPath.row];
    GLRecord_detailViewController *Dvc =[[GLRecord_detailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
