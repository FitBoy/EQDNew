//
//  PZGangWeiDDViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZGangWeiDDViewController.h"
#import "FBButton.h"
@interface PZGangWeiDDViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *arr_one_content;
    NSMutableArray *arr_two_content;
    UserModel *user;
}


@end

@implementation PZGangWeiDDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"岗位调动审批";
//    person_com = [WebRequest getPerson_comModel];
    user = [WebRequest GetUserInfo];
    arr_one = [NSMutableArray arrayWithArray:@[@"姓名",@"原任部门",@"岗位",@"薪资等级",@"文件移交内容",@"物品实物移交内容"]];
//    arr_one_content = [NSMutableArray arrayWithArray:@[user.name,person_com.postname,person_com.careername,@"薪资等级",@"请输入",@"请输入"]];
    arr_two = [NSMutableArray arrayWithArray:@[@"调动岗位",@"薪资等级",@"文件移交内容",@"物品实物移交内容",@"调动生效日期",@"调动原因"]];
    arr_two_content = [NSMutableArray arrayWithArray:@[@"请选择",@"请选择",@"请输入",@"请输入",@"请选择",@"请输入"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;


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
        return 50;
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        UIView *tview =[[UIView alloc]init];
        tview.userInteractionEnabled =YES;
        
        FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn setTitle:@"拒  绝" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:nil];
        [tbtn addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
        [tview addSubview:tbtn];
        FBButton *tbtn1 = [FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn1 setTitle:@"同  意" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:nil];
        [tbtn1 addTarget:self action:@selector(tongyiClick) forControlEvents:UIControlEventTouchUpInside];
        
        [tview addSubview:tbtn1];
        
        tbtn.frame =CGRectMake(10, 5, DEVICE_WIDTH/2.0-15, 40);
        tbtn1.frame =CGRectMake(DEVICE_WIDTH/2.0+5, 5, DEVICE_WIDTH/2.0-15, 40);
        
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

@end
