//
//  YGLiZhiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "YGLiZhiViewController.h"
#import "RuZhiSPModel.h"
#import "FBFour_imgTableViewCell.h"
#import "SPDetailViewController.h"
#import "FBConversationViewControllerViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "UISearchBar+ToolDone.h"
@interface YGLiZhiViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_lizhi;
    UserModel *user;
    NSString *page;
}

@end

@implementation YGLiZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_Com_Staff_QuitWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [arr_lizhi removeAllObjects];
        NSDictionary *tDic =dic[Y_ITEMS];
        NSArray *tarr =tDic[@"listModel"];
        page =tDic[@"page"];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                RuZhiSPModel *model =[RuZhiSPModel mj_objectWithKeyValues:tarr[i]];
                [arr_lizhi addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        });
    }];
    
}
-(void)loadFooterdata
{
    [WebRequest Com_Com_Staff_QuitWithcompanyId:user.companyId page:page And:^(NSDictionary *dic) {
        NSDictionary *tDic =dic[Y_ITEMS];
        NSArray *tarr =tDic[@"listModel"];
        page =tDic[@"page"];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                RuZhiSPModel *model =[RuZhiSPModel mj_objectWithKeyValues:tarr[i]];
                [arr_lizhi addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        });
    }];}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_lizhi =[NSMutableArray arrayWithCapacity:0];
    
    adjustsScrollViewInsets_NO(tableV, self);
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
    tableV.mj_footer =[MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterdata)];
    self.navigationItem.title =@"离职员工";
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_lizhi.count;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [WebRequest Com_User_SearchWithcompanyId:user.companyId para:searchBar.text userGuid:user.Guid And:^(NSDictionary *dic) {
        [arr_lizhi removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                RuZhiSPModel *model =[RuZhiSPModel mj_objectWithKeyValues:tarr[i]];
                [arr_lizhi addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        });
    }];
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_imgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_imgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    RuZhiSPModel *model = arr_lizhi[indexPath.row];
    FBindexpathLongPressGestureRecognizer *longPress=[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath=indexPath;
    [cell addGestureRecognizer:longPress];
    [cell setModel:model];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RuZhiSPModel *model =arr_lizhi[indexPath.row];
    SPDetailViewController *dvc =[[SPDetailViewController alloc]init];
    dvc.model=model;
    dvc.isDetail=@"1";
    [self.navigationController pushViewController:dvc animated:NO];
    
}
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)longpress
{
    RuZhiSPModel *model =arr_lizhi[longpress.indexPath.row];
    
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBConversationViewControllerViewController  *oneTooneChat =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.u1];
        oneTooneChat.navigationItem.title =model.uname;
        oneTooneChat.hidesBottomBarWhenPushed =YES;
        RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:model.u1 name:model.uname portrait:model.uiphoto];
        
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.u1];
        [self.navigationController pushViewController:oneTooneChat animated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.userPhone];
        UIWebView *callWebView = [[UIWebView alloc] init];
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebView];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}



@end
