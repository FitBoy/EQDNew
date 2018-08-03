//
//  ZhiBiao_SearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "ZhiBiao_SearchViewController.h"
#import "OptionModel.h"
@interface ZhiBiao_SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSMutableArray *arr_two;
    UISearchBar * searchBar;
}

@end

@implementation ZhiBiao_SearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
  
    NSString *urlString = [NSString stringWithFormat:@"%@Option_AreasAnd.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_type:@(49)
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [arr_model removeAllObjects];
        NSArray *tarr = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        
        [arr_model removeAllObjects];
        for (int i=0; i<tarr.count; i++) {
            OptionModel *model = [OptionModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        arr_two = [NSMutableArray arrayWithArray:arr_model];
        [tableV reloadData];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"服务器错误"];
    }];


   
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"指标";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
 
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingCick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)quedingCick
{
    if ([self.delegate_zhiBiao  respondsToSelector:@selector(getZhibiao:)]) {
          [self.navigationController popViewControllerAnimated:NO];
        [self.delegate_zhiBiao getZhibiao:searchBar.text];
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_two =[NSMutableArray arrayWithArray:arr_model];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",searchText];
        arr_two = [NSMutableArray arrayWithArray:[arr_model filteredArrayUsingPredicate:predicate]];
    }
    [tableV reloadData];
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_two.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    OptionModel  *model = arr_two[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionModel  *model = arr_two[indexPath.row];
    
    if ([self.delegate_zhiBiao  respondsToSelector:@selector(getZhibiao:)]) {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate_zhiBiao getZhibiao:model.name];
    }
    /*searchBar.text = model.name;
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",model.name];
    arr_two = [NSMutableArray arrayWithArray:[arr_model filteredArrayUsingPredicate:predicate]];
    [tableV reloadData];*/
}




@end
