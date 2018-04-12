//
//  PZXuQiuPersonViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/3.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZXuQiuPersonViewController.h"
#import "FBTextVViewController.h"
#import "FBButton.h"
@interface PZXuQiuPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
}

@end

@implementation PZXuQiuPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"人力需求审核";
    arr_names =[NSMutableArray arrayWithArray:@[@"编码",@"部门职位",@"岗位编制人数",@"岗位现有人数",@"待离职人数",@"申请人数",@"招聘原因",@"工作责任",@"要求到岗时间",@"备注"]];
    arr_contents =[NSMutableArray arrayWithArray:@[@"编码",@"部门职位",@"岗位编制人数",@"岗位现有人数",@"待离职人数",@"申请人数",@"招聘原因",@"工作责任",@"要求到岗时间",@"备注"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *tview =[[UIView alloc]init];
    tview.userInteractionEnabled =YES;
    FBButton *tbtn1 =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn1 setTitle:@"拒 绝" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:25]];
    tbtn1.frame = CGRectMake(10, 0, DEVICE_WIDTH/2.0-15, 40);
    [tbtn1 addTarget:self action:@selector(jujueCLick) forControlEvents:UIControlEventTouchUpInside];
    
    FBButton *tbtn2 =[FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn2 setTitle:@"同 意" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:25]];
    tbtn2.frame = CGRectMake(DEVICE_WIDTH/2.0+5, 0, DEVICE_WIDTH/2.0-15, 40);
    [tbtn2 addTarget:self action:@selector(tongyiCLick) forControlEvents:UIControlEventTouchUpInside];
    
    [tview addSubview:tbtn1];
    [tview addSubview:tbtn2];
    
    return tview;
}
-(void)jujueCLick
{
    //拒绝
}
-(void)tongyiCLick
{
    //同意
}
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
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //@[@"编码",@"部门职位",@"岗位编制人数",@"岗位现有人数",@"待离职人数",@"申请人数",@"招聘原因",@"工作责任",@"要求到岗时间",@"备注"]
    if (indexPath.row==6) {
        //招聘原因
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.content =arr_contents[indexPath.row];
        TVvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
        
    }
    else if(indexPath.row==7)
    {
        //工作职责
    }
    else if(indexPath.row==9)
    {
        //备注
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.content =arr_contents[indexPath.row];
        TVvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }
    else
    {
        
    }
    
}




@end
