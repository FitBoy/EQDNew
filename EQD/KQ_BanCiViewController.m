//
//  KQ_BanCiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 班次设置

#import "KQ_BanCiViewController.h"
#import "BC_addViewController.h"
#import "FBTwo_noImg11TableViewCell.h"
#import "BC_detailViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
@interface KQ_BanCiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_banci;
}

@end

@implementation KQ_BanCiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
  
    [WebRequest Get_Shift_ByCompanyWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            [arr_banci removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                BanCiModel *model =[BanCiModel mj_objectWithKeyValues:tarr[i]];
                [arr_banci addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title= @"班次设置";
    user =[WebRequest GetUserInfo];
    arr_banci =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaBanbieClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
#pragma  mark - 添加班次
-(void)tianjiaBanbieClick
{
    BC_addViewController *Avc =[[BC_addViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_banci.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BanCiModel *model =arr_banci[indexPath.row];
    static NSString *cellId=@"cellID";
    FBTwo_noImg11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noImg11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell setModel:model];
    FBindexpathLongPressGestureRecognizer *longPress =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath =indexPath;
    [cell addGestureRecognizer:longPress];
    
    return cell;
}
#pragma  mark - 长按操作
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)longpress
{
    BanCiModel *model =arr_banci[longpress.indexPath.row];
    UIAlertController *alert =[[UIAlertController alloc]init];
 [alert addAction:[UIAlertAction actionWithTitle:@"修改名字" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     UIAlertController *alert2 =[UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"原名字:%@",model.shiftName] preferredStyle:UIAlertControllerStyleAlert];
     [alert2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"请输入新名字";
     }];
     [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         if(alert2.textFields[0].text.length==0)
         {
             MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
             hud.mode = MBProgressHUDModeText;
             hud.label.text =@"输入内容不能为空";
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 [MBProgressHUD hideHUDForView:self.view  animated:YES];
             });
         }
         else
         {
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             hud.mode = MBProgressHUDModeAnnularDeterminate;
             hud.label.text = @"正在修改";
             [WebRequest Update_ShiftWithuserGuid:user.Guid companyId:user.companyId shiftId:model.Id shiftName:alert2.textFields[0].text startTime1:model.startTime1 endTime1:model.endTime1 startTime2:model.startTime2 endTime2:model.endTime2 startTime3:model.startTime3 endTime3:model.endTime3 startTime4:model.startTime4 endTime4:model.endTime4 And:^(NSDictionary *dic) {
                 if([dic[Y_STATUS] integerValue]==200)
                     
                 {
                     hud.label.text =@"修改成功";
                 }
                 else
                 {
                     hud.label.text =@"服务器错误";
                 }
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [hud hideAnimated:NO];
                     [self loadRequestData];
                 });
                 
             }];
             
             
         }
         
     }]];
     [alert2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         
     }]];
     [self presentViewController:alert2 animated:NO completion:nil];
     
     
     
 }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        
        [WebRequest  Delete_ShiftWithuserGuid:user.Guid shiftId:model.Id companyId:user.companyId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text =@"删除成功";
                [arr_banci removeObject:model];
                [tableV reloadData];
            }
            else
            {
                hud.label.text =@"未知错误";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self  presentViewController:alert animated:NO completion:nil];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BanCiModel *model =arr_banci[indexPath.row];
    BC_detailViewController *Dvc =[[BC_detailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
    
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
        BanCiModel *model =arr_banci[indexPath.row];
        [WebRequest  Delete_ShiftWithuserGuid:user.Guid shiftId:model.Id companyId:user.companyId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text =@"删除成功";
                [arr_banci removeObject:model];
                [tableV reloadData];
            }
            else
            {
                hud.label.text =@"未知错误";
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




@end
