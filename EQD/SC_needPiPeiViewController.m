//
//  SC_needPiPeiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_needPiPeiViewController.h"
#import "SC_productTableViewCell.h"
#import "SC_productDetailViewController.h"
#import "SC_needCaiGouViewController.h"
#import <UIImageView+WebCache.h>
@interface SC_needPiPeiViewController ()<UITableViewDelegate,UITableViewDataSource,SC_needCaiGouViewControllerdelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
}

@end

@implementation SC_needPiPeiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if (self.temp ==2) {
        //收藏的产品
        [WebRequest ComSpace_ComSpace_Collection_Get_ProductCollectionWithcompanyId:self.Id page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page = dic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (self.temp ==1 || self.temp ==0)
    {
    [WebRequest ComSpace_ComSpaceOther_Demand_MatchingWithdemandId:self.Id page:@"0" count:@"15" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page = dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }else
    {
        
    }
  /*
    [WebRequest ComSpace_ComSpaceDemand_Get_DemandMatchingWithdemandId:self.Id page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page = dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];*/
}
-(void)loadOtherData{
    
    if (self.temp ==2) {
        [WebRequest ComSpace_ComSpace_Collection_Get_ProductCollectionWithcompanyId:self.Id page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
            }
        }];
    }else if (self.temp ==0 || self.temp ==1)
    {
    [WebRequest ComSpace_ComSpaceOther_Demand_MatchingWithdemandId:self.Id page:page count:@"15" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }
    }];
    }
    /*
    [WebRequest ComSpace_ComSpaceDemand_Get_DemandMatchingWithdemandId:self.Id page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];*/
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"匹配的产品";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=110;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(shaixuanClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)getNeedModel:(SC_needModel *)tmodel
{
    self.Id =tmodel.Id;
    [tableV reloadData];
}
-(void)shaixuanClick
{
    SC_needCaiGouViewController  *Nvc = [[SC_needCaiGouViewController alloc]init];
    Nvc.delegate_choose =self;
    [self.navigationController pushViewController:Nvc animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.temp ==2) {
        return 110;
    }else
    {
    SC_productModel *model =arr_model[indexPath.row];
    return model.cell_height;
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    SC_productTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SC_productTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    SC_productModel  *model =arr_model[indexPath.row];
    if (self.temp ==2) {
        [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:model.productImage]];
        NSMutableAttributedString *productName = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"产品名称：%@\n产品价格：￥%@ 元",model.ProductName,model.ProductPrice] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]}];
        cell.yl_contents.attributedText = productName;
        
    }else if (self.temp ==0 || self.temp ==1)
    {
    [cell setModel_product:model];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SC_productModel  *model =arr_model[indexPath.row];
    SC_productDetailViewController *Dvc = [[SC_productDetailViewController alloc]init];
    Dvc.equipmentId = model.ProductId;
    [self.navigationController pushViewController:Dvc animated:NO];
}





@end
