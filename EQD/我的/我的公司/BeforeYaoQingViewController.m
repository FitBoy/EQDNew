//
//  BeforeYaoQingViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BeforeYaoQingViewController.h"
#import "WebRequest.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBTextFieldViewController.h"
#import "FBOptionViewController.h"
#import "FBAddressViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface BeforeYaoQingViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBOptionViewControllerDelegate,FBAddressViewControllerDelegate>
{
    NSMutableDictionary *dic2;
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    NSMutableArray *arr_contents2;
    UserModel *user;
}

@end

@implementation BeforeYaoQingViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest User_StaffInfoWithuserGuid:user.Guid password:[USERDEFAULTS objectForKey:Y_MIMA] And:^(NSDictionary *dic) {
        dic2 = dic[Y_ITEMS];
        [tableV reloadData];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title = @"先完善个人信息";
    arr_names =[NSMutableArray arrayWithArray:@[@"身高(cm)",@"体重(kg)",@"血型",@"生肖",@"信仰",@"现住址",@"婚否",@"紧急联系人姓名",@"紧急联系人关系",@"紧急联系人电话",@"毕业院校",@"所学专业",@"文化程度",@"职业资格",@"外语等级",@"政治面貌",@"社会保险号(可选)",@"兴趣爱好(可选)",@"qq(可选)",@"微信(可选)"]];
    arr_contents = [NSMutableArray arrayWithArray:@[@"uheigh",@"uweigh",@"ublood",@"uczodia",@"ubelief",@"upadress",@"umarry",@"ucontactname",@"uscontactrelat",@"uscontact",@"ugrad",@"umajor",@"uedu",@"upskill",@"uforeignclass",@"upoliticstate",@"usocialsecuritynum",@"uinterest",@"uqq",@"uwchat"]];
    arr_contents2=[NSMutableArray arrayWithArray:arr_contents];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"接受邀请" style:UIBarButtonItemStylePlain target:self action:@selector(ruzhiClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)ruzhiClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
    NSInteger flag=0;
    for (int i=0; i<arr_contents.count-4; i++) {
        NSString *tstr =[NSString stringWithFormat:@"%@",dic2[arr_contents[i]]];
        if (tstr.length==0) {
            flag=1;
            break;
        }
       
    }
    if (flag==0) {
        [WebRequest User_ApplyForEntryWithuserGuid:user.Guid user:user.uname entryId:self.model.ID And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popToRootViewControllerAnimated:NO];
            });
        }];
    }
    else
    {
        hud.label.text =@"信息不完整";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }
   
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(dic2)
    {
    return arr_names.count;
    }
    else
    {
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.L_left0.text = arr_names[indexPath.row];
    cell.L_right0.text =[NSString stringWithFormat:@"%@",dic2[arr_contents[indexPath.row]]];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//",@17"兴趣爱好(可选)",@"18qq(可选)",@"19微信(可选)"]]
    if (indexPath.row==0||indexPath.row==1||indexPath.row==7||indexPath.row==9||indexPath.row==10||indexPath.row==11||indexPath.row>15) {
        //身高 体重      电话 社会保险号
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath =indexPath;
        TFvc.delegate =self;
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }
    else if(indexPath.row==2)
    {
        //血型
        
        UIAlertController *alert =[[UIAlertController alloc]init];
        NSArray  *tarr = @[@"A型",@"B型",@"AB型",@"O型",@"未知"];
        for (int i=0; i<tarr.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self xiugaiWithcontent:action.title IndexPath:indexPath];
            }]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
        
    }
    else if (indexPath.row==3||indexPath.row==4||indexPath.row==6||indexPath.row==8||indexPath.row==12||indexPath.row==13||indexPath.row==14||indexPath.row==15)
    {
        //生肖
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.contentTitle=arr_names[indexPath.row];
        if (indexPath.row==3) {
            Ovc.option=21;
        }
        else if(indexPath.row==4)
        {
            Ovc.option=25;
        }
        else if(indexPath.row==6)
        {
            Ovc.option=22;
        }
        else if(indexPath.row==8)
        {
            Ovc.option=23;
        }
        else if(indexPath.row==12)
        {
            Ovc.option=10;
        }
        else if(indexPath.row==13)
        {
            Ovc.option=16;
        }
        else if(indexPath.row==14)
        {
            Ovc.option=24;
        }
        else if (indexPath.row==15)
        {
            Ovc.option=15;
        }
        Ovc.delegate=self;
        [self.navigationController pushViewController:Ovc animated:NO];
        
        
    }
    else if (indexPath.row==5)
    {
        //现住址
        FBAddressViewController *AVvc =[[FBAddressViewController alloc]init];
        AVvc.indexPath=indexPath;
        AVvc.delegate=self;
        AVvc.isXiangXi=YES;
        [self.navigationController pushViewController:AVvc animated:NO];
        
    }
}

#pragma mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //身高
        if([content integerValue]>300)
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"身高太高，重新输入";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        else
        {
            [self xiugaiWithcontent:content IndexPath:indexPath];
        }
    }
    else if(indexPath.row==1)
    {
        if ([content integerValue]>300) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"体重最大300kg";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        else
        {
          [self xiugaiWithcontent:content IndexPath:indexPath];
        }
        
    }
    else if (indexPath.row==9)
    {
        //手机号
        if(![RCKitUtility validateCellPhoneNumber:content])
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"手机号输入非法";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        else
        {
            [self xiugaiWithcontent:content IndexPath:indexPath];
        }
    }

    else
    {
        [self xiugaiWithcontent:content IndexPath:indexPath];
    }
}
-(void)xiugaiWithcontent:(NSString*)content IndexPath:(NSIndexPath*)indexPath
{
    
    NSString *para = [NSString stringWithFormat:@"%@='%@'",arr_contents[indexPath.row],content];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest  User_UpdateUserinfoWithuserGuid:user.Guid para:para And:^(NSDictionary *dic) {
        
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self loadRequestData];
            
        });
    }];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithcontent:option IndexPath:indexPath];
}
-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    [self xiugaiWithcontent:address IndexPath:indexPath];
}
@end
