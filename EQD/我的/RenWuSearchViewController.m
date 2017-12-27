//
//  RenWuSearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RenWuSearchViewController.h"
#import "FBTimeDayViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "UISearchBar+ToolDone.h"
@interface RenWuSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,FBTimeDayViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_search;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UISearchBar *searchBar;
    UserModel *user;
}

@end

@implementation RenWuSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    user =[WebRequest GetUserInfo];
    arr_search =[NSMutableArray arrayWithCapacity:0];
    arr_names =[NSMutableArray arrayWithArray:@[@"父项目开始时间",@"父项目结束时间"]];
    arr_contents=[NSMutableArray arrayWithArray:@[@"可选",@"可选"]];
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    self.navigationItem.title=@"搜索任务";
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"任务名称";
    [searchBar setTextFieldInputAccessoryView];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    
     adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [WebRequest Get_Task_BySearchWithcompanyId:user.companyId startDate:nil endDate:nil para:searchBar.text And:^(NSDictionary *dic) {
        [arr_search removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                Search_rewuModel *model =[Search_rewuModel mj_objectWithKeyValues:tarr[i]];
                [arr_search addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
    
}
-(void)searchClick
{
    [self.view endEditing:YES];
    NSString *str1 =nil;
    NSString *str2 =nil;
    if (![arr_contents[0] isEqualToString:@"可选"]) {
        str1 =arr_contents[0];
    }
    if (![arr_contents[1] isEqualToString:@"可选"]) {
        str2 =arr_contents[1];
    }
    //搜索
    [WebRequest Get_Task_BySearchWithcompanyId:user.companyId startDate:str1 endDate:str2 para:searchBar.text And:^(NSDictionary *dic) {
        [arr_search removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                Search_rewuModel *model =[Search_rewuModel mj_objectWithKeyValues:tarr[i]];
                [arr_search addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        });

    }];
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?2:arr_search.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        static NSString *cellId=@"cellID";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
     if (indexPath.section==0) {
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_right0.text =arr_contents[indexPath.row];
       
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;

        Search_rewuModel *model =arr_search[indexPath.row];
        [cell setModel:model];
    }
     return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0?5:40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section==0?nil:@"搜索到的任务";
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   return  section==0?1:40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        UIButton *tbtn =[UIButton buttonWithType:UIButtonTypeSystem];
        [tbtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        [tbtn setTitle:@"搜索" forState:UIControlStateNormal];
        [tbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tbtn setBackgroundColor:EQDCOLOR];
        tbtn.titleLabel.font =[UIFont systemFontOfSize:24];
        return tbtn;
    }
    else
    {
        return nil;
    }
   
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        FBTimeDayViewController *TDvc =[[FBTimeDayViewController alloc]init];
        TDvc.delegate =self;
        TDvc.indexPath =indexPath;
        TDvc.contentTitle=arr_names[indexPath.row];
        
        [self.navigationController pushViewController:TDvc animated:NO];
    }
    else
    {
        Search_rewuModel *model =arr_search[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(searchRenwumodel:indexpath:)]) {
            [self.delegate searchRenwumodel:model indexpath:self.indexPath];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}
#pragma mark - 自定义的协议代理
-(void)timeDay:(NSString *)time indexPath:(NSIndexPath *)indexPath
{
    NSArray *tarr =[time componentsSeparatedByString:@" "];
    
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:tarr[0]];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
}
@end
