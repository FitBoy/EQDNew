//
//  Car_managerOnlyViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Car_managerOnlyViewController.h"
#import "Car_addViewController.h"
#import "FBThree_imgTableViewCell.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "CarManager_DetailViewController.h"
#import "RePairRecord_ViewController.h"
#import "Traffic_ListViewController.h"
#import "Accident_ListViewController.h"
#import "Insurance_ListViewController.h"
@interface Car_managerOnlyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSString *page;
    NSMutableArray *arr_model;
}

@end

@implementation Car_managerOnlyViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest  Com_Vehicle_Get_vehicleListWithuserGuid:user.Guid comid:user.companyId page:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            page =dic[@"nextpage"];
            NSArray  *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                CarManagerModel  *model = [CarManagerModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
        }
          [tableV reloadData];
    }];
}
-(void)loadOtherData
{
    [WebRequest  Com_Vehicle_Get_vehicleListWithuserGuid:user.Guid comid:user.companyId page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
           
            NSArray  *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                 page =dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                CarManagerModel  *model = [CarManagerModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
                 [tableV reloadData];
            }
        }
       
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"车辆列表";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    page =@"0";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
}
-(void)tianjiaClick
{
    Car_addViewController  *Cvc =[[Car_addViewController alloc]init];
    [self.navigationController pushViewController:Cvc animated:NO];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBThree_imgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBThree_imgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    CarManagerModel  *model =arr_model[indexPath.row];
    [cell setModel:model];
    FBindexpathLongPressGestureRecognizer  *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath =indexPath;
    [cell addGestureRecognizer:longPress];
    return cell;
}
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)lonPress
{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    NSArray *tarr = @[@"事故记录",@"违章记录",@"保险记录",@"保养/维修记录",@"使用记录",@"删除"];
    for (int i=0; i<tarr.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              CarManagerModel *model =arr_model[lonPress.indexPath.row];
            switch (i) {
                case 0:
                    {
                        //事故记录
                        Accident_ListViewController  *Lvc =[[Accident_ListViewController alloc]init];
                        Lvc.Id = model.Id;
                        Lvc.plateNumber =model.plateNumber;
                        [self.navigationController pushViewController:Lvc animated:NO];
                    }
                    break;
                case 1:
                {
                    // 违章记录
                    Traffic_ListViewController  *Lvc =[[Traffic_ListViewController alloc]init];
                    Lvc.Id = model.Id;
                    Lvc.plateNumber =model.plateNumber;
                    [self.navigationController pushViewController:Lvc animated:NO];
                }
                    break;
                case 2:
                {
                    // 保险记录
                    Insurance_ListViewController *Lvc =[[Insurance_ListViewController alloc]init];
                    Lvc.Id =model.Id;
                    Lvc.plateNumber = model.plateNumber;
                    [self.navigationController pushViewController:Lvc animated:NO];
                }
                    break;
                case 3:
                {
                    // 保养维修记录
                    RePairRecord_ViewController  *Rvc =[[RePairRecord_ViewController alloc]init];
                    Rvc.model =model;
                    [self.navigationController pushViewController:Rvc animated:NO];
                }
                    break;
                case 4:
                {
                    // 使用记录
                }
                    break;
                case 5:
                {
                    //删除
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeAnnularDeterminate;
                    hud.label.text = @"正在删除";
                  
                    [WebRequest Com_Vehicle_Del_vehicleInfoWithuserGuid:user.Guid comid:user.companyId vehicleId:model.Id And:^(NSDictionary *dic) {
                        hud.label.text = dic[Y_MSG];
                        if ([dic[Y_STATUS] integerValue]==200) {
                            [arr_model removeObject:model];
                            [tableV reloadData];
                        }
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [hud hideAnimated:NO];
                        });
                    }];
                }
                    break;
                default:
                    break;
            }
            
        }]];
    }
   
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
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
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        CarManagerModel *model =arr_model[indexPath.row];
        [WebRequest Com_Vehicle_Del_vehicleInfoWithuserGuid:user.Guid comid:user.companyId vehicleId:model.Id And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeObject:model];
                [tableV reloadData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    CarManagerModel  *model =arr_model[indexPath.row];
    
    ///选择的
    if (self.isChoose==1) {
        if ([self.delegate respondsToSelector:@selector(getCar_managerOnlyModel:)]) {
            [self.delegate getCar_managerOnlyModel:model];
            [self.navigationController popViewControllerAnimated:NO];
        }
        
    }else
    {
    CarManager_DetailViewController  *Dvc = [[CarManager_DetailViewController alloc]init];
    Dvc.Id = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
    }
}





@end
