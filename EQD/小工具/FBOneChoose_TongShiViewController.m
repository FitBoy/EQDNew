//
//  FBOneChoose_TongShiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBOneChoose_TongShiViewController.h"
#import "FBTwo_img11TableViewCell.h"
#import "UISearchBar+ToolDone.h"
@interface FBOneChoose_TongShiViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_tongshi;
    UserModel *user;
    NSString *page;
}

@end

@implementation FBOneChoose_TongShiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_Com_User_ByCompanyWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [arr_tongshi removeAllObjects];
        NSDictionary *dicitems =dic[Y_ITEMS];
        NSArray *tarr =dicitems[@"BusinessCardList"];
        page=dicitems[@"page"];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
                [arr_tongshi addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        });
    }];
    
}
-(void)loadFooterData
{
    [WebRequest Com_Com_User_ByCompanyWithcompanyId:user.companyId page:page And:^(NSDictionary *dic) {
        NSDictionary *dicitems =dic[Y_ITEMS];
        page=dicitems[@"page"];
        NSArray *tarr =dicitems[@"BusinessCardList"];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
                [arr_tongshi addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        });
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_tongshi =[NSMutableArray arrayWithCapacity:0];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"姓名/手机号/易企点号";
    [searchBar setTextFieldInputAccessoryView];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
    self.navigationItem.title=@"同事";
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [WebRequest Com_User_Search_InfoWithcompanyId:user.companyId para:searchBar.text And:^(NSDictionary *dic) {
        [arr_tongshi removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
                [arr_tongshi addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        });
    }];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_tongshi.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    Com_UserModel *model =arr_tongshi[indexPath.row];
    
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Com_UserModel *model =arr_tongshi[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(chooseModel:indexpath:)]) {
        [self.delegate chooseModel:model indexpath:self.indexpath];
        [self.navigationController popViewControllerAnimated:NO];
    }
    else
    {
        
    }
    
}

@end
