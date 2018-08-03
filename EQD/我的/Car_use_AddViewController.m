//
//  Car_use_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Car_use_AddViewController.h"
#import "FBTextFieldViewController.h"
#import "DatePicer_AlertView.h"
#import "FBTextVViewController.h"
#import "Car_ChooseByTimeViewController.h"
#import "FB_twoTongShi2ViewController.h"
@interface Car_use_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,Car_ChooseByTimeViewControllerDelegate,FB_twoTongShi2ViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView  *date_alert;
    CarManagerModel *model_only;
    BOOL canTijiao;
}

@end

@implementation Car_use_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"添加用车申请";
    arr_names = @[@"用车开始时间",@"用车结束时间",@"车号",@"出发地",@"目的地",@"司机",@"乘坐人数",@"用车说明",@"审批人"];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请选择",@"请输入",@"请输入",@"请输入",@"请输入",@"请输入"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
  

    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    [WebRequest Get_User_LeaderWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSString *tstr = dic[Y_ITEMS];
            if(tstr.length!=0)
            {
                canTijiao =YES;
                [arr_contents addObject:dic[Y_ITEMS]];
            }else
            {
                canTijiao=NO;
                [arr_contents addObject:@"您是最高领导人"];
            }
            [tableV reloadData];
        }
    }];
}
-(void)tijiaoCLick
{
    //提交
    NSInteger temp =0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请选择"] || [arr_contents[i] isEqualToString:@"请输入"]) {
            temp=1;
            break;
        }
    }
   
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Com_Vehicle_Add_vehicleApplyWithcomid:user.companyId vehicleId:model_only.Id plateNumber:model_only.plateNumber applyer:user.Guid applyerName:user.username applyerDepId:user.departId applyerDepName:user.department startTime:arr_contents[0] endTime:arr_contents[1] origin:arr_contents[3] destination:arr_contents[4] theDriverName:arr_contents[5] personCount:arr_contents[6] theReason:arr_contents[7] theCustomer:@" " theProject:@" " And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
        }];
        
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"所有的内容都是必填项";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
    
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    [arr_contents replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [date_alert removeFromSuperview];
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text=arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///@"用车开始时间",@"用车结束时间",@"车号",@"出发地",@"目的地",@"司机",@"乘坐人数",@"用车说明"
    if(indexPath.row==0 || indexPath.row==1)
    {
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
    }else if (indexPath.row==2)
    {
        //车号 要先判断时间
        if([arr_contents[0] isEqualToString:@"请选择"] || [arr_contents[1] isEqualToString:@"请选择"])
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"请先选择用车时间";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }else
        {
            Car_ChooseByTimeViewController  *Tvc =[[Car_ChooseByTimeViewController alloc]init];
            Tvc.delegate =self;
            Tvc.startTime = arr_contents[0];
            Tvc.endTime =arr_contents[1];
            [self.navigationController pushViewController:Tvc animated:NO];
            
        }
    }else if (indexPath.row==5)
    {
        FB_twoTongShi2ViewController  *TSvc =[[FB_twoTongShi2ViewController alloc]init];
        TSvc.delegate_tongshiDan =self;
        TSvc.indexPath =indexPath;
        [self.navigationController pushViewController:TSvc animated:NO];
    }
    else if ((indexPath.row>2 &&indexPath.row<7 )&&indexPath.row!=5 )
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==7)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }
}

#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getCarmodel:(CarManagerModel *)Cmodel startTime:(NSString *)startTime endTime:(NSString *)endTime
{
    model_only = Cmodel;
    [arr_contents replaceObjectAtIndex:2 withObject:Cmodel.plateNumber];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model_com.username];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
