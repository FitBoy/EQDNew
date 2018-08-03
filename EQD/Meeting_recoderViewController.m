//
//  Meeting_recoderViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Meeting_recoderViewController.h"
#import "DatePicer_AlertView.h"
#import "FBTextVViewController.h"
#import "FBTextFieldViewController.h"
#import "DatePicer_AlertView.h"
#import "FB_twoTongShi2ViewController.h"
#import "FB_twoTongShiChooseViewController.h"
#import "RenWuSearchViewController.h"
@interface Meeting_recoderViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,FB_twoTongShi2ViewControllerDelegate,FB_twoTongShiChooseViewControllerDelegate,RenWuSearchViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    DatePicer_AlertView *date_alert;
    NSMutableArray *arr_guid;
    Search_rewuModel *model_renwu;
    NSString *guid_zeren;
    NSString *guid_yanshou;
}

@end

@implementation Meeting_recoderViewController
#pragma  mark - 任务
-(void)searchRenwumodel:(Search_rewuModel *)model indexpath:(NSIndexPath *)indexPath
{
    model_renwu = model;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model_renwu.taskName];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 单选同事
-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==2) {
        //责任人
        guid_zeren = model_com.userGuid;
    }else if (indexPath.row == 7)
    {
        guid_yanshou = model_com.userGuid;
    }else
    {
        
    }
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model_com.username];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 多选同事
-(void)getChooseArr_model:(NSArray *)arr_tmodel indexpath:(NSIndexPath *)indexpath
{
    NSMutableString *tarr_name = [NSMutableString string];
    NSMutableArray *tarr = [NSMutableArray arrayWithArray:arr_guid];
    for (int i=0; i<arr_tmodel.count; i++) {
        Com_UserModel  *model3  = arr_tmodel[i];
        [tarr_name appendFormat:@"%@ ",model3.username];
        [tarr addObject:model3.userGuid];
    }
    arr_guid = tarr;
    [arr_contents replaceObjectAtIndex:indexpath.row withObject:tarr_name];
    [tableV reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 单行输入框的代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 多行输入框的代理
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    model_renwu=nil;
    arr_guid = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"添加会议记录，并分配任务";
    arr_names =@[@"*决议事项",@"关联父项目",@"*责任人",@"协助人",@"*开始时间",@"*结束时间",@"*验收标准",@"*验收人",@"*验收时间",@"备注"];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请选择",@"请选择",@"请选择",@"请选择",@"请输入",@"请选择",@"请选择",@"请输入"]];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(TianJiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
#pragma  mark - 添加会议记录
-(void)TianJiaClick
{
    NSInteger temp =0;
    for(int i=0 ;i<arr_contents.count;i++)
    {
        
        if (i==1 || i==3 || i==9) {
            if ([arr_contents[i] isEqualToString:@"请选择"] ||[arr_contents[i] isEqualToString:@"请输入"] ) {
                if (i==1) {
                    arr_contents[i] = model_renwu.ID;
                }else
                {
                arr_contents[i] = @" ";
                }
            }else
            {
                }
        }else
        {
        if ([arr_contents[i] isEqualToString:@"请选择"] ||[arr_contents[i] isEqualToString:@"请输入"] ) {
            temp =1;
            break;
        }
        }

    }
    
    if (temp ==0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在添加";
        NSMutableString *assit = [NSMutableString string];
        for (int i=0; i<arr_guid.count; i++) {
            [assit appendFormat:@"%@;",arr_guid[i]];
        }
        if (assit.length >0) {
            assit = [assit substringWithRange:NSMakeRange(0, assit.length-1)];
        }
        NSString *ParentId = model_renwu.ID.length ==0? @"0":model_renwu.ID;
        
        [WebRequest Meeting_task_Add_MeetingTaskWithuserGuid:user.Guid companyId:user.companyId TaskName:arr_contents[0] ParentTaskId:ParentId recipient:guid_zeren assist:assit startTime:arr_contents[4] endTime:arr_contents[5] checkStandard:arr_contents[6] checker:guid_yanshou checkTime:arr_contents[8] departId:user.departId taskDesc:arr_contents[9] meetingNoticeId:self.settingId And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
        hud.label.text =@"参数不完整";
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
        cell.textLabel.font = [UIFont systemFontOfSize:18];
      
    }
    cell.textLabel.text = arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.row ==0 || indexPath.row ==6 || indexPath.row ==9)
   {
       FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
       TVvc.indexpath =indexPath;
       TVvc.delegate =self;
       TVvc.contentTitle=arr_names[indexPath.row];
       TVvc.content =arr_contents[indexPath.row];
       [self.navigationController pushViewController:TVvc animated:NO];
   }else if (indexPath.row ==1)
   {
       //父项目
       RenWuSearchViewController *Svc = [[RenWuSearchViewController alloc]init];
       Svc.delegate =self;
       Svc.indexPath = indexPath;
       [self.navigationController pushViewController:Svc animated:NO];
   }else if (indexPath.row ==2 || indexPath.row ==7)
   {
       FB_twoTongShi2ViewController  *Tvc = [[FB_twoTongShi2ViewController alloc]init];
       Tvc.delegate_tongshiDan =self;
       Tvc.indexPath =indexPath;
       [self.navigationController pushViewController:Tvc animated:NO];
   }else if (indexPath.row ==3)
   {
       FB_twoTongShiChooseViewController *Tvc =[[FB_twoTongShiChooseViewController alloc]init];
       Tvc.delegate_tongshi =self;
       Tvc.indexPath =indexPath;
       Tvc.arr_guid =arr_guid;
       [self.navigationController pushViewController:Tvc animated:NO];
   }else if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 8)
   {
       date_alert.two_btn.B_right.indexpath =indexPath;
       [self.view addSubview:date_alert];
       
   }
   else
   {
       
   }
}




@end
