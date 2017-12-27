//
//  FQSearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FQSearchViewController.h"
#import "UISearchBar+ToolDone.h"
#import "FBOne_img1TableViewCell.h"
@interface FQSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation FQSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_Com_User_ByCompanyWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSDictionary *dicitems =dic[Y_ITEMS];
        NSArray *tarr =dicitems[@"BusinessCardList"];
        page=dicitems[@"page"];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
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
                [arr_model addObject:model];
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
    user =[WebRequest GetUserInfo];
    page=@"0";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"员工搜索";
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    [searchBar setTextFieldInputAccessoryView];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length==0) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"搜索的内容不能为空";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
    [WebRequest Com_User_Search_InfoWithcompanyId:user.companyId para:searchBar.text And:^(NSDictionary *dic) {
        NSArray *tarr =dic[Y_ITEMS];
        [arr_model removeAllObjects];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
           
        }
        [tableV reloadData];
    }];
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
   FBOne_img1TableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOne_img1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    Com_UserModel *model =arr_model[indexPath.row];
    [cell setModel:model];
   
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Com_UserModel *model =arr_model[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(Com_userModel:)]) {
        [self.delegate Com_userModel:model];
    }
    [self.navigationController popViewControllerAnimated:NO];
}





@end
