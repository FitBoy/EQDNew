//
//  FBDaKa_RecordViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBDaKa_RecordViewController.h"
#import "FBDaKa_TableViewCell.h"
#import "DatePicer_AlertView.h"
#import "DaKa_JiLuTableViewCell.h"
#import "DaKa_DetailViewController.h"
#import "DaKaJiLuModel.h"
@interface FBDaKa_RecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_jilu;
    UserModel *user;
    NSString *selected_date;
    DatePicer_AlertView *date_alert;
}

@end

@implementation FBDaKa_RecordViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Clocks_Get_Clock_ByMonthWithuserGuid:user.Guid Month:selected_date  And:^(NSDictionary *dic) {
        [arr_jilu removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            DaKaJiLuModel *model =[DaKaJiLuModel mj_objectWithKeyValues:tarr[i]];
            [arr_jilu addObject:model];
        }
        [tableV reloadData];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_jilu =[NSMutableArray arrayWithCapacity:0];
    
    UIView *tview =[[UIView alloc]initWithFrame:CGRectMake(0,0, DEVICE_WIDTH-30, 40)];
    UILabel *tlabel_date =[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, 30)];
    tlabel_date.text =@"日期";
    tlabel_date.textAlignment =NSTextAlignmentCenter;
    tlabel_date.font =[UIFont systemFontOfSize:17];
    [tview addSubview:tlabel_date];
    
    UILabel *tlabel_shuoming =[[UILabel alloc]initWithFrame:CGRectMake(105, 5, DEVICE_WIDTH-100-100-10, 30)];
    [tview addSubview:tlabel_shuoming];
    tlabel_shuoming.font =[UIFont systemFontOfSize:17];
    tlabel_shuoming.text =@"说明";
    tlabel_shuoming.textAlignment =NSTextAlignmentCenter;
    
    UILabel *tlabel_status =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-100-5, 5, 100, 30)];
    tlabel_status.text =@"状态";
    tlabel_status.font =[UIFont systemFontOfSize:17];
    tlabel_status.textAlignment =NSTextAlignmentCenter;
    [tview addSubview:tlabel_status];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.tableHeaderView =tview;
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
  
    NSString *other =[formatter stringFromDate:[NSDate date]];
    selected_date =other;
    self.navigationItem.title = selected_date;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"前月记录" style:UIBarButtonItemStylePlain target:self action:@selector(OtherClick)];
    [self.navigationItem setRightBarButtonItem:right];
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
       [date_alert setDate3:other];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    date_alert.picker.maximumDate = [NSDate date];
    
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
    
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    selected_date =[formatter stringFromDate:date_alert.picker.date];
    self.navigationItem.title =selected_date;
    [date_alert removeFromSuperview];
    [self loadRequestData];
}
-(void)OtherClick
{
    [self.view addSubview:date_alert];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_jilu.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    DaKa_JiLuTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[DaKa_JiLuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    DaKaJiLuModel *model =arr_jilu[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DaKaJiLuModel *model =arr_jilu[indexPath.row];
    DaKa_DetailViewController *dvc =[[DaKa_DetailViewController alloc]init];
    dvc.arr_jilu =model.list;
    dvc.date =model.date;
    [self.navigationController pushViewController:dvc animated:NO];
}



@end
