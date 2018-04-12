//
//  ThreeRenShiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ThreeRenShiViewController.h"
#import "RSDangAnViewController.h"
#import "RSZuZhiViewController.h"
#import "TQuanXianViewController.h"
#import "TZhaoPinViewController.h"
#import "TRSJiXiaoViewController.h"
#import "TRFuLiViewController.h"
#import "Manager_LaoDongHeTongViewController.h"
#import "TRSKaoQinViewController.h"

#import "TRSHRToolsViewController.h"
#import "TRSWenHuaViewController.h"
#import "TRSGongGaoViewController.h"
#import "RSShenPi_ViewController.h"
#import "RedTip_LabelTableViewCell.h"
#import "FB_PeiXunManagerViewController.h"
#import "RS_CaiWuViewController.h"
@interface ThreeRenShiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    UserModel *user;
    NSMutableArray *arr_code;
    NSInteger  code_reshi;
}

@end

@implementation ThreeRenShiViewController
/*
 @[@[@"人事的审批"],@[@"组织管理",@"考勤管理",@"招聘管理",@"培训管理",@"绩效管理",@"薪酬/福利管理"],@[@"员工档案管理",@"劳动合同管理"],@[@"权限设置",@"公告管理",@"人力资源工具",@"企业文化"]]
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self message_recieved];
}
-(BOOL)prefersHomeIndicatorAutoHidden
{
    return NO;
}
-(void)message_recieved
{
    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
             code_reshi=0;
            //员工档案  劳动合同
            arr_code = [NSMutableArray arrayWithArray:@[@"0",@"0"]];
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 = tarr[i];
                if ([dic2[@"code"] integerValue]==151) {
                    //
                    [arr_code replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@",dic2[@"count"]]];
                }else if ([dic2[@"code"] integerValue]==161)
                {
                    [arr_code replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@",dic2[@"count"]]];
                }else if ([dic2[@"code"] integerValue]==101||[dic2[@"code"] integerValue]==111||[dic2[@"code"] integerValue]==121||[dic2[@"code"] integerValue]==251||[dic2[@"code"] integerValue]==241||[dic2[@"code"] integerValue]==261||[dic2[@"code"] integerValue]==281||[dic2[@"code"] integerValue]==301)
                {
                    //人事的审批
                    code_reshi = code_reshi+[dic2[@"count"] integerValue];
                    
                }else
                {
                }
            
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"人事";
    arr_names =[NSMutableArray arrayWithArray:@[@[@"人事的审批"],@[@"组织管理",@"考勤管理",@"招聘管理",@"培训管理",@"财务管理"],@[@"员工档案管理",@"劳动合同管理"],@[@"权限设置",@"公告-小喇叭管理",@"企业文化"]]];//
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(message_recieved) name:Z_FB_message_received object:nil];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_names.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tarr =arr_names[section];
    return tarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    RedTip_LabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RedTip_LabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font=[UIFont systemFontOfSize:17];
    }
    NSArray *tarr =arr_names[indexPath.section];
    cell.textLabel.text =tarr[indexPath.row];
    if (indexPath.section==0) {
        if (code_reshi >0) {
            cell.L_RedTip.hidden=NO;
            cell.L_RedTip.text = [NSString stringWithFormat:@"%ld",code_reshi];
        }else
        {
            cell.L_RedTip.hidden=YES;
        }
    }else if (indexPath.section==2)
    {
        if ([arr_code[indexPath.row] integerValue]>0) {
            cell.L_RedTip.hidden=NO;
            cell.L_RedTip.text = arr_code[indexPath.row];
        }else
        {
            cell.L_RedTip.hidden=YES;
        }
    }else
    {
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            //人事的审批
            RSShenPi_ViewController *SPvc =[[RSShenPi_ViewController alloc]init];
            [self.navigationController pushViewController:SPvc animated:NO];
        }
        else
        {
            
        }
    }
    
    else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            //组织管理
            RSZuZhiViewController *ZZvc =[[RSZuZhiViewController alloc]init];
            [self.navigationController pushViewController:ZZvc animated:NO];
        }
        else if (indexPath.row==1)
        {
           //考勤管理
            TRSKaoQinViewController *KQvc =[[TRSKaoQinViewController alloc]init];
            [self.navigationController pushViewController:KQvc animated:NO];
        }else if (indexPath.row==2)
        {
            //招聘管理
        }else if (indexPath.row==3)
        {
            //培训管理
            FB_PeiXunManagerViewController  *Mvc =[[FB_PeiXunManagerViewController alloc]init];
            [self.navigationController pushViewController:Mvc animated:NO];
        }else if(indexPath.row==4)
        {
            //财务管理
            RS_CaiWuViewController *CWvc = [[RS_CaiWuViewController alloc]init];
            [self.navigationController pushViewController:CWvc animated:NO];
            
        }
        else
        {
            
        }
    }
    else if(indexPath.section==2)
    {
        if (indexPath.row==0) {
            //员工档案管理
            RSDangAnViewController *DAvc =[[RSDangAnViewController alloc]init];
            [self.navigationController pushViewController:DAvc animated:NO];
        }
        else if (indexPath.row==1)
        {
            //劳动合同管理
            Manager_LaoDongHeTongViewController *LDHTvc =[[Manager_LaoDongHeTongViewController alloc]init];
            [self.navigationController pushViewController:LDHTvc animated:NO];
        }
        else
        {
            
        }
    }
    else if (indexPath.section==3)
    {
        if (indexPath.row==0) {
            //权限设置
            TQuanXianViewController *QXvc =[[TQuanXianViewController alloc]init];
            
            [self.navigationController pushViewController:QXvc animated:NO];
        }else if (indexPath.row==1)
        {
            //公告管理
            TRSGongGaoViewController *GGvc =[[TRSGongGaoViewController alloc]init];
            [self.navigationController pushViewController:GGvc animated:NO];
        }else if (indexPath.row==2)
        {
            //企业文化
            TRSWenHuaViewController *WHvc =[[TRSWenHuaViewController alloc]init];
            [self.navigationController pushViewController:WHvc animated:NO];

        }
        else
        {
            
        }
    }
    
    
   
      /*
           //招聘管理
            TZhaoPinViewController *ZPvc =[[TZhaoPinViewController alloc]init];
            [self.navigationController pushViewController:ZPvc animated:NO];
       
            //绩效管理
            TRSJiXiaoViewController  *JXvc =[[TRSJiXiaoViewController alloc]init];
            [self.navigationController pushViewController:JXvc animated:NO];
       
            //薪酬福利管理
            TRFuLiViewController *FLvc =[[TRFuLiViewController alloc]init];
            [self.navigationController pushViewController:FLvc animated:NO];
            
      
            //人力资源工具
            TRSHRToolsViewController *HRTvc =[[TRSHRToolsViewController alloc]init];
            [self.navigationController pushViewController:HRTvc animated:NO];
            
                    //企业文化
       
       */
}




@end
