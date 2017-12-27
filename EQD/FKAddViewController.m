//
//  FKAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FKAddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextvImgViewController.h"
#import "GLLianXiRenViewController.h"
#import "FBOptionViewController.h"
#import "DatePicer_AlertView.h"
#import "EventCalendar.h"
@interface FKAddViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextvImgViewControllerDelegate,FBTextFieldViewControllerDelegate,GLLianXiRenViewControllerdelegate,FBOptionViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    DatePicer_AlertView *date_alert;
    NSArray *arr_imgs;
    GLLianXiModel *model_lianxi;
}

@end

@implementation FKAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title=@"添加反馈记录";
    arr_names=[NSMutableArray arrayWithArray:@[@"*反馈标题",@"反馈类型",@"*反馈人",@"反馈内容",@"*反馈时间",@"处理反馈信息的时间提醒",@"反馈地点"]];
    NSArray *tarr = [USERDEFAULTS objectForKey:@"FKAdd"];
    if (tarr==nil) {
         arr_contents=[NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请输入",@"请输入",@"请选择",@"请选择",@"请输入"]];
    }else
    {
        arr_contents = [NSMutableArray arrayWithArray:tarr];
        [arr_contents replaceObjectAtIndex:2 withObject:@"请选择"];
        [arr_contents replaceObjectAtIndex:3 withObject:@"请输入"];
    }
   
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
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
-(void)tijiaoClick
{
    //@[@"反馈标题",@"1反馈类型",@"2反馈人",@"3反馈内容",@"4反馈时间",@"5提醒",@"6地址"]
    NSInteger temp = 0;
    for (int i=0; i<arr_contents.count; i++) {
        if (i==0||i==2||i==4) {
            if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
                temp=1;
                break;
            }
        }else
        {
          if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
              arr_contents[i]=@" ";
          }
        }
    }
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest crmModule_Add_cusfbRecordWithowner:user.Guid comid:user.companyId fbtitle:arr_contents[0] cusid:[USERDEFAULTS objectForKey:Y_ManagerId] fbcontent:arr_contents[3] fbtype:arr_contents[1] addr:arr_contents[6] fberid:model_lianxi.ID fberName:model_lianxi.name fberPhone:model_lianxi.cellphone fbTime:arr_contents[4] remindTime:arr_contents[5] imgArr:arr_imgs And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            if([dic[Y_STATUS] integerValue]==200 && ![arr_contents[5] isEqualToString:@" "])
            {
                NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSDate *date = [formatter dateFromString:arr_contents[5]];
                [[EventCalendar sharedEventCalendar] createEventCalendarTitle:arr_contents[0] location:arr_contents[6] startDate:date endDate:date allDay:NO alarmArray:@[@"-5"]];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"带*的为必填项";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
   
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
        cell.textLabel.font =[UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text=arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0 || indexPath.row==6) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row==1)
    {
        FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.option=30;
        Ovc.delegate =self;
        Ovc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Ovc animated:NO];
    }else if (indexPath.row==2)
    {
        GLLianXiRenViewController *Lvc =[[GLLianXiRenViewController alloc]init];
        Lvc.ischoose=1;
        Lvc.delegate =self;
        [self.navigationController pushViewController:Lvc animated:NO];
    }else if (indexPath.row==3)
    {
        //图文
        FBTextvImgViewController *TIvc =[[FBTextvImgViewController alloc]init];
        TIvc.delegate =self;
        TIvc.indexPath =indexPath;
        TIvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TIvc animated:NO];
    }else if (indexPath.row==4 || indexPath.row==5)
    {
        date_alert.two_btn.B_right.indexpath = indexPath;
        [self.view addSubview:date_alert];
    }else
    {
    }
    
}
#pragma mark- 自定义的协议代理

-(void)text:(NSString *)text imgArr:(NSArray<UIImage *> *)imgArr indexPath:(NSIndexPath *)indexPath
{
    arr_imgs =imgArr;
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)lianxiModel:(GLLianXiModel *)model
{
    model_lianxi = model;
    [arr_contents replaceObjectAtIndex:2 withObject:model.name];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [USERDEFAULTS setObject:arr_contents forKey:@"FKAdd"];
    [USERDEFAULTS synchronize];
}
@end
