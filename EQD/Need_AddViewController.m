//
//  Need_AddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 

#import "Need_AddViewController.h"
#import "PXChooseListViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBOneChoose_TongShiViewController.h"
#import "DatePicer_AlertView.h"
@interface Need_AddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,PXChooseListViewControllerdelegate,FBTextVViewControllerDelegate,FBOneChoose_TongShiViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    NSArray *arr_names2;
    NSMutableArray *arr_contents2;
    UserModel *user;
    FB_PeiXun_ListModel *model_peixun;
    Com_UserModel  *Cuser;
    DatePicer_AlertView  *date_alert;
}

@end

@implementation Need_AddViewController
///自定义的协议代理
-(void)getPeiXunlistModel:(FB_PeiXun_ListModel *)model
{
    model_peixun = model;
    [arr_contents replaceObjectAtIndex:0 withObject:model.theTheme];
    [arr_contents replaceObjectAtIndex:1 withObject:model.theCategory];
    [arr_contents replaceObjectAtIndex:2 withObject:model.trainees];
    [arr_contents replaceObjectAtIndex:3 withObject:model.thedateStart];
    [arr_contents replaceObjectAtIndex:4 withObject:model.thedateEnd];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    }else
    {
        [arr_contents2 replaceObjectAtIndex:indexPath.row withObject:content];
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    }else
    {
        [arr_contents2 replaceObjectAtIndex:indexPath.row withObject:text];
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(BOOL)prefersHomeIndicatorAutoHidden
{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    Cuser = [[Com_UserModel  alloc]init];
    Cuser.userGuid = user.Guid;
    Cuser.username = user.username;
    self.navigationItem.title = @"添加培训需求";
    arr_names =@[@"*培训主题",@"*培训类别",@"*培训对象",@"*培训开始时间",@"*培训结束时间",@"*培训地点",@"关键词",@"其他要求"];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"根据主题来定",@"根据主题来定",@"根据主题来定",@"根据主题来定",@"请输入",@"请输入",@"请输入"]];
    arr_names2 = @[@"*公司名称",@"*联系人",@"*电话",@"*手机",@"QQ"];
    
    arr_contents2 = [NSMutableArray arrayWithArray:@[user.company,user.username,@"请输入",user.uname,@"请输入"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    date_alert.picker.minimumDate = [NSDate date];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    
    [arr_contents replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    
  [date_alert removeFromSuperview];
}
-(void)tijiaoClick
{
    NSInteger temp =0;
    for (int i=0; i<arr_contents.count-2; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] ||[arr_contents[i] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    
    for (int i=0; i<arr_contents2.count-1; i++) {
        if ([arr_contents2[i] isEqualToString:@"请输入"] ||[arr_contents2[i] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    if ([arr_contents[6] isEqualToString:@"请输入"]) {
        [arr_contents replaceObjectAtIndex:6 withObject:@" "];
    }
    if ([arr_contents[7] isEqualToString:@"请输入"]) {
        [arr_contents replaceObjectAtIndex:7 withObject:@" "];
    }
    if ([arr_contents2[4] isEqualToString:@"请输入"]) {
        [arr_contents2 replaceObjectAtIndex:4 withObject:@" "];
    }
    if (temp == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Training_Add_trainingDemandWithuserGuid:user.Guid comid:user.companyId theCategory:arr_contents[1] theTheme:arr_contents[0] keywords:arr_contents[6] trainees:arr_contents[2] thedateStart:arr_contents[3] thedateEnd:arr_contents[4] theplace:arr_contents[5] comName:arr_contents2[0] contacts:Cuser.userGuid contactsName:Cuser.username phone:arr_contents2[2] handset:arr_contents2[3] qq:arr_contents2[4] otherDemand:arr_contents[7] budgetedExpense:model_peixun.budgetedExpense applyId:model_peixun.ID betrainedPostId:model_peixun.betrainedPostId And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
        hud.label.text =@"带*号是必填项";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
}
#pragma  mark - 表的数据源

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section==0?@"培训信息":@"联系方式";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_contents.count:arr_contents2.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = Y_TextFont;
        cell.detailTextLabel.font = Y_TextFontSmall;
    }
    if (indexPath.section==0) {
        cell.textLabel.text =arr_names[indexPath.row];
        cell.detailTextLabel.text = arr_contents[indexPath.row];
        if (indexPath.row==1 || indexPath.row ==2 || indexPath.row ==3 || indexPath.row ==4) {
            cell.accessoryType =UITableViewCellAccessoryNone;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else
    {
        cell.textLabel.text = arr_names2[indexPath.row];
        cell.detailTextLabel.text = arr_contents2[indexPath.row];
        if (indexPath.row==0 ) {
            cell.accessoryType =UITableViewCellAccessoryNone;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        if (indexPath.row==0) {
            //培训主题
            PXChooseListViewController *Lvc = [[PXChooseListViewController alloc]init];
            Lvc.delegate =self;
            [self.navigationController pushViewController:Lvc animated:NO];
        }else if (indexPath.row==3 || indexPath.row==4)
        {
            date_alert.two_btn.B_right.indexpath =indexPath;
            [self.view addSubview:date_alert];
        }
        else if (indexPath.row ==5)
        {
           //培训地点
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =arr_contents[indexPath.row];
            TFvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
        }else if (indexPath.row==6)
        {
           //关键字
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.indexpath =indexPath;
            TVvc.delegate =self;
            TVvc.contentTitle=arr_names[indexPath.row];
            TVvc.content =arr_contents[indexPath.row];
            [self.navigationController pushViewController:TVvc animated:NO];
        }else if (indexPath.row==7)
        {
           //其他要求
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.indexpath =indexPath;
            TVvc.delegate =self;
            TVvc.contentTitle=arr_names[indexPath.row];
            TVvc.content =arr_contents[indexPath.row];
            [self.navigationController pushViewController:TVvc animated:NO];
        }else
        {
            
        }
    }else
    {
     if(indexPath.row ==1)
     {
         //联系人
         FBOneChoose_TongShiViewController *TSvc = [[FBOneChoose_TongShiViewController alloc]init];
         TSvc.delegate =self;
         TSvc.indexpath =indexPath;
         [self.navigationController pushViewController:TSvc animated:NO];
     }else if (indexPath.row==2)
     {
         //电话
         FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
         TFvc.delegate =self;
         TFvc.indexPath =indexPath;
         TFvc.content =arr_contents2[indexPath.row];
         TFvc.contentTitle =arr_names2[indexPath.row];
         [self.navigationController pushViewController:TFvc animated:NO];
     }else if (indexPath.row ==3)
     {
         //手机
         FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
         TFvc.delegate =self;
         TFvc.indexPath =indexPath;
         TFvc.content =arr_contents2[indexPath.row];
         TFvc.contentTitle =arr_names2[indexPath.row];
         [self.navigationController pushViewController:TFvc animated:NO];
     }else if (indexPath.row==4)
     {
         //qq
         FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
         TFvc.delegate =self;
         TFvc.indexPath =indexPath;
         TFvc.content =arr_contents2[indexPath.row];
         TFvc.contentTitle =arr_names2[indexPath.row];
         [self.navigationController pushViewController:TFvc animated:NO];
     }else
     {
         
     }
    }
}

-(void)chooseModel:(Com_UserModel *)model indexpath:(NSIndexPath *)indepPath
{
    [arr_contents2 replaceObjectAtIndex:1 withObject:model.username];
    [tableV reloadRowsAtIndexPaths:@[indepPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
