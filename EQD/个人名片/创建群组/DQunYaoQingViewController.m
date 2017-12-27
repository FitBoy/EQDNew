//
//  DQunYaoQingViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "DQunYaoQingViewController.h"
#import "QYQHaoYouViewController.h"
#import "FBTwoChoose_img11TableViewCell.h"
#import "UISearchBar+ToolDone.h"
#import "QunMember.h"
@interface DQunYaoQingViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_friends;
    UserModel *user;
    NSString *page;
    
    NSMutableArray *arr_qunChengyuan;
}

@end

@implementation DQunYaoQingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if([user.companyId integerValue]!=0)
    {
    [WebRequest Com_Com_User_ByCompanyWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [arr_friends removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page =dic2[@"page"];
        NSArray *tarr =dic2[@"BusinessCardList"];
        for (int i=0; i<tarr.count; i++) {
            Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
            [arr_friends addObject:model];
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
        
    }];
    }
    
}
-(void)loadOtherData
{
    if([user.companyId integerValue]!=0)
    {
    [WebRequest Com_Com_User_ByCompanyWithcompanyId:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
        NSDictionary *dic2 =dic[Y_ITEMS];
        page =dic2[@"page"];
        NSArray *tarr =dic2[@"BusinessCardList"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
        for (int i=0; i<tarr.count; i++) {
            Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
            [arr_friends addObject:model];
        }
                 [tableV reloadData];
            }
       
       
        }
        
    }];
    }else
    {
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_friends = [NSMutableArray arrayWithCapacity:0];
    page=@"0";
   
    self.navigationItem.title = @"邀请加群";
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    [searchBar setTextFieldInputAccessoryView];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    arr_qunChengyuan =[NSMutableArray arrayWithCapacity:0];
    [WebRequest User_GroupmemberWithgroupid:self.model.groupid And:^(NSDictionary *dic) {
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            QunMember *model=[QunMember mj_objectWithKeyValues:tarr[i]];
            [arr_qunChengyuan addObject:model];
        }
        [tableV reloadData];
}];

    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"邀请" style:UIBarButtonItemStylePlain target:self action:@selector(yaoqingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)yaoqingClick
{
    NSMutableString *uid =[NSMutableString string];
    
    for (int i=0; i<arr_friends.count; i++) {
        Com_UserModel  *model =arr_friends[i];
        if(model.ischoose==YES)
        {
            [uid appendFormat:@";%@",model.userGuid];
        }else
        {
            
        }
    }
    
    if(uid.length==0)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"请选择至少一个人";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在添加";
        
        [WebRequest User_AddgroupWithuserGuid:uid Groupid:self.model.groupid GroupName:self.model.groupname And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  [WebRequest  Com_User_Search_InfoWithcompanyId:user.companyId para:searchBar.text And:^(NSDictionary *dic) {
      [arr_friends removeAllObjects];
      NSArray *tarr =dic[Y_ITEMS];
      for (int i=0; i<tarr.count; i++) {
          Com_UserModel *model =[Com_UserModel mj_objectWithKeyValues:tarr[i]];
          [arr_friends addObject:model];
      }
      [tableV.mj_footer endRefreshing];
      [tableV.mj_header endRefreshing];
      [tableV reloadData];
  }];
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return arr_friends.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        UITableViewCell *cell =[[UITableViewCell alloc]init];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"好友";
        return cell;
    }else
    {
        static NSString *cellId=@"cellID1";
        FBTwoChoose_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwoChoose_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        Com_UserModel *model =arr_friends[indexPath.row];
        
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"Guid CONTAINS[cd] %@",model.userGuid];
            NSArray *tarr=[arr_qunChengyuan filteredArrayUsingPredicate:predicate];
        if (tarr.count) {
            cell.IV_img.hidden=YES;
            cell.userInteractionEnabled=NO;
        }else
        {
            cell.IV_img.hidden=NO;
            cell.userInteractionEnabled=YES;
        }
        
        [cell setModel:model];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 20;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return nil;
    }
    return @"所在企业同事";
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        QYQHaoYouViewController *HYvc =[[QYQHaoYouViewController alloc]init];
        HYvc.model=self.model;
        [self.navigationController pushViewController:HYvc animated:NO];
    }else
    {
        Com_UserModel *model =arr_friends[indexPath.row];
        model.ischoose =!model.ischoose;
        [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}



@end
