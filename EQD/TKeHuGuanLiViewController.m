//
//  TKeHuGuanLiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TKeHuGuanLiViewController.h"
#import "KHAddViewController.h"
#import "KHDetailViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "KHShaiXuanViewController.h"
#import "FBindexTapGestureRecognizer.h"
@interface TKeHuGuanLiViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation TKeHuGuanLiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest crmModule_Owner_getcuslistWithowner:user.Guid page:@"0" And:^(NSDictionary *dic) {
       
        if ([dic[Y_STATUS] integerValue]==200) {
             [arr_model removeAllObjects];
            NSArray  *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                KeHu_ListModel *model = [KeHu_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page =dic[@"nextpage"];
            
        }
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        [tableV reloadData];
    }];
}
-(void)loadOtherData
{
    [WebRequest crmModule_Owner_getcuslistWithowner:user.Guid page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray  *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                KeHu_ListModel *model = [KeHu_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            page =dic[@"nextpage"];
              [tableV reloadData];
            }
        }
       
      
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page=@"0";
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"客户管理";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiakehuClick)];
    [self.navigationItem setRightBarButtonItem:right];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索客户";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
     adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
}
-(void)tianjiakehuClick
{
       KHAddViewController  *KHAvc =[[KHAddViewController alloc]init];
      [self.navigationController pushViewController:KHAvc animated:NO];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [WebRequest  crmModule_Search_customerinfoWithparam:searchBar.text And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                KeHu_ListModel *model = [KeHu_ListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    KeHu_ListModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    
    cell.L_right0.userInteractionEnabled=YES;
    
    FBindexTapGestureRecognizer *tap  =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.indexPath =indexPath;
    [cell.L_right0 addGestureRecognizer:tap];
    
    
    return cell;
}
-(void)tapClick:(FBindexTapGestureRecognizer*)tap
{
    KeHu_ListModel *model =arr_model[tap.indexPath.row];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.cusCall];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebView];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        KeHu_ListModel *model =arr_model[indexPath.row];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        [WebRequest crmModule_Del_customerWithowner:user.Guid cusid:model.ID And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeObject:model];
                [tableV reloadData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KHDetailViewController *Dvc =[[KHDetailViewController alloc]init];
    KeHu_ListModel *model = arr_model[indexPath.row];
    Dvc.model = model;
    [self.navigationController pushViewController:Dvc animated:NO];
    
}



@end
