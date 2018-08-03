//
//  FBTwo_tongShiSearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBTwo_tongShiSearchViewController.h"
#import "Com_UserModel.h"
#import "FBTwo_img11TableViewCell.h"
#import "PPersonCardViewController.h"
@interface FBTwo_tongShiSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    UISearchBar * searchBar;
}

@end

@implementation FBTwo_tongShiSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
-(void)loadRequestData{
    
    [WebRequest Com_User_Search_InfoWithcompanyId:user.companyId para:searchBar.text And:^(NSDictionary *dic) {
        [self.view endEditing:YES];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                Com_UserModel *model = [Com_UserModel mj_objectWithKeyValues:tarr[i]];
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
    self.navigationItem.title = @"同事搜索";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 50)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate=self;
    searchBar.placeholder=@"姓名/手机号/易企点号";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+50, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-50) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self loadRequestData];
}


#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Com_UserModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Com_UserModel *model =arr_model[indexPath.row];
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid = model.userGuid;
    [self.navigationController pushViewController:Pvc animated:NO];
}




@end
