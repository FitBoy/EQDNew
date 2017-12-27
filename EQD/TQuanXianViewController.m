//
//  TQuanXianViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/3.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define Y_adminName @"Y_adminName"
#import "TQuanXianViewController.h"
#import "QuanXianSheZhiTableViewCell.h"
#import "ShenPiListModel.h"
#import "FBOneChoose_TongShiViewController.h"
#import "SheZhi_LizhiViewController.h"
@interface TQuanXianViewController ()<UITableViewDelegate,UITableViewDataSource,FBOneChoose_TongShiViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_contents;
    UserModel *user;
    NSString *LeaderName;
    NSString *status;
    NSString *adminName;
    
}

@end

@implementation TQuanXianViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest SetUp_Get_Approver_ByNWithcompanyId:user.companyId userGuid:user.Guid And:^(NSDictionary *dic) {
        [arr_contents removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            ShenPiListModel *model =[ShenPiListModel mj_objectWithKeyValues:tarr[i]];
            [arr_contents addObject:model];
        }
        [tableV reloadData];
    }];
    
    
    [WebRequest Com_Get_TopAdminWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        LeaderName =dic[Y_ITEMS];
        status=dic[Y_STATUS];
        [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
    if ([user.isAdmin integerValue]==2) {
        
        [WebRequest SetUp_Get_Company_AdminWithcompanyId:user.companyId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *dic2 =dic[Y_ITEMS];
                adminName = dic2[@"name"];
                [USERDEFAULTS setObject:adminName forKey:Y_adminName];
                [USERDEFAULTS synchronize];
            }
            
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"权限设置";
    arr_contents=[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    LeaderName =@"未设置";
    adminName =[USERDEFAULTS objectForKey:Y_adminName];
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [user.isAdmin integerValue]==2?4:3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if(section==1)
    {
        return arr_contents.count ;
    }else if(section==2)
    {
        return 1;
    }else if (section==3)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section<4)
    {
    static NSString *cellId=@"cellID";
    QuanXianSheZhiTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[QuanXianSheZhiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle
        =UITableViewCellSelectionStyleNone;
    }
        cell.B_right0.indexpath =indexPath;
        [cell.B_right0 addTarget:self action:@selector(xiugaiClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if(indexPath.section==0)
        {
            cell.L_left0.text =@"最高领导人";
            cell.L_right0.text =LeaderName;
            cell.L_right0.hidden=NO;
            if(![LeaderName isEqualToString:@"未设置"])
            {
                cell.B_right0.hidden =YES;
            }else
            {
                cell.B_right0.hidden=NO;
            }
            [cell.B_right0 setTitle:@"设置" forState:UIControlStateNormal];
        }
        else  if(indexPath.section==1)
        {
        ShenPiListModel *model =arr_contents[indexPath.row];
        cell.L_left0.text =[NSString stringWithFormat:@"%@审批人",model.type];
            cell.L_right0.hidden=NO;
            cell.B_right0.hidden=NO;
        cell.L_right0.text =model.uname;
            cell.B_right0.enabled=YES;
            [cell.B_right0 setTitle:@"修改" forState:UIControlStateNormal];
        }
        else if (indexPath.section==2)
        {
            
            cell.L_left0.text =@"离职审批人设置";
            cell.L_right0.hidden=YES;
            cell.B_right0.hidden=YES;
        }else if (indexPath.section==3)
        {
            cell.L_left0.text =@"企业人事";
            cell.L_right0.text =adminName;
            cell.B_right0.hidden =NO;
            [cell.B_right0 setTitle:@"修改" forState:UIControlStateNormal];
            
        }else
        {
            cell.L_left0.text=nil;
            cell.L_right0.text =nil;
        }
    return cell;
    }
    
    
    else
    {
        return nil;
    }
}

-(void)xiugaiClick:(FBButton*)tbtn
{
    
        FBOneChoose_TongShiViewController *TFvc=[[FBOneChoose_TongShiViewController alloc]init];
        TFvc.indexpath =tbtn.indexpath;
        TFvc.delegate =self;
        [self.navigationController pushViewController:TFvc animated:NO];
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.section==2)
  {
      //离职审批设置
      SheZhi_LizhiViewController  *SZvc =[[SheZhi_LizhiViewController alloc]init];
      [self.navigationController pushViewController:SZvc animated:NO];
  }else
  {
  }
}

#pragma  mark - 自定义的协议代理
-(void)chooseModel:(Com_UserModel *)model indexpath:(NSIndexPath *)indepPath
{
    if (indepPath.section==1) {
    ShenPiListModel *model2 =arr_contents[indepPath.row];
       
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
        if ([model2.type isEqualToString:@"通知"] || [model2.type isEqualToString:@"公告"]) {
            NSString *tstr =nil;
            if ([model2.type isEqualToString:@"通知"]) {
                tstr =@"1";
            }else if ([model2.type isEqualToString:@"公告"])
            {
                tstr =@"2";
            }
   [WebRequest SetUp_Set_News_ApproverWithcompanyId:user.companyId userGuid:user.Guid approver:model.userGuid Id:model2.ID type:tstr And:^(NSDictionary *dic) {
       hud.label.text =dic[Y_MSG];
       if ([dic[Y_STATUS] integerValue]==200) {
           QuanXianSheZhiTableViewCell *cell =[tableV cellForRowAtIndexPath:indepPath];
           cell.L_right0.text =model.username;
       }
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [hud hideAnimated:NO];
       });
       
   }];
        }else if ([model2.type isEqualToString:@"车辆管理员"] || [model2.type isEqualToString:@"车辆维修员"])
        {
            [WebRequest Com_Vehicle_Set_vehicleAdminWithuserGuid:user.Guid comid:user.companyId adminGuid:model.userGuid adminName:model.username type:model2.type And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                if ([dic[Y_STATUS] integerValue]==200) {
                    QuanXianSheZhiTableViewCell *cell =[tableV cellForRowAtIndexPath:indepPath];
                    cell.L_right0.text =model.username;
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
            }];
            
        }else
        {
        }
    }else if(indepPath.section==0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在设置";
        [WebRequest SetUp_Set_TopLeadersWithuserGuid:user.Guid companyId:user.companyId topLeader:model.userGuid And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                QuanXianSheZhiTableViewCell *cell =[tableV cellForRowAtIndexPath:indepPath];
                cell.L_right0.text =model.username;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
    }else if (indepPath.section==3)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在修改";
        
        [WebRequest SetUp_Set_Admin_ByCompanyWithcompanyId:user.companyId userGuid:user.Guid objecter:model.userGuid And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if ([dic[Y_STATUS] integerValue]==200) {
                adminName = model.username;
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
                
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud  hideAnimated:NO];
            });
        }];
        
    }else
    {
    }
    
}


@end
