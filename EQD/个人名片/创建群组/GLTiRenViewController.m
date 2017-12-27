//
//  GLTiRenViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GLTiRenViewController.h"
#import "WebRequest.h"
#import "QunMember.h"
#import "BMChineseSort.h"
#import "FBTwoChoose_img11TableViewCell.h"
@interface GLTiRenViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_chengyuan;
    NSMutableArray *tarr;
    NSMutableArray *arr_index;
    NSMutableArray *arr_sort;
    UserModel *user;
}


@end

@implementation GLTiRenViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest User_GroupmemberWithgroupid:self.model.groupid And:^(NSDictionary *dic) {
        [arr_chengyuan removeAllObjects];
        [tarr removeAllObjects];
        NSNumber *number = dic[@"status"];
        NSArray *users = dic[@"items"];
        if ([number integerValue]==200) {
            if (users.count) {
                for (NSDictionary *dic1 in users) {
                    QunMember *model = [QunMember mj_objectWithKeyValues:dic1];
                    if ([model.Guid isEqualToString:user.Guid]) {
                        
                    }
                    else
                    {
                    [arr_chengyuan addObject:model];
                    [tarr addObject:model];
                    }
                }
                arr_index = [BMChineseSort IndexWithArray:arr_chengyuan Key:@"upname"];
                arr_sort = [BMChineseSort sortObjectArray:arr_chengyuan Key:@"upname"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV.mj_header endRefreshing];
                    [tableV reloadData];
                });
            }
        }
    }];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    adjustsScrollViewInsets_NO(tableV, self);
    self.navigationItem.title = [NSString stringWithFormat:@"%@成员列表",self.model.groupname];
    arr_chengyuan = [NSMutableArray arrayWithCapacity:0];
    tarr = [NSMutableArray arrayWithCapacity:0];
    arr_index=[NSMutableArray arrayWithCapacity:0];
    arr_sort = [NSMutableArray arrayWithCapacity:0];
    
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索群成员";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"踢人" style:UIBarButtonItemStyleDone target:self action:@selector(tiRenClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)tiRenClick
{
    NSMutableString *uid = [NSMutableString string];
    for ( int i=0; i<arr_chengyuan.count; i++) {
        QunMember *model = arr_chengyuan[i];
        if (model.ischoose==YES) {
            [uid appendFormat:@";%@",model.Guid];
        }
        else
        {
            
        }
    }
    
    //踢人
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在踢人";
    [WebRequest User_QuitgroupWithuserGuid:uid Groupid:self.model.groupid GroupName:self.model.groupname And:^(NSDictionary *dic) {
        NSString *msg = dic[Y_MSG];
        NSString *number = dic[Y_STATUS];
        hud.label.text = msg;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
        if ([number integerValue]==200) {
            [self.navigationController popViewControllerAnimated:NO];
            
        }
        
    }];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_chengyuan =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"upname CONTAINS[cd] %@",searchText];
        arr_chengyuan = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    
    arr_index = [BMChineseSort IndexWithArray:arr_chengyuan Key:@"upname"];
    arr_sort = [BMChineseSort sortObjectArray:arr_chengyuan Key:@"upname"];
    [tableV reloadData];
    
    
}
#pragma  mark - 表的数据源
-(NSArray <NSString*>*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return arr_index;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_index.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = arr_sort[section];
    return arr.count;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_index[section];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwoChoose_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwoChoose_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *arr = arr_sort[indexPath.section];
    QunMember *model = arr[indexPath.row];
    [cell setModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = arr_sort[indexPath.section];
    QunMember *model = arr[indexPath.row];
    model.ischoose=!model.ischoose;
    FBTwoChoose_img11TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setModel:model];
}


@end
