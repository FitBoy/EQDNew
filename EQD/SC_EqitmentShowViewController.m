//
//  SC_EqitmentShowViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_EqitmentShowViewController.h"
#import "SC_teamMiaoshuTableViewCell.h"
#import "SC_eqipmentDetailViewController.h"
@interface SC_EqitmentShowViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation SC_EqitmentShowViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest ComSpace_ComSpaceEquipment_Get_ComSpaceEquipmentWithcompanyId:self.comId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page = dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                WS_equipmentModel *model = [WS_equipmentModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height = 60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadMoreData{
    [WebRequest ComSpace_ComSpaceEquipment_Get_ComSpaceEquipmentWithcompanyId:self.comId page:page And:^(NSDictionary *dic) {
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
                WS_equipmentModel *model = [WS_equipmentModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height = 60;
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
    self.navigationItem.title = @"设备列表";
    user =[WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS_equipmentModel *model =arr_model[indexPath.row];
    return model.cell_height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    SC_teamMiaoshuTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SC_teamMiaoshuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    WS_equipmentModel *model = arr_model[indexPath.row];
    [cell setModel_equipment:model];
    return cell;
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
            WS_equipmentModel *model = arr_model[indexPath.row];
            [WebRequest ComSpace_ComSpaceEquipment_Delete_ComSpaceEquipmentWithuserGuid:user.Guid companyId:self.comId equipmentId:model.Id And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }else
                {
                    MBFadeAlertView *alertV =[[MBFadeAlertView alloc]init];
                    [alertV showAlertWith:@"服务器错误，请重试！"];
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

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS_equipmentModel *model =arr_model[indexPath.row];
    SC_eqipmentDetailViewController *Dvc = [[SC_eqipmentDetailViewController alloc]init];
    Dvc.equipmentId = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
