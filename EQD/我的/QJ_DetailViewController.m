//
//  QJ_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QJ_DetailViewController.h"
#import "QingJiaDetailModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBTwoButtonView.h"
#import "FBShowImg_TextViewController.h"
#import "ShenPiListModel.h"

@interface QJ_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    QingJiaDetailModel *model_detail;
    NSMutableArray *arr_name;
    NSMutableArray *arr_contents;
    NSInteger number_section;
    
    NSMutableArray *arr_shenpi;
}

@end

@implementation QJ_DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)initData{
    arr_contents =[NSMutableArray arrayWithArray:@[model_detail.leaveCode,model_detail.leaveType,[NSString stringWithFormat:@"%@ ~ %@",model_detail.leaveStartTime,model_detail.leaveEndTime],model_detail.leaveTimes,model_detail.leaveReason]];
    number_section=2;
}
-(void)loadRequestData{
    
    [WebRequest Get_Leave_ByIdWithleaveId:self.model.ID And:^(NSDictionary *dic) {
        NSDictionary *dic2 =dic[Y_ITEMS];
        model_detail =[QingJiaDetailModel mj_objectWithKeyValues:dic2];
        [self initData];
        [tableV reloadData];
    }];
    
    ///查看请假单的审批信息
    [WebRequest Get_Leave_CheckWithleaveId:self.model.ID And:^(NSDictionary *dic) {
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            [arr_shenpi removeAllObjects];
            number_section =number_section +1;
            for (int i=0; i<tarr.count; i++) {
                ShenPiListModel *model =[ShenPiListModel mj_objectWithKeyValues:tarr[i]];
                [arr_shenpi addObject:model];
            }
            
           [tableV reloadData];
        }
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    arr_name =[NSMutableArray arrayWithArray:@[@"请假单编码",@"请假类型",@"请假时间",@"请假天数(天)",@"请假原因"]];
    arr_shenpi = [NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"详情";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    number_section=0;
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==number_section-1) {
        return self.isshenpi==0? 50:1;
    }
    else
    {
        return 1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==number_section-1) {
        FBTwoButtonView *Tview =[[FBTwoButtonView alloc]init];
        [Tview.B_left addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
        [Tview.B_right addTarget:self action:@selector(tongyiClick) forControlEvents:UIControlEventTouchUpInside];
        [Tview setleftname:@"拒绝" rightname:@"同意"];
        return self.isshenpi==0?Tview:nil;
    }
    else
    {
        return nil;
    }
    
}
#pragma  mark - 同意 拒绝请假
-(void)jujueClick
{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"请填写拒绝原因" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"拒绝原因";
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
        }
        else
        {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在拒绝";
            if (self.isRenShi ==1) {
               [WebRequest Set_Leave_ByHRWithleaveId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
                   hud.label.text =dic[Y_MSG];
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [hud hideAnimated:NO];
                       [self.navigationController popViewControllerAnimated:NO];
                   });
               }];
            }
            else
            {
        [WebRequest Set_Leave_ByLeaderWithleaveId:self.model.ID userGuid:user.Guid message:alert.textFields[0].text type:@"2" And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    if (self.isRenShi==1) {
    [WebRequest Set_Leave_ByHRWithleaveId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
        
    }else
    {
    [WebRequest Set_Leave_ByLeaderWithleaveId:self.model.ID userGuid:user.Guid message:@" " type:@"1" And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return number_section;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return model_detail==nil?0:1;
    }
    else if(section==1)
    {
        return arr_contents.count;
    }
    else
    {
        return arr_shenpi.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID0";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
        }
        cell.L_left0.text =model_detail.staffName;
        cell.L_left1.text =[NSString stringWithFormat:@"%@-%@",model_detail.department,model_detail.post];
        cell.L_right0.text=[NSString stringWithFormat:@"手机:%@",model_detail.uname];
        cell.L_right1.text =[NSString stringWithFormat:@"工号:%@",model_detail.JobNumber];
        return cell;
    }
    else if(indexPath.section==1)
    {
        static NSString *cellId=@"cellID1";
        FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row==arr_contents.count-1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.L_left0.text =arr_name[indexPath.row];
        cell.L_right0.text=arr_contents[indexPath.row];
        
        return cell;
 
    }
    else
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
    if (indexPath ==[NSIndexPath indexPathForRow:4 inSection:1]) {
        FBShowImg_TextViewController *SITvc =[[FBShowImg_TextViewController alloc]init];
        SITvc.contentTitle =@"请假原因";
        SITvc.contents=model_detail.leaveReason;
        SITvc.arr_imgs =model_detail.QJ_newImages;
        [self.navigationController pushViewController:SITvc animated:NO];
    }
}



@end
