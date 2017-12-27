//
//  YGZaiZhiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "YGZaiZhiViewController.h"
#import "YGShanXuanViewController.h"
#import "RuZhiSPModel.h"
#import "FBFour_imgTableViewCell.h"
#import "SPDetailViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "FBConversationViewControllerViewController.h"
#import "UISearchBar+ToolDone.h"
@interface YGZaiZhiViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,YGShanXuanViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_zaizhi;
    YGShanXuanViewController *SXvc;
    UserModel *user;
    NSString  *page;
}

@end

@implementation YGZaiZhiViewController

-(void)loadRequestData{
    
    [WebRequest Com_Com_StaffWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
            NSDictionary *dic1 =dic[Y_ITEMS];
            
            NSArray *tarr =dic1[@"listModel"];
            page =dic1[@"page"];
            [arr_zaizhi removeAllObjects];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    RuZhiSPModel *model = [RuZhiSPModel mj_objectWithKeyValues:tarr[i]];
                    [arr_zaizhi addObject:model];
                }
                
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
    [WebRequest Com_Com_StaffWithcompanyId:user.companyId page:page And:^(NSDictionary *dic) {
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
            NSDictionary *dic1 =dic[Y_ITEMS];
            
            NSArray *tarr =dic1[@"listModel"];
            page =dic1[@"page"];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    RuZhiSPModel *model = [RuZhiSPModel mj_objectWithKeyValues:tarr[i]];
                    [arr_zaizhi addObject:model];
                }
                
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
    page =@"1";
    user=[WebRequest GetUserInfo];
    self.navigationItem.title =@"在职人员";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(shanxuanClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    arr_zaizhi =[NSMutableArray arrayWithCapacity:0];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"姓名/手机号";
    [searchBar setTextFieldInputAccessoryView];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
    [self loadRequestData];
}
-(void)shanxuanClick
{
    //筛选
    YGShanXuanViewController *SXvc =[[YGShanXuanViewController alloc]init];
    SXvc.delegate =self;
    [self.navigationController pushViewController:SXvc animated:NO];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [WebRequest Com_User_SearchWithcompanyId:user.companyId para:searchBar.text userGuid:user.Guid And:^(NSDictionary *dic) {
        [arr_zaizhi removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                RuZhiSPModel *model =[RuZhiSPModel mj_objectWithKeyValues:tarr[i]];
                [arr_zaizhi addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        });
    }];
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_zaizhi.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_imgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_imgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    FBindexpathLongPressGestureRecognizer *longPress =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath=indexPath;
    [cell addGestureRecognizer:longPress];
    
    RuZhiSPModel *model =arr_zaizhi[indexPath.row];
    [cell setModel:model];
    
   
    return cell;
}
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)longpress
{
    RuZhiSPModel *model =arr_zaizhi[longpress.indexPath.row];
    
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBConversationViewControllerViewController  *oneTooneChat =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.u1];
        oneTooneChat.navigationItem.title =model.uname;
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
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RuZhiSPModel *model =arr_zaizhi[indexPath.row];
    SPDetailViewController *Dvc =[[SPDetailViewController alloc]init];
    Dvc.model =model;
    Dvc.isDetail=@"1";
    [self.navigationController pushViewController:Dvc animated:NO];
    
}

#pragma  mark - 自定义的协议代理
-(void)bumen:(NSString *)bumen startTime:(NSString *)startTime endTime:(NSString *)endTime
{
    [WebRequest Com_Get_Staff_BySearchWithcompanyId:user.companyId departmentId:bumen joinStartTime:startTime joinEndTime:endTime userGuid:user.Guid  And:^(NSDictionary *dic) {
        NSArray *tarr  = dic[Y_ITEMS];
        [arr_zaizhi removeAllObjects];
        for(int i=0;i<tarr.count;i++)
        {
            RuZhiSPModel *model =[RuZhiSPModel mj_objectWithKeyValues:tarr[i]];
            [arr_zaizhi addObject:model];
        }
        [tableV reloadData];
    }];
    
}


@end
