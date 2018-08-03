//
//  EQDB_searchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDB_searchViewController.h"
#import "SC_productTableViewCell.h"
#import "FBLabel_YYAddTableViewCell.h"
#import "SC_productDetailViewController.h"
@interface EQDB_searchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *searchB;
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    BOOL isNew;
}

@end

@implementation EQDB_searchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    if (isNew ==YES) {
        if (self.temp ==0) {
        [WebRequest ComSpace_Yiqigou_Get_ProductByTimeWithpage:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page =dic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
        }else if(self.temp==1)
        {
            [WebRequest ComSpace_Yiqigou_Get_DemandByTimeWithpage:@"0" And:^(NSDictionary *dic) {
                [tableV.mj_footer endRefreshing];
                [tableV.mj_header endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr =dic[Y_ITEMS];
                    page =dic[@"page"];
                    [arr_model removeAllObjects];
                    for (int i=0; i<tarr.count; i++) {
                        SC_needModel *model = [SC_needModel mj_objectWithKeyValues:tarr[i]];
                        model.cell_height =60;
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
        }else
        {
            
        }
    }else
    {
       if(self.temp ==0)
       {
           // 产品
       }else if (self.temp ==1)
       {
           //需求
       }else
       {
           
       }
    }
    
}
-(void)loadMoreData{
    if (isNew ==YES) {
        if(self.temp==0)
        {
        [WebRequest ComSpace_Yiqigou_Get_ProductByTimeWithpage:page And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page =dic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
        }else if (self.temp == 1)
        {
            [WebRequest ComSpace_Yiqigou_Get_DemandByTimeWithpage:page And:^(NSDictionary *dic) {
                [tableV.mj_footer endRefreshing];
                [tableV.mj_header endRefreshing];
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr =dic[Y_ITEMS];
                    if (tarr.count ==0) {
                        [tableV.mj_footer endRefreshingWithNoMoreData];
                    }else
                    {
                    page =dic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        SC_needModel *model = [SC_needModel mj_objectWithKeyValues:tarr[i]];
                        model.cell_height =60;
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                    }
                }
            }];
        }else
        {
            
        }
    }else
    {
        if(self.temp ==0)
        {
            // 产品
        }else if (self.temp ==1)
        {
            //需求
        }else
        {
            
        }
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"搜索";
    isNew = YES;
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page =@"0";
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    searchBar.delegate=self;
    NSString *placeH = nil;
    if (self.temp ==0) {
        placeH =@"产品名称";
    }else if(self.temp ==1)
    {
        placeH = @"需求名称";
    }
    searchBar.placeholder=placeH;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(shaixuanClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    
}
-(void)shaixuanClick{
    
}
#pragma  mark - 点击搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    isNew =NO;
    
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.temp ==0) {
    static NSString *cellId=@"cellID0";
    SC_productTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SC_productTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
        SC_productModel *model =arr_model[indexPath.row];
        [cell setModel_product:model];
    return cell;
    }else if (self.temp ==1)
    {
        static NSString *cellId=@"cellID1";
        FBLabel_YYAddTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        SC_needModel *model = arr_model[indexPath.row];
        [cell setModel_need:model];
        return cell;
    }else
    {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.temp ==0) {
        SC_productModel  *model =arr_model[indexPath.row];
        return model.cell_height;
    }else if (self.temp ==1)
    {
        SC_needModel *model =arr_model[indexPath.row];
        return model.cell_height;
        
    }else
    {
        return 60;
    }
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.temp ==0) {
        //产品
        SC_productModel  *model =arr_model[indexPath.row];
        SC_productDetailViewController *Dvc =[[SC_productDetailViewController alloc]init];
        Dvc.equipmentId = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if(self.temp ==1)
    {
        // 需求
        SC_needModel *model =arr_model[indexPath.row];
        
        
    }else
    {
        
    }
        
}




@end
