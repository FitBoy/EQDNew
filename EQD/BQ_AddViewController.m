//
//  BQ_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BQ_AddViewController.h"
#import "FBOne_imgChooseTableViewCell.h"
#import "BMChineseSort.h"
@interface BQ_AddViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_haoyou;
    NSMutableArray *arr_index;
    NSMutableArray *arr_name;
    UserModel *user;
}

@end

@implementation BQ_AddViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest User_GetFriendListuid:user.Guid And:^(NSDictionary *dic) {
        [arr_haoyou removeAllObjects];
        NSNumber *number =dic[@"status"];
        NSArray *arr =dic[@"items"];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    HaoYouModel *model = [HaoYouModel mj_objectWithKeyValues:dic1];
                    
                    for (int i=0; i<self.arr_old.count; i++) {
                        HaoYouModel *model2 =self.arr_old[i];
                        if ([model.Guid isEqualToString:model2.Guid]) {
                            model.ischoose=YES;
                            break;
                        }
                        else
                        {
                            model.ischoose=NO;
                        }
                    }
                  
                    [arr_haoyou addObject:model];
                }
                
                
                arr_index = [BMChineseSort IndexWithArray:arr_haoyou Key:@"upname"];
                arr_name = [BMChineseSort sortObjectArray:arr_haoyou Key:@"upname"];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV.mj_header endRefreshing];
                [tableV reloadData];
            });
        }
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"好友列表";
    arr_haoyou =[NSMutableArray arrayWithCapacity:0];
    
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
#pragma  mark - 确定
-(void)quedingClick
{
    //确定
    NSMutableArray *tarr =[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_haoyou.count; i++) {
        HaoYouModel *model =arr_haoyou[i];
        if (model.ischoose==YES) {
            [tarr addObject:model];
        }
    }
    if ([self.delegate respondsToSelector:@selector(haoyouArr:)]) {
        [self.delegate haoyouArr:tarr];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma  mark - 搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_index = [BMChineseSort IndexWithArray:arr_haoyou Key:@"upname"];
        arr_name =[BMChineseSort sortObjectArray:arr_haoyou Key:@"upname"];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"upname CONTAINS[cd] %@",searchText];
        NSMutableArray *tarr = [NSMutableArray arrayWithArray:[arr_haoyou filteredArrayUsingPredicate:predicate]];
        
        arr_index = [BMChineseSort IndexWithArray:tarr Key:@"upname"];
        arr_name =[BMChineseSort sortObjectArray:tarr Key:@"upname"];
    }
    [tableV reloadData];
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma  mark - 表的数据源
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return arr_index;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_index[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_index.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tarr =arr_name[section];
    return tarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOne_imgChooseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOne_imgChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    NSArray *tarr =arr_name[indexPath.section];
    HaoYouModel *model =tarr[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tarr =arr_name[indexPath.section];
    HaoYouModel *model =tarr[indexPath.row];
    model.ischoose =!model.ischoose;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
