//
//  Person_caiGouViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Person_caiGouViewController.h"
#import "FX_personModel.h"
#import "FB_twoTongShiChooseViewController.h"
#import "FBTwo_img11TableViewCell.h"
@interface Person_caiGouViewController ()<FB_twoTongShiChooseViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
}

@end

@implementation Person_caiGouViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)loadRequestData{
    [WebRequest Com_SetBuyer_Get_BuyerWithcompanyId:user.companyId page:@"0" type:self.type And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page = dic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                FX_personModel *model = [FX_personModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
                
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadMoreData{
    [WebRequest Com_SetBuyer_Get_BuyerWithcompanyId:user.companyId page:page type:self.type And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                FX_personModel *model = [FX_personModel mj_objectWithKeyValues:tarr[i]];
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
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page =@"0";
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = [self.type integerValue]==0?@"销售人员":@"采购人员";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
     [self loadRequestData];
}
#pragma  mark - 多选的人员
-(void)getChooseArr_model:(NSArray*)arr_tmodel indexpath:(NSIndexPath*)indexpath
{
    NSMutableString  *buyerGuid = [NSMutableString string];
    for (int i=0; i<arr_tmodel.count; i++) {
        Com_UserModel *tmodel = arr_tmodel[i];
        [buyerGuid appendFormat:@"%@,",tmodel.userGuid];
    }
    NSString *tstr = [buyerGuid substringWithRange:NSMakeRange(0, buyerGuid.length-1)];
    [WebRequest Com_SetBuyer_Add_BuyerWithuserGuid:user.Guid companyId:user.companyId type:self.type buyerGuid:tstr And:^(NSDictionary *dic) {
        MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"设置成功"];
            [self loadRequestData];
        }else
        {
            [alert showAlertWith:@"设置失败，请重试！"];
        }
    }];
}
-(void)rightCLick
{
    FB_twoTongShiChooseViewController  *TSvc = [[FB_twoTongShiChooseViewController alloc]init];
    TSvc.delegate_tongshi =self;
    TSvc.indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_model.count; i++) {
        FX_personModel *model = arr_model[i];
        [tarr addObject:model.objectGuid];
    }
    TSvc.arr_guid = tarr;
    [self.navigationController pushViewController:TSvc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    FX_personModel *Model = arr_model[indexPath.row];
    [cell setMode_caigou:Model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([user.isAdmin integerValue]>0)
    {
    return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleNone;
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"您确定删除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            FX_personModel *model =arr_model[indexPath.row];
            [WebRequest Com_SetBuyer_Cancel_BuyerWithuserGuid:user.Guid companyId:user.companyId lecture:model.objectGuid And:^(NSDictionary *dic) {
                MBFadeAlertView *alert1 = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert1 showAlertWith:@"取消成功"];
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }else{
                    [alert1 showAlertWith:@"取消失败，请重试"];
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
    return @"取消";
}





@end
