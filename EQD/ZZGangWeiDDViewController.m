//
//  ZZGangWeiDDViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ZZGangWeiDDViewController.h"
#import "FBButton.h"
#import "MutableChooseViewController.h"
#import "FBTimeDayViewController.h"
#import "FBTextVViewController.h"
#import "GangWeiChooseViewController.h"
@interface ZZGangWeiDDViewController ()<UITableViewDelegate,UITableViewDataSource,MutableChooseViewControllerDelegate,FBTimeDayViewControllerDelegate,GangWeiChooseViewControllerDelegate,FBTextVViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *arr_one_content;
    NSMutableArray *arr_two_content;
    UserModel *user;
    
}

@end

@implementation ZZGangWeiDDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"岗位调动申请";
    user = [WebRequest GetUserInfo];
     arr_one = [NSMutableArray arrayWithArray:@[@"姓名",@"原任部门",@"岗位",@"薪资等级",@"文件移交内容",@"物品实物移交内容"]];
//    arr_one_content = [NSMutableArray arrayWithArray:@[user.name,person_com.postname,person_com.careername,@"薪资等级",@"请输入",@"请输入"]];
    arr_two = [NSMutableArray arrayWithArray:@[@"调动岗位",@"薪资等级",@"文件移交内容",@"物品实物移交内容",@"调动生效日期",@"调动原因"]];
    arr_two_content = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请输入",@"请输入",@"请选择",@"请输入"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 15, DEVICE_WIDTH, DEVICE_HEIGHT-15) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(editCancelClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"申请" style:UIBarButtonItemStylePlain target:self action:@selector(shenqingClick)];
    [self.navigationItem setRightBarButtonItem:right];
   
}
-(void)shenqingClick
{
    //申请
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section==0?@"原岗位信息":@"调动岗位信息";
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0? arr_one.count:arr_two.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section==0) {
        
        cell.textLabel.text =arr_one[indexPath.row];
        cell.detailTextLabel.text =arr_one_content[indexPath.row];
        if (indexPath.row<4) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else
    {
        cell.textLabel.text =arr_two[indexPath.row];
        cell.detailTextLabel.text =arr_two_content[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
        return 40;
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn setTitle:@"申  请" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:25]];
        [tbtn addTarget:self action:@selector(shenqingClick) forControlEvents:UIControlEventTouchUpInside];
        
        return tbtn;
        
    }
    return nil;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        if (indexPath.row>3) {
            MutableChooseViewController *MCvc =[[MutableChooseViewController alloc]init];
            MCvc.delegate=self;
            MCvc.indexpath=indexPath;
            MCvc.contentTitle =arr_one[indexPath.row];
            [self.navigationController pushViewController:MCvc animated:NO];
            
        }
    }
    
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                //调动岗位
                GangWeiChooseViewController *GWvc =[[GangWeiChooseViewController alloc]init];
                GWvc.delegate=self;
                GWvc.indexPath=indexPath;
                [self.navigationController pushViewController:GWvc animated:NO];
                
            }
                break;
            case 1:
            {
                //薪资等级
            }
                break;
            case 2:
            {
                // 文件移交内容
                MutableChooseViewController *MCvc =[[MutableChooseViewController alloc]init];
                MCvc.delegate=self;
                MCvc.indexpath=indexPath;
                MCvc.contentTitle =arr_two[indexPath.row];
                [self.navigationController pushViewController:MCvc animated:NO];
            }
                break;
            case 3:
            {
                //物品实物移交内容
                MutableChooseViewController *MCvc =[[MutableChooseViewController alloc]init];
                MCvc.delegate=self;
                MCvc.indexpath=indexPath;
                MCvc.contentTitle =arr_two[indexPath.row];
                [self.navigationController pushViewController:MCvc animated:NO];
                
            }
                break;
            case 4:
            {
                //调动生效日期
                FBTimeDayViewController *TDvc =[[FBTimeDayViewController alloc]init];
                TDvc.contentTitle =arr_two[indexPath.row];
                TDvc.delegate =self;
                TDvc.indexPath =indexPath;
                
                [self.navigationController pushViewController:TDvc animated:NO];
            }
                break;
            case 5:
            {
                //调动原因
                FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
                TVvc.delegate =self;
                TVvc.contentTitle=arr_two[indexPath.row];
                TVvc.content =arr_two_content[indexPath.row];
                TVvc.indexpath =indexPath;
                [self.navigationController pushViewController:TVvc animated:NO];
                
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark - 自定义的协议代理
-(void)timeDay:(NSString *)time indexPath:(NSIndexPath *)indexPath
{
    [arr_two_content replaceObjectAtIndex:indexPath.row withObject:time];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)contentArr:(NSArray *)arr indexpath:(NSIndexPath *)indexPath
{
    NSMutableString *tstr = [NSMutableString string];
    for (int i=0; i<arr.count; i++) {
        if (i==arr.count-1) {
            [tstr appendString:arr[i]];
        }
        else
        {
        [tstr appendString:[NSString stringWithFormat:@"%@-",arr[i]]];
        }
        
    }
    
    if (indexPath.section==0) {
        [arr_one_content replaceObjectAtIndex:indexPath.row withObject:tstr];
    }
    else
    {
        [arr_two_content replaceObjectAtIndex:indexPath.row withObject:tstr];
        
    }
    [tableV reloadData];
}
-(void)gangweiModel:(GangweiModel *)model indexPath:(NSIndexPath *)indexPath
{
    NSString *tstr =[NSString stringWithFormat:@"%@-%@",model.name,model.name];
    [arr_two_content replaceObjectAtIndex:indexPath.row withObject:tstr];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
}

-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_two_content replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

@end
