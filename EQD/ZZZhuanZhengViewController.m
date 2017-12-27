//
//  ZZZhuanZhengViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ZZZhuanZhengViewController.h"
#import "FBTimeDayViewController.h"
#import "FBTextVViewController.h"
#import "FBButton.h"
@interface ZZZhuanZhengViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTimeDayViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
}

@end

@implementation ZZZhuanZhengViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [WebRequest Com_SelectStaffWithuid:user.Guid And:^(NSDictionary *dic) {
//            NSArray *tarr =dic[Y_ITEMS];
//            if (tarr.count) {
//                NSDictionary *dic1 =tarr[0];
//                arr_contents = [NSMutableArray arrayWithArray:@[user.username,dic1[@"postname"],dic1[@"careername"],@"试用期成绩",@"入职时间",@"请选择",@"请输入",@"请输入"]];
//                [tableV reloadData];
//            }
//        }];
//    });
 
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"转正申请";
    user = [WebRequest GetUserInfo];
    arr_names =[NSMutableArray arrayWithArray:@[@"申请人",@"部门",@"岗位",@"试用期成绩",@"入职日期",@"试用期结束日期",@"试用期自我评价"]];
    arr_contents = [NSMutableArray arrayWithCapacity:0];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents.count? arr_contents[indexPath.row]:nil;
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==5) {
        //试用期结束日期
        FBTimeDayViewController *Tvc =[[FBTimeDayViewController alloc]init];
        Tvc.indexPath =indexPath;
        Tvc.delegate =self;
        Tvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Tvc animated:NO];
        
    }
   
    else if(indexPath.row==6)
    {
        //试用期自我评价
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath=indexPath;
        TVvc.delegate =self;
        TVvc.content =arr_contents[indexPath.row];
        TVvc.contentTitle=arr_names[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
        
        
    }
    else
    {
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FBButton *tbtn =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:@"提交" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:25]];
    [tbtn addTarget:self action:@selector(tijiaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    return tbtn;
    
}
-(void)tijiaoClick
{
    //提交
}
#pragma mark - 自定义的协议代理

-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadData];
}
-(void)timeDay:(NSString *)time indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:time];
    [tableV reloadData];
    
}

@end
