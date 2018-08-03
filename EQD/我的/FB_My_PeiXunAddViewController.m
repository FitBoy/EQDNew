//
//  FB_My_PeiXunAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_My_PeiXunAddViewController.h"
#import "FB_PXChooseViewController.h"
#import "FB_PXLeiBieChooseViewController.h"
#import "FBTextFieldViewController.h"
#import "DatePicer_AlertView.h"
#import "FBTextVViewController.h"

#import "FB_twoTongShi2ViewController.h"
#import "EQDS_SearchViewController.h"
@interface FB_My_PeiXunAddViewController ()<UITableViewDelegate,UITableViewDataSource,FB_PXChooseViewControllerDelegate,FB_PXLeiBieChooseViewControllerdelegate,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,FB_twoTongShi2ViewControllerDelegate,EQDS_SearchViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    NSMutableArray  *arr_chooseModel;
    NSArray  *arr_techerModel;
    DatePicer_AlertView  *date_alert;
    NSString *teacherGuid;
}

@end

@implementation FB_My_PeiXunAddViewController
#pragma  mark - 自定义的协议代理
-(void)getTecherLeiBieModel:(NSArray<FBAddressModel *> *)arr_teachers
{
    arr_techerModel = arr_teachers;
    NSMutableString  *Tstr = [NSMutableString string];
    for (int i=0; i<arr_teachers.count; i++) {
        FBAddressModel  *model = arr_teachers[i];
        if(i==arr_teachers.count-1)
        {
            [Tstr appendString:model.name];
        }else
        {
            [Tstr appendFormat:@"%@,",model.name];
        }
    }
    
    [arr_contents replaceObjectAtIndex:4 withObject:Tstr];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 选择同事
-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    teacherGuid = model_com.userGuid;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model_com.username];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma  mark - 易企学的讲师选择
-(void)getTeacherInfo:(EQDS_teacherInfoModel *)model
{
    teacherGuid = model.userGuid;
    [arr_contents replaceObjectAtIndex:6 withObject:model.realname];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)getGangweiModel:(NSArray<GangweiModel *> *)arr_gangwei
{
    NSMutableString  *Tstr = [NSMutableString string];
    arr_chooseModel =[NSMutableArray arrayWithArray:arr_gangwei];
    for (int i=0; i<arr_gangwei.count; i++) {
        GangweiModel  *model =arr_gangwei[i];
        if (i==arr_gangwei.count-1) {
            [Tstr appendString:model.name];
        }else
        {
        [Tstr appendFormat:@"%@,",model.name];
        }
    }
    [arr_contents replaceObjectAtIndex:3 withObject:Tstr];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    teacherGuid =@" ";
    arr_chooseModel = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"培训申请";
    user = [WebRequest GetUserInfo];
    arr_names = @[@"申请人",@"部门",@"岗位",@"培训对象",@"培训类别",@"培训主题",@"讲师推荐",@"预算费用/元",@"培训开始时间",@"培训结束时间",@"培训要求",@"申请理由",@"审批人"];
    arr_contents = [NSMutableArray arrayWithArray:@[user.username,user.department,user.post,user.post,@"请选择",@"请输入",@"请输入",@"请输入",@"请选择",@"请选择",@"请输入",@"请输入"]];
    [WebRequest Get_User_LeaderWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSString *Tstr = dic[Y_ITEMS];
            if (Tstr.length==0) {
                [arr_contents addObject:@"您是最高领导人"];
            }else
            {
                [arr_contents addObject:Tstr];
            }
        }else
        {
            [arr_contents addObject:@"数据错误,请联系管理员"];
        }
        [tableV reloadData];
    }];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.minimumDate = [NSDate date];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)tijiaoClick
{
    NSInteger temp=0;
    for (int i=0; i<arr_contents.count-1; i++) {
        if ([arr_contents[i] isEqualToString:@"请选择"] || [arr_contents[i] isEqualToString:@"请输入"]) {
            temp=1;
            break;
        }
    }
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        NSMutableString  *IdStr = [NSMutableString string];
        if (arr_chooseModel.count==0) {
            [IdStr appendString: user.postId];
        }else
        {
        for (int i=0; i<arr_chooseModel.count; i++) {
            GangweiModel  *model2 = arr_chooseModel[i];
            if (i==arr_chooseModel.count-1) {
                [IdStr appendString:model2.ID];
            }else
            {
            [IdStr appendFormat:@"%@,",model2.ID];
            }
        }
        }
        [WebRequest Training_Add_trainingApplyWithcomid:user.companyId applicantGuid:user.Guid applicantName:user.username depid:user.departId depName:user.department postid:user.postId postName:user.post trainees:arr_contents[3] theCategory:arr_contents[4] theTheme:arr_contents[5] recoDocentGuid:@" " recoDocentName:arr_contents[6] budgetedExpense:arr_contents[7] thedateStart:arr_contents[8] thedateEnd:arr_contents[9] theDemand:arr_contents[10] theReason:arr_contents[11] betrainedPostId:IdStr And:^(NSDictionary *dic) {
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
        hud.label.text =@"所有内容都是必填的";
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
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    [arr_contents  replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:date_str];
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
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    if(indexPath.row==12 || indexPath.row==1 || indexPath.row==2 || indexPath.row==0)
    {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // arr_names = @[@"申请人",@"部门",@"岗位",@"培训对象",@"培训类别",@"培训主题",@"讲师推荐",@"预算费用",@"培训开始时间",@"培训结束时间",@"培训要求",@"申请理由",@"审批人"];
     if (indexPath.row==3)
    {
        //培训对象
        if ([user.isAdmin integerValue]>0 || [user.isleader integerValue]>0) {
            FB_PXChooseViewController   *Pvc =[[FB_PXChooseViewController alloc]init];
            Pvc.arr_choseModel = arr_chooseModel;
            Pvc.delegate =self;
            [self.navigationController pushViewController:Pvc animated:NO];
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"员工只能选择自己的岗位";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
        
    }else if (indexPath.row==4)
    {
        //培训类别
        FB_PXLeiBieChooseViewController  *Lvc =[[FB_PXLeiBieChooseViewController alloc]init];
        Lvc.delegate =self;
        Lvc.arr_chosemodel = arr_techerModel;
        [self.navigationController pushViewController:Lvc animated:NO];
    }else if (indexPath.row==5  || indexPath.row==7)
    {
        //培训主题    费用预算
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==6)
    {
       //讲师推荐
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"讲师来自？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        NSArray *tarr = @[@"易企学",@"企业内部",@"其他"];
        for(int i=0;i<tarr.count;i++ )
        {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (i==0) {
                    //易企学
                    EQDS_SearchViewController  *Svc = [[EQDS_SearchViewController alloc]init];
                    Svc.delegate =self;
                    [self.navigationController pushViewController:Svc animated:NO];
                    
                }else if (i==1)
                {
                    // 企业内部
                    FB_twoTongShi2ViewController *TSvc =[[FB_twoTongShi2ViewController alloc]init];
                    TSvc.delegate_tongshiDan =self;
                    TSvc.indexPath =indexPath;
                    [self.navigationController pushViewController:TSvc animated:NO];
                    
                }else
                {
                    //其他
                    FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                    TFvc.delegate =self;
                    TFvc.indexPath =indexPath;
                    TFvc.content =arr_contents[indexPath.row];
                    TFvc.contentTitle =@"请输入讲师姓名";
                    [self.navigationController pushViewController:TFvc animated:NO];
                }
                
            }]];
            
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];

        });
    }
    else if (indexPath.row==8|| indexPath.row==9)
    {
        //培训时间
         date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
       
    }else if (indexPath.row==10 || indexPath.row==11)
    {
        //培训要求  申请理由
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
    if (indexPath.row==6) {
        teacherGuid = @" ";
    }
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV  reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
