//
//  TwoTongShi_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TwoTongShi_ViewController.h"
#import "Com_UserModel.h"
#import "FBTwo_img11TableViewCell.h"
#import "FBConversationViewControllerViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "UISearchBar+ToolDone.h"
#import "FBindexTapGestureRecognizer.h"
#import "PPersonCardViewController.h"
@interface TwoTongShi_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_tongshi;
    UserModel *user;
    NSString *page;
}

@end

@implementation TwoTongShi_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_Com_User_ByCompanyWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
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
                
                
                [tableV reloadData];
            });
        }
      
    }];
    
}
-(void)loadFooterData
{
    [WebRequest Com_Com_User_ByCompanyWithcompanyId:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dicitems =dic[Y_ITEMS];
            page=dicitems[@"page"];
            NSArray *tarr =dicitems[@"BusinessCardList"];
            
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
                    [arr_tongshi addObject:model];
                }
            }else
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
       
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
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 104+DEVICE_TABBAR_Height-64, DEVICE_WIDTH, DEVICE_HEIGHT-104+64-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
    self.navigationItem.title =@"同事";
    
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
    FBindexpathLongPressGestureRecognizer *longPress =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressCLick:)];
    longPress.indexPath=indexPath;
    [cell addGestureRecognizer:longPress];
    [cell setModel:model];
    
    FBindexTapGestureRecognizer *tap_head =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_heandClick:)];
    tap_head.indexPath =indexPath;
    [cell.IV_img addGestureRecognizer:tap_head];
    
    
    return cell;
}
-(void)tap_heandClick:(FBindexTapGestureRecognizer*)tap
{
    Com_UserModel *model =arr_tongshi[tap.indexPath.row];
    PPersonCardViewController *pvc =[[PPersonCardViewController alloc]init];
    pvc.userGuid =model.userGuid;
    [self.navigationController pushViewController:pvc animated:NO];
    
}
-(void)longPressCLick:(FBindexpathLongPressGestureRecognizer*)longpress
{
    Com_UserModel *model =arr_tongshi[longpress.indexPath.row];
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBConversationViewControllerViewController  *oneTooneChat =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.userGuid];
        oneTooneChat.navigationItem.title =model.uname;
        RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:model.userGuid name:model.username portrait:model.photo];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.userGuid];
        RCUserInfo *userinfo2 = [[RCUserInfo alloc]initWithUserId:user.Guid name:user.username portrait:user.iphoto];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo2 withUserId:user.Guid];
        
    [self.navigationController pushViewController:oneTooneChat animated:NO];
        
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.uname];
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
    Com_UserModel *model =arr_tongshi[indexPath.row];
    FBConversationViewControllerViewController  *oneTooneChat =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.userGuid];
    oneTooneChat.navigationItem.title =model.username;
    RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:model.userGuid name:model.username portrait:model.photo];
    
    [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.userGuid];
    [self.navigationController pushViewController:oneTooneChat animated:NO];


}



@end
