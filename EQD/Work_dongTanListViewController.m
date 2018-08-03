//
//  Work_dongTanListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Work_dongTanListViewController.h"
#import "FX_MyRiZhiViewController.h"
#import "FX_riZhiViewController.h"
#import "ZuiJinRenWu_ViewController.h"
#import "BuMenAndPersonViewController.h"
#import "FB_twoTongShi2ViewController.h"
#import "Meeting_noticeViewController.h"
#import "RedTip_LabelTableViewCell.h"
@interface Work_dongTanListViewController ()<UITableViewDelegate,UITableViewDataSource,BuMenAndPersonViewControllerDelegate,FB_twoTongShi2ViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    UserModel *user;
    NSMutableArray *arr_code;
}

@end

@implementation Work_dongTanListViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self message_recived];
}
///选中的部门人员
-(void)getComModel:(Com_UserModel *)model_com
{
    FX_MyRiZhiViewController  *Mvc =[[FX_MyRiZhiViewController alloc]init];
    Mvc.temp =2;
    Mvc.otherGuid = model_com.userGuid;
    [self.navigationController pushViewController:Mvc animated:NO];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"查看工作";
    arr_names = [NSMutableArray arrayWithArray:@[@"全部工作动态",@"企业日志动态",@"我的日志",@"当天任务",@"会议通知"]];
    if ([user.isleader integerValue]==1) {
        [arr_names addObject:@"部门日志"];
    }
    if ([user.isAdmin integerValue]==2) {
        [arr_names addObject:@"企业日志"];
    }
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recived) name:Z_FB_message_received object:nil];

}

-(void)message_recived
{
    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray  *tarr = dic[Y_ITEMS];
            arr_code = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0"]];
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==400 ||[dic2[@"code"] integerValue]==401 || [dic2[@"code"] integerValue]==402 ) {
                    ///企业日志动态
                    [arr_code replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",[arr_code[1] integerValue]+[dic2[@"count"] integerValue]]];
                }
                else
                {
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
            
        }
    }];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    RedTip_LabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RedTip_LabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    if ([arr_code[indexPath.row] integerValue]>0) {
        cell.L_RedTip.hidden =NO;
        cell.L_RedTip.text = arr_code[indexPath.row];
    }else
    {
        cell.L_RedTip.hidden =YES;
    }
    cell.textLabel.text  =arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [arr_code replaceObjectAtIndex:indexPath.row withObject:@"0"];
  //  @[@"工作动态",@"日志动态",@“我的日志”，@"我的客户",@"最近任务"]
    if (indexPath.row==0) {
        //工作动态
        FX_riZhiViewController  *Rvc =[[FX_riZhiViewController alloc]init];
        [self.navigationController pushViewController:Rvc animated:NO];
    }else if (indexPath.row==1)
    {
        //日志动态
        FX_MyRiZhiViewController  *Mvc =[[FX_MyRiZhiViewController alloc]init];
        Mvc.temp =1;
        [self.navigationController pushViewController:Mvc animated:NO];
    }else if (indexPath.row==2)
    {
        //我的日志
        FX_MyRiZhiViewController  *Mvc =[[FX_MyRiZhiViewController alloc]init];
        Mvc.temp =0;
        [self.navigationController pushViewController:Mvc animated:NO];
    }else if (indexPath.row==3)
    {
        //最近任务
        ZuiJinRenWu_ViewController  *Rvc = [[ZuiJinRenWu_ViewController alloc]init];
        [self.navigationController pushViewController:Rvc animated:NO];
    }else if (indexPath.row ==4)
    {
        //会议通知
        Meeting_noticeViewController  *MNvc = [[Meeting_noticeViewController alloc]init];
        [self.navigationController pushViewController:MNvc animated:NO];
    }
    else
    {
        if ([arr_names[indexPath.row] isEqualToString:@"部门日志"]) {
         //部门日志
            BuMenAndPersonViewController  *Pvc = [[BuMenAndPersonViewController alloc]init];
            Pvc.delegate_person = self;
            [self.navigationController pushViewController:Pvc animated:NO];
        }else if ([arr_names[indexPath.row] isEqualToString:@"企业日志"])
        {
            FB_twoTongShi2ViewController  *TWvc = [[FB_twoTongShi2ViewController alloc]init];
            TWvc.delegate_tongshiDan = self;
            [self.navigationController pushViewController:TWvc animated:NO];
        }else
        {
            
        }
    }
}

#pragma  mark - 同事的选择
-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    FX_MyRiZhiViewController  *Mvc =[[FX_MyRiZhiViewController alloc]init];
    Mvc.temp =2;
    Mvc.otherGuid = model_com.userGuid;
    [self.navigationController pushViewController:Mvc animated:NO];
}



@end
