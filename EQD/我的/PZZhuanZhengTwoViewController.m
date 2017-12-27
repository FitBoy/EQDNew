//
//  PZZhuanZhengTwoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZZhuanZhengTwoViewController.h"
#import "FBTextVViewController.h"
#import "FBTextFieldViewController.h"
#import "FBButton.h"
@interface PZZhuanZhengTwoViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_one_content;
    NSMutableArray *arr_two;
    NSMutableArray *arr_two_content;
}

@end

@implementation PZZhuanZhengTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"转正批准";
    arr_one =[NSMutableArray arrayWithArray:@[@"申请人",@"部门",@"岗位",@"工号",@"试用期成绩",@"入职日期",@"试用期结束日期",@"试用期的申请人评价"]];
    arr_two = [NSMutableArray arrayWithArray:@[@"部门负责人（已同意）",@"试用期工资",@"转正后工资",@"部门负责人对试用期的评价"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=40;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(editCancelClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==1)
    {
        UIView *tview =[[UIView alloc]init];
        tview.userInteractionEnabled =YES;
        FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn setTitle:@"拒 绝" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:25]];
        [tbtn addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
        FBButton *tbtn1 = [FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn1 setTitle:@"同 意" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:25]];
        [tbtn1 addTarget:self action:@selector(tongyiClick) forControlEvents:UIControlEventTouchUpInside];
        [tview addSubview:tbtn];
        [tview addSubview:tbtn1];
        tbtn.frame =CGRectMake(10, 0, DEVICE_WIDTH/2.0-15, 40);
        tbtn1.frame =CGRectMake(DEVICE_WIDTH/2.0, 0, DEVICE_WIDTH/2.0-15, 40);
        
        return tview;
    }
    return nil;
}
-(void)jujueClick
{
    //拒绝
}
-(void)tongyiClick
{
    //同意
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_one.count:arr_two.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if(indexPath.section==0)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text =arr_one[indexPath.row];
    }
    else
    {
        cell.textLabel.text =arr_two[indexPath.row];
    }
    return cell;
}

#pragma  mark - 表的协议代理

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        switch (indexPath.row) {
            case 2:
            {
                //转正后的工资
                FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.indexPath =indexPath;
                TFvc.delegate =self;
                TFvc.contentTitle =arr_two[indexPath.row];
                [self.navigationController pushViewController:TFvc animated:NO];
                
            }
                break;
            case 3:
            {
                //对试用期的评价
                FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
                TVvc.indexpath =indexPath;
                TVvc.contentTitle =arr_two[indexPath.row];
                [self.navigationController pushViewController:TVvc animated:NO];
                
                
            }
                break;
                
            default:
                break;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_two_content replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
}


@end
