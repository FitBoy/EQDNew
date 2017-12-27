//
//  KHAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "KHAddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBAddressViewController.h"
#import "FBTextvImgViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "NSString+FBString.h"
#import "FBOptionViewController.h"
#import "FBSearchMapViewController.h"
@interface KHAddViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate,FBAddressViewControllerDelegate,FBTextvImgViewControllerDelegate,FBOptionViewControllerDelegate,FBSearchMapViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    ///经纬度
    NSString *str_long_atitu;
    ///多张图片
    NSArray *arr_imgs;
    UserModel *user;
    ///销售区域的code
    NSString *str_code;
}

@end

@implementation KHAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"添加客户";
    arr_names =[NSMutableArray arrayWithArray:@[@"客户名称",@"客户类型",@"销售区域",@"地址",@"客户电话",@"网址",@"备注"]];
    arr_contents =[NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请选择",@"请选择",@"请输入",@"请输入",@"请输入"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    str_long_atitu=@"0,0";
    arr_imgs = nil;
}
-(void)tianjiaClick
{
    //添加客户
    if ([arr_contents containsObject:@"请输入"]|| [arr_contents containsObject:@"请选择"]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"填写不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在添加";
        [WebRequest crmModule_Create_customerWithowner:user.Guid comid:user.companyId cusName:arr_contents[0] cusType:arr_contents[1] salesTerritory:arr_contents[2] address:arr_contents[3] latAndLong:str_long_atitu cusCall:arr_contents[4] url:arr_contents[5] remark:arr_contents[6] imgArr:arr_imgs salesTerritoryCode:str_code  And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
    }
    
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==4 || indexPath.row==5) {
        //客户名称 客户电话 网址
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath =indexPath;
        TFvc.delegate=self;
        if (indexPath.row==5) {
            TFvc.content =@"https://";
        }else
        {
          TFvc.content =arr_contents[indexPath.row];
        }
        
        TFvc.contentTitle = arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }
    else if(indexPath.row==1)
    {
        //客户类型
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.delegate =self;
        Ovc.indexPath =indexPath;
        Ovc.option =29;
        Ovc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Ovc animated:NO];
    }
    else if(indexPath.row==2)
    {
        //销售区域
        FBAddressViewController  *Avc =[[FBAddressViewController alloc]init];
        Avc.indexPath =indexPath;
        Avc.indexPath=indexPath;
        Avc.delegate=self;
        [self.navigationController pushViewController:Avc animated:NO];
        
    }
    else if(indexPath.row==3)
    {
        //地址
        FBSearchMapViewController   *Svc =[[FBSearchMapViewController alloc]init];
        Svc.delegate=self;
        [self.navigationController pushViewController:Svc animated:NO];
    }
    else if(indexPath.row==6)
    {
        //客户图文
        FBTextvImgViewController  *TIvc =[[FBTextvImgViewController alloc]init];
        TIvc.delegate =self;
        TIvc.indexPath =indexPath;
        TIvc.contentTitle = arr_names[indexPath.row];
        [self.navigationController pushViewController:TIvc animated:NO];
        
    }
}
#pragma mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==4) {
        //电话
     if(  [RCKitUtility validateCellPhoneNumber:content])
     {
         [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
         [tableV reloadData];
     }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"手机格式不正确";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
    }
    else if(indexPath.row==5)
    {
      //网址
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
            [tableV reloadData];
    }
    else
    {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
       [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
 
    }
}
-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    NSArray *tarr = [address componentsSeparatedByString:@"-"];
    str_code =tarr[1];
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:tarr[0]];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)text:(NSString *)text imgArr:(NSArray<UIImage *> *)imgArr indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    arr_imgs =imgArr;
   [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)mapAddress:(NSString *)mapadress location:(CLLocationCoordinate2D)coor2d
{
    [arr_contents replaceObjectAtIndex:3 withObject:mapadress];
    str_long_atitu = [NSString stringWithFormat:@"%f,%f",coor2d.latitude,coor2d.longitude];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

@end
