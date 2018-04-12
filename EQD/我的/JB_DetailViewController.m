//
//  JB_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "JB_DetailViewController.h"
#import "JiaBan_DetailModel.h"
#import "ShenPiListModel.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBTwo_noImg11TableViewCell.h"
#import "FBTwoButtonView.h"
@interface JB_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    JiaBan_DetailModel *model_detail;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    NSMutableArray *arr_shenpi;
}

@end

@implementation JB_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"详情";
    user =[WebRequest GetUserInfo];
    arr_shenpi =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    arr_names =[NSMutableArray arrayWithArray:@[@"申请人",@"加班单编码",@"加班时间段",@"加班时长(h)",@"加班类型",@"加班原因",@"提交时间"]];
  //审批详情
    [WebRequest OverTimes_Get_OverTime_ByIdWithoverTimeId:self.model.ID And:^(NSDictionary *dic) {
        model_detail =[JiaBan_DetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        arr_contents =[NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%@【%@-%@】",model_detail.createrName,model_detail.department,model_detail.post],model_detail.overTimeCode, [NSString stringWithFormat:@"%@ ~ %@",model_detail.startOverTime,model_detail.endOverTime],model_detail.times,model_detail.overTimeType,model_detail.overTimeReason,model_detail.createTime]];
        [tableV reloadData];
    }];
    //审批记录
    [WebRequest OverTimes_Get_OverTime_CheckWithoverTimeId:self.model.ID And:^(NSDictionary *dic) {
        
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                ShenPiListModel *model =[ShenPiListModel mj_objectWithKeyValues:tarr[i]];
                [arr_shenpi addObject:model];
            }
        }
        [tableV reloadData];
    }];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1 && self.isShenPi==1) {
        return 50;
    }else
    {
        return 1;
    }
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1 && self.isShenPi==1) {
        FBTwoButtonView *tview =[[FBTwoButtonView alloc]init];
        [tview setleftname:@"拒绝" rightname:@"同意"];
        [tview.B_left addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
        [tview.B_right addTarget:self action:@selector(tongyiClick) forControlEvents:UIControlEventTouchUpInside];
        
        return tview;
    }return nil;
}
-(void)jujueClick
{
    //拒绝
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入拒绝理由" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields[0].text.length==0) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"输入内容不能为空";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在拒绝";
            if (self.isRenShi ==1) {
                [WebRequest OverTimes_Set_OverTime_ByHRWithoverTimeId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        [self.navigationController popViewControllerAnimated:NO];
                    });
                }];
                
            }else
            {
       
        [WebRequest OverTimes_Set_OverTime_ByCheckerWithoverTimeId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
            }
            
        }
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
    
}
-(void)tongyiClick
{
    //同意
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    if (self.isRenShi ==1) {
        [WebRequest OverTimes_Set_OverTime_ByHRWithoverTimeId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }else
    {
    [WebRequest OverTimes_Set_OverTime_ByCheckerWithoverTimeId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    }
}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_contents.count:arr_shenpi.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==2) {
            FBTwo_noImg11TableViewCell *cell =[[FBTwo_noImg11TableViewCell alloc]init];
            cell.L_left0.text =arr_names[indexPath.row];
            cell.L_left1.text=arr_contents[indexPath.row];
            return cell;
        }
        else
        {
        
        static NSString *cellId=@"cellID0";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_right0.text =arr_contents[indexPath.row];
        return cell;
        }
    }else
    {
        static NSString *cellId=@"cellID1";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        ShenPiListModel *model =arr_shenpi[indexPath.row];
        [cell setModel:model];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
