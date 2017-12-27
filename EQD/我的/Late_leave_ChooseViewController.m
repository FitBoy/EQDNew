//
//  Late_leave_ChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Late_leave_ChooseViewController.h"
#import "DatePicer_AlertView.h"
#import "FBTwoChoose_noimg_TableViewCell.h"
#import "FBButton.h"
@interface Late_leave_ChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    DatePicer_AlertView *date_alert;
    NSString *S_date;
    UserModel *user;
    NSMutableArray *arr_model;
    NSMutableArray *arr_status;
}

@end

@implementation Late_leave_ChooseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Clocks_Get_ClockWithuserGuid:user.Guid companyId:user.companyId date:S_date And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            DaKaJiLu *daka =[DaKaJiLu mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:daka];
        }
        [tableV reloadData];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.isLater==1? @"迟到早退时间点":@"漏打卡时间点";
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    NSDateFormatter  *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    S_date =[dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]]];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:S_date style:UIBarButtonItemStylePlain target:self action:@selector(dateClick)];
    [self.navigationItem setRightBarButtonItem:right];
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    date_alert.picker.maximumDate = [NSDate date];
    date_alert.picker.minimumDate = [NSDate dateWithTimeInterval:-30*24*60*60 sinceDate:[NSDate date]];
    
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    arr_status =[NSMutableArray arrayWithArray:@[@"未开启打卡",@"漏打卡",@"待打卡",@"正常",@"迟到",@"早退"]];
}

-(void)quedingClick
{
    ///确定
    
    
    if ([self.delegate respondsToSelector:@selector(dakaModelArr:indexPath:dateStr:)]) {
        NSMutableArray *tarr =[NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_model.count; i++) {
            DaKaJiLu *model =arr_model[i];
            if (model.ischoose==YES) {
                [tarr addObject:model];
            }
        }
        
        [self.delegate dakaModelArr:tarr indexPath:self.indexPath dateStr:S_date];
        
        
    }
    [self.navigationController popViewControllerAnimated:NO];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwoChoose_noimg_TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwoChoose_noimg_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    DaKaJiLu *model =arr_model[indexPath.row];
    cell.L_left1.text =[NSString stringWithFormat:@"打卡时间:%@   规定时间:%@",model.createTime,model.clockTime];
    cell.L_left0.textColor = [model.status integerValue]==0?[UIColor blackColor]:[UIColor redColor];
    cell.L_left0.text =arr_status[[model.status integerValue]+3];
    if (model.ischoose==NO) {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_tluntan"];
    }else
    {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_landui"];
    }
    
    
    if (self.isLater==1 && ([model.status integerValue]==1 || [model.status integerValue]==2)) {
            cell.IV_choose.hidden =NO;
            cell.userInteractionEnabled =YES;
    }else if (self.isLater==2 && [model.status integerValue]==-2)
    {
        cell.IV_choose.hidden =NO;
        cell.userInteractionEnabled =YES;

    }else
    {
        cell.IV_choose.hidden=YES;
        cell.userInteractionEnabled= NO;
    }
 
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DaKaJiLu *model =arr_model[indexPath.row];
    model.ischoose =!model.ischoose;
    [tableV reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FBButton *tbtn =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:@"确定" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:30]];
    [tbtn addTarget:self action:@selector(quedingClick) forControlEvents:UIControlEventTouchUpInside];
    return tbtn;
}


-(void)dateClick
{
    [self.view addSubview:date_alert];
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    //确定
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    S_date =[formatter stringFromDate:date_alert.picker.date];
    self.navigationItem.rightBarButtonItem.title =S_date;
    [date_alert removeFromSuperview];
    [self loadRequestData];
}

@end
