//
//  GSQiYeRenZhengViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GSQiYeRenZhengViewController.h"
#import "FBImgViewController.h"
#import "FBTimeDayViewController.h"
#import "FBOptionViewController.h"
#import "FBTextFieldViewController.h"
#import "FBLocationPickerViewController.h"
#import "FBAddressViewController.h"
#import "FBHangYeViewController.h"
#import "FBTimeTwoViewController.h"
@interface GSQiYeRenZhengViewController ()<UITableViewDelegate,UITableViewDataSource,FBImgViewControllerDelegate,FBTimeDayViewControllerDelegate,FBOptionViewControllerDelegate,FBTextFieldViewControllerDelegate,RCLocationPickerViewControllerDelegate,FBAddressViewControllerDelegate,FBHangYeViewControllerDelegate,FBTimeTwoViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_imgs;
    NSMutableArray *arr_content;
    UserModel *user ;
}

@end

@implementation GSQiYeRenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"企业认证";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"认证" style:UIBarButtonItemStylePlain target:self action:@selector(renzhengClick)];
    arr_names = [NSMutableArray arrayWithArray:@[@"法定代表人/企业负责人身份证正面照片",@"法定代表人/企业负责人身份证反面照片",@"法定代表人/企业负责人手持身份证照片",@"企业《组织机构代码证》号码",@"企业《组织机构代码证》照片",@"企业《营业执照》代码",@"《营业执照》照片",@"企业《生产许可证》代码(可选)",@"企业《生产许可证》照片（可选）",@"主要客户群体",@"注册资本",@"经营范围",@"公司成立日期",@"营业期限",@"主营行业",@"主要经营地点",@"地图导航",@"员工人数"]];
    
    arr_imgs =[NSMutableArray arrayWithArray:@[@"图片",@"图片",@"图片",@"图片",@"图片"]];
    NSArray *tarr = [USERDEFAULTS objectForKey:@"GSQiYeRenZheng"];
    if(tarr.count==0)
    {
       arr_content = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请选择",@"请输入",@"请选择",@"请输入",@"请选择",@"请输入（可选）",@"请选择（可选）",@"请输入",@"请输入",@"请输入",@"请选择",@"请选择",@"请选择",@"请选择",@"请选择",@"请选择"]];
    }
    else
    {
        arr_content = [NSMutableArray arrayWithArray:tarr];
    }
    
    
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)backClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否保存填写过的信息" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [USERDEFAULTS setObject:arr_content forKey:@"GSQiYeRenZheng"];
        [USERDEFAULTS synchronize];
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)renzhengClick{
    
    //企业认证
    NSInteger temp=0;
    for (NSString *str in arr_content) {
        if ([str isEqualToString:@"请输入"]|| [str isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    
    if (temp==0) {
        if (arr_imgs.count >4) {
     /* [WebRequest Com_rname_authenWithimgArr:arr_imgs codecertifinumb:arr_content[3] buslicensenumb:arr_content[5] productcertifinum:arr_content[7] maincustomer:arr_content[9] registeredassets:arr_content[10] busscope:arr_content[11] bussetdate:arr_content[12] busterm:arr_content[13] mainbus:arr_content[14] mainbusadress:[NSString stringWithFormat:@"%@%@",arr_content[15],arr_content[16]] staffnum:arr_content[17] comid:user.comid And:^(NSDictionary *dic) {
            
            [USERDEFAULTS removeObjectForKey:@"GSQiYeRenZheng"];
            NSString *msg =dic[Y_MSG];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =msg;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view.window animated:YES];
            });
            
            [self.navigationController popViewControllerAnimated:NO];
        }];*/
            
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"照片信息不完整";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view.window animated:YES];
            });
        }
    }
    else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"信息填写不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        });
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_content[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==1 || indexPath.row==2) {
        FBImgViewController *imgvc =[[FBImgViewController alloc]init];
        imgvc.delegate =self;
        imgvc.flag =indexPath.row;
        imgvc.indexPath =indexPath;
        [self.navigationController pushViewController:imgvc animated:NO];
    }
    else if(indexPath.row==4 || indexPath.row ==6 || indexPath.row ==8){
        FBImgViewController *imgvc =[[FBImgViewController alloc]init];
        imgvc.delegate =self;
        imgvc.flag =indexPath.row/2+1;
        imgvc.indexPath =indexPath;
        [self.navigationController pushViewController:imgvc animated:NO];
    }
    else if(indexPath.row==15)
    {
        //地址选择
        FBAddressViewController *Avc =[[FBAddressViewController alloc]init];
        Avc.delegate =self;
        Avc.indexPath =indexPath;
        [self.navigationController pushViewController:Avc animated:NO];
    }
    else if(indexPath.row==16)
    {
        //地址导航
        FBLocationPickerViewController *Lpicker =[[FBLocationPickerViewController alloc]init];
        Lpicker.delegate=self;
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:Lpicker];
        [self presentViewController:nav animated:NO completion:nil];
        
    }
    else if(indexPath.row==12){
        //公司成立日期
        FBTimeDayViewController *Timevc =[[FBTimeDayViewController alloc]init];
        Timevc.delegate =self;
        Timevc.D_MaxDate=[NSDate date];
        Timevc.indexPath=indexPath;
        Timevc.contentTitle = arr_names[indexPath.row];
        [self.navigationController pushViewController:Timevc animated:NO];
    }
    else if(indexPath.row==13)
    {
        //营业期限
        FBTimeTwoViewController *TTvc =[[FBTimeTwoViewController alloc]init];
        TTvc.delegate =self;
        TTvc.indexpath =indexPath;
        TTvc.contenttitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TTvc animated:NO];
        
    }
    else if(indexPath.row==14)
    {
        //主营行业
        FBHangYeViewController *HYvc =[[FBHangYeViewController alloc]init];
        HYvc.delegate =self;
        HYvc.indexPath =indexPath;
        [self.navigationController pushViewController:HYvc animated:NO];
        
    }
    else if(indexPath.row==17)
    {
        //员工人数
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.delegate =self;
        Ovc.indexPath=indexPath;
        Ovc.contentTitle =arr_names[indexPath.row];
        Ovc.option=17;
        [self.navigationController pushViewController:Ovc animated:NO];
    }
        else
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.contentTitle =arr_names[indexPath.row];
        TFvc.indexPath =indexPath;
        TFvc.content = arr_content[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
        
    }
    
}
-(void)img:(UIImage *)img flag:(NSInteger)flag indexPath:(NSIndexPath *)indexPath{
    if (flag ==5) {
        [arr_imgs addObject:img];
    }
    else
    {
        [arr_imgs replaceObjectAtIndex:flag withObject:img];
    }
    
    [arr_content replaceObjectAtIndex:indexPath.row withObject:@"已选择"];
    [tableV reloadData];
    
}
-(void)timeDay:(NSString *)time indexPath:(NSIndexPath *)indexPath
{
    [arr_content replaceObjectAtIndex:indexPath.row withObject:time];
    [tableV reloadData];
}
- (void)locationPicker:(RCLocationPickerViewController *)locationPicker
     didSelectLocation:(CLLocationCoordinate2D)location
          locationName:(NSString *)locationName
         mapScreenShot:(UIImage *)mapScreenShot{
    [arr_content replaceObjectAtIndex:16 withObject:locationName];
    [tableV reloadData];
    
}
-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    [arr_content replaceObjectAtIndex:indexPath.row withObject:address];
    [tableV reloadData];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [arr_content replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadData];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_content replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadData];
}
-(void)hangye:(NSString *)hangye Withindexpath:(NSIndexPath *)indexpath
{
    [arr_content replaceObjectAtIndex:indexpath.row withObject:hangye];
    [tableV reloadData];
}
-(void)timetwo:(NSArray<NSString *> *)timearr indexpath:(NSIndexPath *)indexpath
{
    NSString *str =[NSString stringWithFormat:@"%@至%@",timearr[0],timearr[1]];
    [arr_content replaceObjectAtIndex:indexpath.row withObject:str];
    [tableV reloadData];
}
@end
