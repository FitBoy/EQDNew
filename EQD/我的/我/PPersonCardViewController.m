//
//  PPersonCardViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PPersonCardViewController.h"
#import "MyFirstTableViewCell.h"
#import "Com_UserModel.h"
#import "FBTwo_noimg12TableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "FBMyErWeiMaViewController.h"
#import "FBConversationViewControllerViewController.h"
#import "SetPerson_QuanXianViewController.h"
#import "FBShareViewController.h"
#import "FBGeRenCardMessageContent.h"
@interface PPersonCardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    Com_UserModel *model;
    NSMutableArray *arr_two;
    NSMutableArray *arr_three;
    UserModel *user;
}

@end

@implementation PPersonCardViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_User_BusinessCardWithuserGuid:self.userGuid And:^(NSDictionary *dic) {
        NSNumber *number = dic[Y_STATUS];
        if ([number integerValue]==200) {
            NSDictionary *dic1=dic[Y_ITEMS];
            model = [Com_UserModel mj_objectWithKeyValues:dic1];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"服务器错误";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title=@"个人名片";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    arr_two = [NSMutableArray arrayWithArray:@[@"手机号",@"地区"]];
    arr_three = [NSMutableArray arrayWithArray:@[@"公司",@"部门职务"]];
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreClick)];
    [self.navigationItem setRightBarButtonItem:right];
   }
-(void)moreClick
{
    //更多
    NSArray *tarr =@[@"设置工作圈权限",@"发送该名片",@"删除"];
    UIAlertController  *alert = [[UIAlertController alloc]init];
    for (int i=0; i<tarr.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(i==0)
            {
                SetPerson_QuanXianViewController  *QXvc =[[SetPerson_QuanXianViewController alloc]init];
                QXvc.userGuid =model.userGuid;
                [self.navigationController pushViewController:QXvc animated:NO];
                
            }else if (i==1)
            {
                FBShareViewController  *Svc =[[FBShareViewController alloc]init];
                FBGeRenCardMessageContent  *content = [[FBGeRenCardMessageContent alloc]initWithgeRenCardWithcontent:@{@"imgurl":model.photo,@"name":model.upname,@"bumen":model.department,@"gangwei":model.post,@"company":model.company,@"uid":model.userGuid,@"comid":model.companyId}];
                Svc.messageContent =content;
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Svc];
                [self presentViewController:nav animated:NO completion:nil];
            }else if (i==2)
            {
                UIAlertController  *alert1 =[UIAlertController alertControllerWithTitle:nil message:@"您确定删除？" preferredStyle:UIAlertControllerStyleActionSheet];
                [alert1 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeAnnularDeterminate;
                    hud.label.text = @"正在删除";
                    [WebRequest  User_Friend_DeleteWithuserGuid:user.Guid friendGuid:model.userGuid And:^(NSDictionary *dic) {
                        hud.label.text =dic[Y_MSG];
                        if ([dic[Y_STATUS] integerValue]==200) {
                            [self.navigationController popViewControllerAnimated:NO];
                        }
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [hud hideAnimated:NO];
                        });
                    }];
                    
                }]];
                [alert1 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                [self presentViewController:alert1 animated:NO completion:nil];
                
            }else
            {
                
            }
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(model)
    {
        if (section==1||section==2) {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    else
    {
    return 0;
    }
}
-(void)erWeimaclick{
    NSLog(@"二维码");
    FBMyErWeiMaViewController  *EWMvc =[[FBMyErWeiMaViewController alloc]init];
//    EWMvc.hidesBottomBarWhenPushed=YES;
    EWMvc.isOther=YES;
    EWMvc.C_user =model;
    [self .navigationController pushViewController:EWMvc animated:NO];
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellid1 =@"cellid1";
        MyFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[MyFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [cell.IV_headimg setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        cell.L_name.text = model.upname;
        cell.L_zhanghao.text=[NSString stringWithFormat:@"易企点号：%@",model.EQDCode];
          [cell.B_erWeima addTarget:self action:@selector(erWeimaclick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if(indexPath.section==1|| indexPath.section==2)
    {
        static NSString *cellid12 =@"cellid12";
        FBTwo_noimg12TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid12];
        if (!cell) {
            cell=[[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid12];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section==1) {
            cell.L_left0.text =arr_two[indexPath.row];
            cell.L_right0.text = indexPath.row==0?model.uname:model.location;
        }
        else
        {
            cell.L_left0.text = arr_three[indexPath.row];
            cell.L_right0.text=indexPath.row==0?model.company:[NSString stringWithFormat:@"%@/ %@",model.department,model.post];
        }
        
        return cell;
    }
    else
    {
        static NSString *cellid30=@"cellid30";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid30];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid30];
            cell.textLabel.font=[UIFont systemFontOfSize:18];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        cell.textLabel.text = @"发消息";
        return cell;
        
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        //发消息
        FBConversationViewControllerViewController  *oneTooneChat =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.userGuid];
        oneTooneChat.navigationItem.title =model.upname;
        RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:model.userGuid name:model.upname portrait:model.photo];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.userGuid];
//        oneTooneChat.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:oneTooneChat animated:NO];
    }
}



@end
