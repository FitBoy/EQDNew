//
//  FX_caiGouViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FX_caiGouViewController.h"
#import "Person_caiGouViewController.h"
#import "FBHeadScrollTitleView.h"
#import "SC_needModel.h"
#import "FBLabel_YYAddTableViewCell.h"
#import "FX_caigouTableViewCell.h"
#import <Masonry.h>
#import "SC_needAddViewController.h"
#import "SC_needPiPeiViewController.h"
#import "SC_productModel.h"
#import "FB_oneImgTextBtnTableViewCell.h"
#import "SC_MaiMaiViewController.h"
@interface FX_caiGouViewController ()<FBHeadScrollTitleViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //采购需求
    UITableView *tableV;
    UIView *V_head;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
    FBHeadScrollTitleView *headTitleV;
    
    
    ///产品需求
    UITableView *tableV1;
    NSMutableArray *arr_model1;
    NSString *page1;
    
    
    
}

@end

@implementation FX_caiGouViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData1
{
    [WebRequest ComSpace_ComSpaceProduct_Get_ComSpaceProductWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV1.mj_header endRefreshing];
        [tableV1.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page1 = dic[@"page"];
            [arr_model1 removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model1 addObject:model];
            }
            [tableV1 reloadData];
        }
    }];
}
-(void)loadMoreData1
{
    [WebRequest ComSpace_ComSpaceProduct_Get_ComSpaceProductWithcompanyId:user.companyId page:page1 And:^(NSDictionary *dic) {
        [tableV1.mj_header endRefreshing];
        [tableV1.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if(tarr.count ==0)
            {
                [tableV1.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page1 = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model1 addObject:model];
                }
                [tableV1 reloadData];
            }
        }
    }];
}
-(void)loadRequestData{
    [WebRequest ComSpace_ComSpaceOther_Get_ComSpaceDemandWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page = dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                SC_needModel *model = [SC_needModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadMoreData{
    [WebRequest ComSpace_ComSpaceOther_Get_ComSpaceDemandWithcompanyId:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    SC_needModel *model = [SC_needModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }
    }];
}
-(void)setheight
{
    headTitleV = [[FBHeadScrollTitleView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:headTitleV];
    headTitleV.delegate_head =self;
    [headTitleV setArr_titles:@[@"采购需求",@"产品需求"]];
    [headTitleV setClickTapIndex:0];
}
#pragma  mark - 头部的 点击事件
-(void)getSelectedIndex:(NSInteger)index
{
    [self settableVhidden];
    if (index==0) {
       //采购需求
        tableV.hidden =NO;
        if(arr_model.count==0)
        {
            [tableV.mj_header beginRefreshing];
        }else
        {
            [tableV reloadData];
        }
    }else if (index ==1)
    {
        tableV1.hidden =NO;
        if (arr_model1.count==0) {
            [tableV1.mj_header beginRefreshing];
        }else
        {
            [tableV1 reloadData];
        }
       //产品需求
    }else
    {
        
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"采购中心";

    arr_model = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    page = @"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    V_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40 )];
    V_head.userInteractionEnabled = YES;
    tableV.tableHeaderView = V_head;
    FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:@"+ 采购需求" titleColor:[UIColor whiteColor] backgroundColor:[UIColor orangeColor] font:[UIFont systemFontOfSize:18]];
    [tbtn addTarget:self action:@selector(addCaiGouClick) forControlEvents:UIControlEventTouchUpInside];
    
    [V_head addSubview:tbtn];
    [tbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 35));
        make.left.mas_equalTo(V_head.mas_left).mas_offset(15);
        make.centerY.mas_equalTo(V_head.mas_centerY);
    }];
    
    if([user.isAdmin integerValue] >0)
    {
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"设置采购人员" style:UIBarButtonItemStylePlain target:self action:@selector(shezhiClick)];
    [self.navigationItem setRightBarButtonItem:right];
    }
    
    
    arr_model1 = [NSMutableArray arrayWithCapacity:0];
    page1 =@"0";
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV1, self);
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [self.view addSubview:tableV1];
    tableV1.rowHeight=60;
    tableV1.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData1)];
    tableV1.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData1)];
    [self settableVhidden];
    tableV.hidden =NO;
    [self setheight];
}
-(void)addCaiGouClick
{
    //添加采购需求
    SC_needAddViewController *Nvc = [[SC_needAddViewController alloc]init];
    Nvc.temp =0;
    [self.navigationController pushViewController:Nvc animated:NO];
}
-(void)settableVhidden
{
    tableV1.hidden = YES;
    tableV.hidden =YES;
}
#pragma  mark - 设置采购人员
-(void)shezhiClick
{
    Person_caiGouViewController  *CGvc = [[Person_caiGouViewController alloc]init];
    CGvc.type = @"1";
    [self.navigationController pushViewController:CGvc animated:NO];
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV ==tableView) {
        SC_needModel *model =arr_model[indexPath.row];
        return model.cell_height;
    }else if (tableV1 ==tableView)
    {
        return 70;
    }
    else
    {
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableV ==tableView) {
       return arr_model.count;
    }else if (tableView ==tableV1)
    {
        return arr_model1.count;
    }else
    {
        return 0;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView ==tableV) {
       // 采购需求
        static NSString *cellId=@"cellID0";
        FX_caigouTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FX_caigouTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        SC_needModel *model = arr_model[indexPath.row];
        
        [cell setModel_caigou:model];
        [cell.B_btn setTitle:@"查看需求匹配的产品" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:16]];
        cell.B_btn.indexpath =indexPath;
        [cell.B_btn addTarget:self action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (tableView ==tableV1)
    {
       //产品需求
        static NSString *cellId=@"cellID1";
        FB_oneImgTextBtnTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FB_oneImgTextBtnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        SC_productModel *model = arr_model1[indexPath.row];
        [cell setModel_product:model];
        cell.B_btn.indexpath = indexPath;
        [cell.B_btn addTarget:self action:@selector(productNeedClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else
    {
        return nil;
    }
    
    
}
-(void)productNeedClick:(FBButton*)tbtn
{
    SC_productModel  *model = arr_model1[tbtn.indexpath.row];
    SC_MaiMaiViewController *MMvc = [[SC_MaiMaiViewController alloc]init];
    MMvc.temp =0;
    MMvc.productId = model.Id;
    [self.navigationController pushViewController:MMvc animated:NO];
}
#pragma  mark - 查看 匹配的产品
-(void)productClick:(FBButton*)tbtn{
    SC_needModel  *model = arr_model[tbtn.indexpath.row];
    
    SC_needPiPeiViewController *PPvc= [[SC_needPiPeiViewController alloc]init];
    PPvc.temp =0;
    PPvc.Id = model.Id;
    [self.navigationController pushViewController:PPvc animated:NO];
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV ==tableView) {
        SC_needModel  *model = arr_model[indexPath.row];
        SC_needAddViewController *Nvc = [[SC_needAddViewController alloc]init];
        Nvc.temp =1;
        Nvc.Id = model.Id;
        [self.navigationController pushViewController:Nvc animated:NO];
    }else
    {
        
    }
}




@end
