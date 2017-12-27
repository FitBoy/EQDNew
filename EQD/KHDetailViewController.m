//
//  KHDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "KHDetailViewController.h"
#import "FBTextFieldViewController.h"
#import "FBAddressViewController.h"
#import "FBTextvImgViewController.h"
#import "NSString+FBString.h"
#import <RongIMKit/RongIMKit.h>
#import "DGuanLiViewController.h"
#import "FBOptionViewController.h"
#import "FBSearchMapViewController.h"
#import "FBShowImg_TextViewController.h"
#import "GLLianXiRenViewController.h"
#import "GLFanKuiViewController.h"
#import "GLChanceViewController.h"
#import "GLRecordViewController.h"
@interface KHDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate,FBOptionViewControllerDelegate,FBAddressViewControllerDelegate,FBTextFieldViewControllerDelegate,FBSearchMapViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    DGuanLiViewController *GLvc ;
    UserModel *user;
    KeHu_ListModel *model_detail;
}

@end

@implementation KHDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"客户详情";
    user = [WebRequest GetUserInfo];
    arr_names =[NSMutableArray arrayWithArray:@[@"客户名称",@"客户类型",@"销售区域",@"地址",@"客户电话",@"网址",@"客户图文",@"添加时间",@"客户编码"]];
    [WebRequest crmModule_Owner_getcusWithowner:user.Guid cusid:self.model.ID And:^(NSDictionary *dic) {
        model_detail =[KeHu_ListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        
        arr_contents =[NSMutableArray arrayWithArray:@[model_detail.cusName,model_detail.cusType,model_detail.salesTerritory,model_detail.address,model_detail.cusCall,model_detail.url,model_detail.remark,model_detail.createTime,model_detail.cusCode]];
        [tableV reloadData];
    }];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(guanliClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
 
}
-(void)guanliClick
{
    //管理
    GLvc =[[DGuanLiViewController alloc]init];
    GLvc.delegate=self;
    GLvc.model =model_detail;
    [USERDEFAULTS setObject:model_detail.ID forKey:Y_ManagerId];
    [USERDEFAULTS setObject:model_detail.cusName forKey:Y_ManagerName];
    [USERDEFAULTS synchronize];
    [self.navigationController pushViewController:GLvc animated:NO];
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    switch (tabBarController.selectedIndex) {
        case 0:
            {
                GLvc.navigationItem.title =@"销售机会";
            }
            break;
        case 1:
        {
            
            GLvc.navigationItem.title =@"回访记录";
          
        }
            break;
        case 2:
        {
           GLvc.navigationItem.title =@"反馈记录";
        }
            break;
        case 3:
        {
          GLvc.navigationItem.title =@"联系人";
        }
            break;
        default:
            break;
    }
   
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font =[UIFont systemFontOfSize:17];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    if(indexPath.row>6)
    {
         cell.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [@"客户名称",@"客户类型",@"销售区域",@"地址",@"客户电话",@"网址",@"客户图文",@"添加时间",@"客户编码"
    if (indexPath.row==0 || indexPath.row==4 || indexPath.row==5 ) {
        //客户名称
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath =indexPath;
        TFvc.delegate =self;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==1)
    {
        //客户类型
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.option =29;
        Ovc.delegate =self;
        Ovc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Ovc animated:NO];
    }else if (indexPath.row==2)
    {
        FBAddressViewController *avc =[[FBAddressViewController alloc]init];
        avc.indexPath =indexPath;
        avc.delegate =self;
        [self.navigationController pushViewController:avc animated:NO];
    }else if (indexPath.row==3)
    {
        FBSearchMapViewController *Svc =[[FBSearchMapViewController alloc]init];
        Svc.delegate =self;
        [self.navigationController pushViewController:Svc animated:NO];
    }
    else if (indexPath.row==6)
    {
        FBShowImg_TextViewController *ShowVc=[[FBShowImg_TextViewController alloc]init];
        ShowVc.contentTitle =arr_names[indexPath.row];
        ShowVc.contents=arr_contents[indexPath.row];
        ShowVc.arr_imgs =model_detail.lpicAddr;
        [self.navigationController pushViewController:ShowVc animated:NO];
    }else
    {
    }
}

#pragma mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    NSArray *tarr =@[@"cusName",@"",@"",@"",@"cusCall",@"url"];
    
        [self xiugaiWithkey:tarr[indexPath.row] values:content indexPath:indexPath];
    
}

-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    NSArray *tarr = [address componentsSeparatedByString:@"-"];
    [self xiugaiWithkey:@"salesTerritory" values:tarr[0] indexPath:indexPath];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithkey:@"cusType" values:option indexPath:indexPath];
   
    
}
-(void)xiugaiWithkey:(NSString*)key  values:(NSString*)value indexPath:(NSIndexPath*)indexPath
{
    NSString *tstr =[NSString stringWithFormat:@"{'%@':'%@'}",key,value];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest  crmModule_Update_customerWithowner:user.Guid cusid:model_detail.ID data:tstr And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:value];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
}
-(void)mapAddress:(NSString *)mapadress location:(CLLocationCoordinate2D)coor2d
{
    NSString *data = [NSString stringWithFormat:@"{'address':'%@','addrlong':'%f','addrlat':'%f'}",mapadress,coor2d.longitude,coor2d.latitude];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest crmModule_Update_customerWithowner:user.Guid cusid:model_detail.ID data:data And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents replaceObjectAtIndex:3 withObject:mapadress];
            [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
    
}


@end
