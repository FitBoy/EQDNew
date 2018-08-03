//
//  FBHangYeViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBHangYeViewController.h"
#import "FBHnagYeModel.h"
@interface FBHangYeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_hangye;
    NSIndexPath *indexPath_sealected;
    UISearchBar * searchBar;
    NSArray  *tarr;
}

@end

@implementation FBHangYeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
   [WebRequest Option_AreasAndWithtype:2 And:^(NSArray *arr) {
    
        if (arr.count) {
            [arr_hangye removeAllObjects];
            for (NSDictionary *dic1 in arr) {
                FBHnagYeModel *model = [FBHnagYeModel mj_objectWithKeyValues:dic1];
                [arr_hangye addObject:model];
            }
            tarr = arr_hangye;
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
}];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"行业分类";
    adjustsScrollViewInsets_NO(tableV, self);
   
    arr_hangye = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=45;
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
   
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_hangye =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",searchText];
        arr_hangye = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    [tableV reloadData];
    
    
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        return arr_hangye.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FBHnagYeModel *model =arr_hangye[indexPath.row];
        cell.textLabel.text =model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
  FBHnagYeModel *model =arr_hangye[indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:model.name message:model.dec preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
     [self presentViewController:alert animated:NO completion:nil];
    });
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBHnagYeModel *model =arr_hangye[indexPath.row];
    
    NSString *hangye =[NSString stringWithFormat:@"%@-%@",model.name,model.code];
    if ([self.delegate respondsToSelector:@selector(hangye:Withindexpath:)]) {
        
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate hangye:hangye Withindexpath:self.indexPath];
    }
}

@end
