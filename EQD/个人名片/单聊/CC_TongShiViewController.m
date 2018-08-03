//
//  CC_TongShiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/5.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CC_TongShiViewController.h"
#import "UISearchBar+ToolDone.h"
#import "FBTwo_img11TableViewCell.h"
#import <RongIMKit/RongIMKit.h>
#import "FBGeRenCardMessageContent.h"

@interface CC_TongShiViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_tongshi;
    UserModel *user;
    NSString *page;
    Com_UserModel *com_user;
}

@end

@implementation CC_TongShiViewController
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
    user =[WebRequest GetUserInfo];
    page =@"0";
    arr_tongshi =[NSMutableArray arrayWithCapacity:0];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"姓名/手机号/易企点号";
    [searchBar setTextFieldInputAccessoryView];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
    self.navigationItem.title =@"同事";
    [WebRequest Com_User_BusinessCardWithuserGuid:self.userGuid And:^(NSDictionary *dic) {
        com_user = [Com_UserModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        
    }];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     Com_UserModel *model =arr_tongshi[indexPath.row];
    NSString *name_str =@"";
    if (self.isQun==NO) {
        
        name_str =[NSString stringWithFormat:@"您将要给%@发%@的名片",com_user.upname,model.username];
    }
    else
    {
        
        name_str=[NSString stringWithFormat:@"您将要发%@的名片",model.upname];
    }
    
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:name_str message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在生成名片";
        
        [WebRequest Com_User_BusinessCardWithuserGuid:model.userGuid And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            Com_UserModel *com_usermodel2 =[Com_UserModel mj_objectWithKeyValues:dic[Y_ITEMS] ];
            NSDictionary *dic2 = @{
                                   @"imgurl":com_usermodel2.photo,
                                   @"name":com_usermodel2.upname,
                                   @"bumen":com_usermodel2.department,
                                   @"gangwei":com_usermodel2.post,
                                   @"company":com_usermodel2.company,
                                   @"uid":com_usermodel2.userGuid,
                                   @"comid":@"0"
                                   };
            FBGeRenCardMessageContent *content =[[FBGeRenCardMessageContent alloc]initWithgeRenCardWithcontent:dic2];
            RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:user.uname name:user.upname portrait:user.iphoto];
            content.senderUserInfo =userinfo;
            if(self.isQun==NO)
            {
                [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:self.userGuid content:content pushContent:nil pushData:nil success:nil error:nil];
            }
            else
            {
                [[RCIM sharedRCIM] sendMessage:ConversationType_GROUP targetId:self.userGuid content:content pushContent:nil pushData:nil success:nil error:nil];
            }
            
          NSArray *viewcontrollers = self.navigationController.viewControllers;
            [self.navigationController popToViewController:viewcontrollers[viewcontrollers.count-3] animated:NO];
            
        }];
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
}


@end
