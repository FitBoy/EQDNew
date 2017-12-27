//
//  KQBanBieViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "KQBanBieViewController.h"
#import "BBAddViewController.h"
#import "FBTwo_noImg11TableViewCell.h"
#import "BanbieModel.h"
#import "BB_DetailViewController.h"
@interface KQBanBieViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_models;
    UserModel *user;
}

@end

@implementation KQBanBieViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Get_RuleShiftWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            [arr_models  removeAllObjects];
            for ( int i=0; i<tarr.count; i++) {
                BanbieModel *model =[BanbieModel mj_objectWithKeyValues:tarr[i]];
                [arr_models addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"班别列表";
    arr_models =[NSMutableArray arrayWithCapacity:0];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=50;
    [self.view addSubview:tableV];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaBanbieClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)tianjiaBanbieClick
{
    //添加班别
    BBAddViewController *Avc =[[BBAddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_models.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noImg11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noImg11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    BanbieModel *model =arr_models[indexPath.row];
    [cell setModel:model];
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
        //删除
        BanbieModel *model =arr_models[indexPath.row];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        [WebRequest Delete_RuleShiftWithuserGuid:user.Guid shiftId:model.Id companyId:user.companyId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text =@"删除成功";
            }
            else
            {
                hud.label.text =@"未知错误";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [tableV reloadData];
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
    BanbieModel *model =arr_models[indexPath.row];
    BB_DetailViewController *Dvc =[[BB_DetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
