//
//  LateLeaver_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LateLeaver_DetailViewController.h"
#import "PPersonCardViewController.h"
#import "FBShowImg_TextViewController.h"
#import "ShenPiListModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "DaKa_DetailViewController.h"
#import "FBTwoButtonView.h"
@interface LateLeaver_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    LaterModel *model_detail ;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UITableView *tableV;
    NSMutableArray *arr_shenpi;
    UserModel *user;
}

@end

@implementation LateLeaver_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =self.isShenPi<3? @"消迟到早退详情":@"消漏打卡详情";
    arr_shenpi =[NSMutableArray arrayWithCapacity:0];
    arr_names =[NSMutableArray arrayWithArray:@[@"编码",@"申请人",@"要消的日期",@"要消的时间点",@"图文原因"]];
    if (self.isShenPi<3) {
        [WebRequest Sickleaves_Get_SickleaveByIdWithsickLeaveId:self.model.ID And:^(NSDictionary *dic) {
            model_detail = [LaterModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            NSMutableString *str_times =[NSMutableString string];
            for (int i=0; i<model_detail.choseTimes.count; i++) {
                DaKaJiLu *jilu =model_detail.choseTimes[i];
                [str_times appendFormat:@"%@  ",jilu.createTime];
            }
            arr_contents =[NSMutableArray arrayWithArray:@[model_detail.code,model_detail.createrName,model_detail.choseDate,str_times,model_detail.reason]];
            if (model_detail.witnessName!=nil) {
                [arr_names addObject:@"证明人"];
                [arr_contents addObject:model_detail.witnessName];
            }else
            {
            }
            [tableV reloadData];
        }];
        
        [WebRequest Sickleaves_Get_Sickleave_CheckWithsickleaveId:self.model.ID And:^(NSDictionary *dic) {
            NSArray *tarr =dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                ShenPiListModel *model =[ShenPiListModel mj_objectWithKeyValues:tarr[i]];
                [arr_shenpi addObject:model];
            }
            [tableV reloadData];
        }];
   
    }else
    {
        [WebRequest Sickleaves_Get_MissClock_ByIdWithmissClockId:self.model.ID And:^(NSDictionary *dic) {
            model_detail = [LaterModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            NSMutableString *str_times =[NSMutableString string];
            for (int i=0; i<model_detail.times.count; i++) {
                TimeChild *jilu =model_detail.times[i];
                [str_times appendFormat:@"%@  ",jilu.time_type];
            }
            arr_contents =[NSMutableArray arrayWithArray:@[model_detail.code,model_detail.createName,model_detail.choseDate,str_times,model_detail.reason]];
            if (model_detail.witnessName!=nil) {
                [arr_names addObject:@"证明人"];
                [arr_contents addObject:model_detail.witnessName];
            }else
            {
            }
            [tableV reloadData];
            
        }];
        
        [WebRequest Sickleaves_Get_MissClock_CheckWithmissClockId:self.model.ID And:^(NSDictionary *dic) {
            NSArray *tarr =dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                ShenPiListModel *model =[ShenPiListModel mj_objectWithKeyValues:tarr[i]];
                [arr_shenpi addObject:model];
            }
            [tableV reloadData];
        }];
        
    }
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.rowHeight=50;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_contents.count:arr_shenpi.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font =[UIFont systemFontOfSize:13];
        }
        if (indexPath.row==0 || indexPath.row==2) {
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        if (indexPath.row==3 && self.isShenPi>2) {
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        cell.textLabel.text =arr_names[indexPath.row];
        cell.detailTextLabel.text =arr_contents[indexPath.row];
        return cell;
    }else
    {
        static NSString *cellId=@"cellID1";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.font =[UIFont systemFontOfSize:13];
        }
        ShenPiListModel *model =arr_shenpi[indexPath.row];
        [cell setModel:model];
        return cell;
    }
   
}

#pragma  mark - 表的协议代理
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1 && self.isShenPi>0 && self.isShenPi!=3) {
        return 50;
    }else
    {
        return 1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1 && self.isShenPi>0 && self.isShenPi!=3) {
        FBTwoButtonView *twoBtn=[[FBTwoButtonView alloc]init];
        [twoBtn setleftname:@"拒绝" rightname:@"同意"];
        [twoBtn.B_left addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
        [twoBtn.B_right addTarget:self action:@selector(tongyiCick) forControlEvents:UIControlEventTouchUpInside];
        return twoBtn;
    }else
    {
        return nil;
    }
}
-(void)jujueClick
{
  //拒绝
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"请输入拒绝理由" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"拒绝理由";
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
        }else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在处理";
            if (self.isShenPi==1) {
                [WebRequest Sickleaves_Set_SickleaveWithuserGuid:user.Guid sickleaveId:self.model.ID message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        [self.navigationController popViewControllerAnimated:NO];
                    });
                }];
                
            }else if (self.isShenPi==2)
            {
                [WebRequest Sickleaves_Set_Sickleave_ByHRWithsickleaveId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        [self.navigationController popViewControllerAnimated:NO];
                    });

                }];
                
            }else if (self.isShenPi==4)
            {
                [WebRequest Sickleaves_Set_MissClock_ByLeaderWithmissClockId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        [self.navigationController popViewControllerAnimated:NO];
                    });
                }];
                
            }else if (self.isShenPi==5)
            {
                [WebRequest Sickleaves_Set_MissClock_ByHRWithmissClockId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        [self.navigationController popViewControllerAnimated:NO];
                    });
                }];
            }
            else
            {
                
            }
        }
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}
-(void)tongyiCick
{
    //同意
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    if (self.isShenPi==1) {
        [WebRequest Sickleaves_Set_SickleaveWithuserGuid:user.Guid sickleaveId:self.model.ID message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }else if(self.isShenPi==2)
    {
        [WebRequest Sickleaves_Set_Sickleave_ByHRWithsickleaveId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }else if (self.isShenPi==4)
    {
        [WebRequest Sickleaves_Set_MissClock_ByLeaderWithmissClockId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }else if (self.isShenPi==5)
    {
        [WebRequest Sickleaves_Set_MissClock_ByHRWithmissClockId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
    }
    
    else
    {
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
            Pvc.userGuid =model_detail.creater;
            [self.navigationController pushViewController:Pvc animated:NO];
        }else if (indexPath.row==3)
        {
            //要消的时间点
            if (self.isShenPi<3) {
                DaKa_DetailViewController *Dvc=[[DaKa_DetailViewController alloc]init];
                Dvc.arr_jilu =model_detail.choseTimes;
                Dvc.date =model_detail.choseDate;
                 [self.navigationController pushViewController:Dvc animated:NO];
            }else
            {
                
            }
            
           
            
        }else if(indexPath.row==4)
        {
            //图文原因
            FBShowImg_TextViewController *Svc =[[FBShowImg_TextViewController alloc]init];
            Svc.contentTitle = @"迟到早退原因";
            Svc.contents = model_detail.reason;
            Svc.arr_imgs = model_detail.images;
            [self.navigationController pushViewController:Svc animated:NO];
        }else if(indexPath.row==5)
        {
            //证明人
            PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
            Pvc.userGuid =model_detail.witness;
            [self.navigationController pushViewController:Pvc animated:NO];
        }else
        {
            
        }
    }
}




@end
