//
//  SC_needCaiGouViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_needCaiGouViewController.h"
#import "SC_needModel.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
#import "SC_needAddViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "SC_maiMaiAddViewController.h"
@interface SC_needCaiGouViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
}

@end

@implementation SC_needCaiGouViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
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
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.delegate_choose respondsToSelector:@selector(getNeedModel:)]) {
        self.navigationItem.title = @"请先选择一个需求";
    }else
    {
    self.navigationItem.title = @"发布的需求列表";
    }
    user = [WebRequest GetUserInfo];
    page = @"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaNeedClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma  mark - 添加需求
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SC_needModel  *model =arr_model[indexPath.row];
    return model.cell_height;
}
-(void)tianjiaNeedClick{
    SC_needAddViewController  *Avc = [[SC_needAddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBLabel_YYAddTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    
    SC_needModel *model = arr_model[indexPath.row];
    [cell setModel_need:model];
    return cell;
}



#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     SC_needModel *model =arr_model[indexPath.row];
    if ([self.delegate_choose respondsToSelector:@selector(getNeedModel:)] ) {
        
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate_choose getNeedModel:model];
    }
    else{
   
    SC_needAddViewController *avc = [[SC_needAddViewController alloc]init];
    avc.temp =1;
    avc.Id = model.Id;
    [self.navigationController pushViewController:avc animated:NO];
    }
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
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"您确定删除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            SC_needModel *model = arr_model[indexPath.row];
            [WebRequest ComSpace_ComSpaceDemand_Delete_ComSpaceDemandWithuserGuid:user.Guid companyId:user.companyId demandId:model.Id And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }else
                {
                    MBFadeAlertView *alertB = [[MBFadeAlertView alloc]init];
                    [alertB showAlertWith:@"服务器错误，请重试"];
                }
            }];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}



@end
