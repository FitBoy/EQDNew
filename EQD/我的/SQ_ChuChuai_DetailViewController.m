//
//  SQ_ChuChuai_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQ_ChuChuai_DetailViewController.h"
#import "ChuChaiDetailModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "FBTwo_noImg11TableViewCell.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBTextVViewController.h"
#import "FBTwoButtonView.h"
#import "ShenPiListModel.h"
@interface SQ_ChuChuai_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    ChuChaiDetailModel *model_detail;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    NSInteger section_number;
    
    NSMutableArray  *arr_shenpi;
}

@end

@implementation SQ_ChuChuai_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    section_number=2;
    self.navigationItem.title =@"出差详情";
    user =[WebRequest GetUserInfo];
    arr_shenpi =[NSMutableArray arrayWithCapacity:0];
    arr_names =[NSMutableArray arrayWithArray:@[@"出差单编码",@"出差时间段",@"出差时长(h)",@"出差原因",@"出差地点",@"申请时间"]];
    [WebRequest travel_Get_Travel_ByIdWithtravelId:self.model.ID And:^(NSDictionary *dic) {
        model_detail =[ChuChaiDetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        arr_contents =[NSMutableArray arrayWithArray:@[model_detail.travelCode,[NSString stringWithFormat:@"%@~%@",model_detail.travelStartTime,model_detail.travelEndTime],model_detail.travelTimes,model_detail.travelReason,model_detail.travelAddress,model_detail.createTime]];
        [tableV reloadData];
    }];
    
    [WebRequest travel_Get_Travel_CheckWithuserGuidtravelId:self.model.ID And:^(NSDictionary *dic) {
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            section_number=3;
            for (int i=0; i<tarr.count; i++) {
                ShenPiListModel *model =[ShenPiListModel mj_objectWithKeyValues:tarr[i]];
                [arr_shenpi addObject:model];
            }
        }
        [tableV reloadData];
        
    }];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
//    tableV.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);

}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==section_number-1 &&self.isShenPi==1 ) {
        return 50;
    }
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==section_number-1 &&self.isShenPi==1) {
        FBTwoButtonView *tview =[[FBTwoButtonView alloc]init];
        [tview setleftname:@"拒绝" rightname:@"同意"];
        [tview.B_left addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
        [tview.B_right addTarget:self action:@selector(tongyiClick) forControlEvents:UIControlEventTouchUpInside];
        
        return tview;
    }else
    {
        return nil;
    }
}
#pragma  mark - 同意 拒绝
-(void)jujueClick
{
    //拒绝
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入出差原因" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"出差原因";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(alert.textFields[0].text.length==0)
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"输入内容不能为空";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在拒绝";
            if (self.isRenShi ==1) {
                [WebRequest travel_Set_Travel_ByHRWithtravelId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        [self.navigationController popViewControllerAnimated:NO];
                    });
                }];
            }else
            {
            [WebRequest travel_Set_Travel_ByLeaderWithtravelId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
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
    if (self.isRenShi==1) {
        [WebRequest travel_Set_Travel_ByHRWithtravelId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
    }else
    {
        [WebRequest travel_Set_Travel_ByLeaderWithtravelId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return section_number;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1)
    {
        return arr_contents.count;
    }else
    {
        return arr_shenpi.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        FBFour_noimgTableViewCell *cell =[[FBFour_noimgTableViewCell alloc]init];
        cell.L_left0.text =model_detail.createrName;
        cell.L_left1.text =[NSString stringWithFormat:@"%@-%@",model_detail.department,model_detail.post];
        cell.L_right0.text =[NSString stringWithFormat:@"手机:%@",model_detail.uname];
        cell.L_right1.text =[NSString stringWithFormat:@"工号:%@",model_detail.JobNumber];
        return cell;
    }else if (indexPath.section==1)
    {
        if(indexPath.row==1 || indexPath.row==4 ||indexPath.row==3)
        {
            static NSString *cellId=@"cellID143";
            FBTwo_noImg11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FBTwo_noImg11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            if (indexPath.row==3 || indexPath.row==4) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.L_left0.text =arr_names[indexPath.row];
            cell.L_left1.text =arr_contents[indexPath.row];
            return cell;
        }else
        {
        static NSString *cellId=@"cellID1";
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
        static NSString *cellId=@"cellID2";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        ShenPiListModel *model =arr_shenpi[indexPath.row];
        [cell setModel:model];
        return cell;
  
    }
   }

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==3 || indexPath.row==4) {
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.content =arr_contents[indexPath.row];
            TVvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TVvc animated:NO];
        }else
        {
            
        }
    }
}




@end
