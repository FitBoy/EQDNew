//
//  GSRegisterViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/17.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GSRegisterViewController.h"
#import "FBTextFieldViewController.h"
#import "FBOptionViewController.h"
#import "FBAddressViewController.h"
#import "FBHangYeViewController.h"
#import "FBHangYeViewController.h"
#import "FBOptionViewController.h"
#import "EQDLoginViewController.h"
#import "NSString+FBString.h"
#import <RongIMKit/RongIMKit.h>
#import "EQDLoginViewController.h"
@interface GSRegisterViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBOptionViewControllerDelegate,FBHangYeViewControllerDelegate,FBAddressViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    NSArray  *arr_addreses;
}

@end

@implementation GSRegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationController.navigationBarHidden=NO;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"企业注册" style:UIBarButtonItemStylePlain target:self action:@selector(zhuceClick)];
    [self.navigationItem setRightBarButtonItem:right];
    self.navigationItem.title =@"企业注册";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    arr_names = [NSMutableArray arrayWithArray:@[@"企业名称",@"法定代表人/企业负责人姓名",@"法定代表人/企业负责人身份证号码",@"法定代表人/企业负责人手机号码",@"企业类型",@"所在行业",@"公司所在地",@"企业联系电话（座机）",@"企业邮箱"]];
    NSArray *tarr =[USERDEFAULTS objectForKey:@"GSRegister"];
    if (tarr.count==0) {
      arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请输入",@"请输入",@"请输入",@"请选择",@"请选择",@"请选择",@"请输入",@"请输入"]];
    }
    else
    {
        arr_contents =[NSMutableArray arrayWithArray:tarr];
    }
    
   

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [USERDEFAULTS setObject:arr_contents forKey:@"GSRegister"];
    [USERDEFAULTS synchronize];
    
}
-(void)zhuceClick
{
    NSInteger temp =0;
    for (NSString *str in arr_contents) {
        if([str isEqualToString:@"请输入"] || [str isEqualToString:@"请选择"])
        {
            temp=1;
            break;
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在注册";
    if (temp ==0) {
        //企业注册
        [WebRequest Com_loginWithcomname:arr_contents[0] comdutyman:arr_contents[1] comdutyIDnum:arr_contents[2] comdutytel:arr_contents[3] comtype:arr_contents[4] combusi:arr_contents[5] comadres:arr_contents[6] comcontact:arr_contents[7] comemai:arr_contents[8] uid:user.Guid province:arr_addreses[0] city:arr_addreses[1] area:arr_addreses[2]  And:^(NSDictionary *dic) {
            NSNumber *number = dic[Y_STATUS];
            if ([number integerValue]==200) {
                [USERDEFAULTS removeObjectForKey:@"GSRegister"];
                
                 hud.label.text=@"企业注册成功";
            }
        }];
    }
    else
    {
        hud.label.text =@"参数不完整，请检查是否漏填";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
        EQDLoginViewController *Lvc =[[EQDLoginViewController alloc]init];
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:Lvc ];
        self.view.window.rootViewController =nav;
    });
    
    
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text=arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==4) {
        //企业类型
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.contentTitle = @"企业类型";
        Ovc.delegate =self;
        Ovc.option = 6;
        [self.navigationController pushViewController:Ovc animated:NO];
    }
    else if (indexPath.row==5)
    {
        //所在行业
        FBHangYeViewController *HYvc =[[FBHangYeViewController alloc]init];
        HYvc.delegate =self;
        HYvc.indexPath=indexPath;
        
        [self.navigationController pushViewController:HYvc animated:NO];
    }
    else if(indexPath.row==6)
    {
        //公司所在地
        FBAddressViewController *Avc =[[FBAddressViewController alloc]init];
        Avc.delegate =self;
        Avc.isXiangXi=YES;
        Avc.indexPath=indexPath;
        [self.navigationController pushViewController:Avc animated:NO];
    }
    else
    {
        // 简单的输入
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath =indexPath;
        TFvc.delegate =self;
//        TFvc.content= arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
        
    }
}

-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==2)
    {
        //身份证号
        if ([content judgeIdentityStringValid]) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
            [tableV reloadData];
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"身份证号格式不正确";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }
    else if(indexPath.row==3)
    {
        //手机号
     if([RCKitUtility validateCellPhoneNumber:content])
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
    else if(indexPath.row==9)
    {
       //邮箱
        if([RCKitUtility validateEmail:content])
        {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
            [tableV reloadData];
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"邮箱格式不正确";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }
    else
    {
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadData];
    }
}
-(void)hangye:(NSString *)hangye Withindexpath:(NSIndexPath *)indexpath
{
    [arr_contents replaceObjectAtIndex:indexpath.row withObject:hangye];
    [tableV reloadData];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadData];
}
-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath  arr_address:(NSArray *)arr_address
{
    arr_addreses =arr_address;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:address];
    [tableV reloadData];
}
@end
