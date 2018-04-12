//
//  SQLiZhiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SQLiZhiViewController.h"
#import "Com_UserModel.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBOptionViewController.h"
#import "LZYuanYinViewController.h"
#import "DatePicer_AlertView.h"
@interface SQLiZhiViewController ()<UITableViewDataSource,UITableViewDelegate,FBOptionViewControllerDelegate,LZYuanYinViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView  *date_alert;
    BOOL canTijiao;
}

@end

@implementation SQLiZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    
}
-(void)loadRequestData{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"离职申请";
    user = [WebRequest GetUserInfo];
    
    arr_names = [NSMutableArray arrayWithArray:@[@"申请人",@"工号",@"部门",@"岗位",@"入职时间",@"预计离职时间",@"离职类型",@"离职原因",@"审批人"]];
    arr_contents =[NSMutableArray arrayWithArray:@[user.username,user.jobNumber,user.department,user.post,user.signEntryTime.length==0?@"未签订劳动合同":user.signEntryTime,@"请选择",@"请选择",@"请选择"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
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
                [arr_contents addObject:@"无审批人，请联系管理员"];
            }
            [tableV reloadData];
        }
    }];
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
    [arr_contents  replaceObjectAtIndex:5 withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [date_alert removeFromSuperview];
}
-(void)tianjiaClick
{
    NSInteger flag =0;
    for (int i=5; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请选择"]) {
            flag=1;
            break;
        }
    }
    if (flag==0 && canTijiao ==YES) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest User_QuitWithcompanyId:user.companyId postId:user.postId departId:user.departId userGuid:user.Guid joinTime:@"2017-03-09" quitReason:arr_contents[7] quitType:arr_contents[6] joinNumber:user.jobNumber quitTime:arr_contents[5] And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if(indexPath.row >4)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.L_left0.text =arr_names[indexPath.row];
    cell.L_right0.text=arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==5) {
        //预计离职时间
       
        NSDate *date =[NSDate dateWithTimeInterval:15*24*60*60 sinceDate:[NSDate date]];
        date_alert.picker.minimumDate = date;
        [self.view addSubview:date_alert];
        
    }
    else if(indexPath.row==6)
    {
       //离职类型
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath=indexPath;
        Ovc.option =27;
        Ovc.delegate =self;
        Ovc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Ovc animated:NO];
        
        
    }
    else if(indexPath.row==7)
    {
      //离职原因
        LZYuanYinViewController *YYvc =[[LZYuanYinViewController alloc]init];
        YYvc.delegate =self;
        YYvc.indexpath=indexPath;
        [self.navigationController pushViewController:YYvc animated:NO];
        
    }
    else
    {
        
    }
}

#pragma  mark - 自定义的协议代理
-(void)timeDay:(NSString *)time indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:time];
    [tableV reloadData];
}

-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadData];
}
-(void)reason:(NSString *)reason indexpath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:reason];
    [tableV reloadData];
}
@end
