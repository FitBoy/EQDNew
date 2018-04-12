//
//  PZXuQiuPerson3ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/3.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "PZXuQiuPerson3ViewController.h"
#import "FBButton.h"
@interface PZXuQiuPerson3ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *arr_one_content;
    NSMutableArray *arr_two_content;
}

@end

@implementation PZXuQiuPerson3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"人力需求审核";
    arr_one =[NSMutableArray arrayWithArray:@[@"编码",@"部门职位",@"岗位编制人数",@"岗位现有人数",@"待离职人数",@"申请人数",@"招聘原因",@"工作责任",@"要求到岗时间",@"备注"]];
    arr_one_content =[NSMutableArray arrayWithArray:@[@"编码",@"部门职位",@"岗位编制人数",@"岗位现有人数",@"待离职人数",@"申请人数",@"招聘原因",@"工作责任",@"要求到岗时间",@"备注"]];
    arr_two = [NSMutableArray arrayWithArray:@[@"部门负责人意见",@"招聘渠道",@"人力部门意见"]];
    arr_two_content = [NSMutableArray arrayWithArray:@[@"同意-2017-03-14",@"内招",@"同意-2017-06-04"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, DEVICE_HEIGHT-20) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section==0?0:50;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return nil;
    }
    else
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
    return section==0?arr_one.count:arr_two.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.section==0) {
        cell.textLabel.text =arr_one[indexPath.row];
        cell.detailTextLabel.text =arr_one_content[indexPath.row];
        
    }
    else
    {
        cell.textLabel.text =arr_two[indexPath.row];
        cell.detailTextLabel.text =arr_two_content[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}



@end
