//
//  RS_meetingManagerViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RS_meetingManagerViewController.h"
#import "Meeting_listViewController.h"
#import "Meeting_noticeViewController.h"
#import "MeetingNotice_DetailViewController.h"
#import "Meeting_recoderListViewController.h"
@interface RS_meetingManagerViewController ()<UITableViewDataSource,UITableViewDelegate,Meeting_noticeViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSInteger fenlei;
}

@end

@implementation RS_meetingManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fenlei = 0;
    ///会议议程 会议记录 会议执行率 会议出勤率统计
    arr_names  =@[@"会议类型设置",@"会议通知",@"会议签到情况",@"会议记录"];
    self.navigationItem.title = @"会议管理";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;

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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //会议设置
        Meeting_listViewController  *Lvc =[[Meeting_listViewController alloc]init];
        [self.navigationController pushViewController:Lvc animated:NO];
    }else if (indexPath.row ==1)
    {
        //会议通知
        Meeting_noticeViewController *Mvc =[[Meeting_noticeViewController alloc]init];
        Mvc.temp =1;
        [self.navigationController pushViewController:Mvc animated:NO];
    }else if (indexPath.row ==2 || indexPath.row == 3)
    {
        fenlei = indexPath.row;
        Meeting_noticeViewController *Nvc = [[Meeting_noticeViewController alloc]init];
        Nvc.delegate_huiyi = self;
        Nvc.temp =1;
        [self.navigationController pushViewController:Nvc animated:NO];
    }
    else
    {
        
    }
}

-(void)getMeetingModel:(MeetingModel *)tmodel
{
    if (fenlei ==2) {
        //会议签到情况
        MeetingNotice_DetailViewController *dvc= [[MeetingNotice_DetailViewController alloc]init];
        dvc.noticeId = tmodel.Id;
        [self.navigationController pushViewController:dvc animated:NO];
    }else if (fenlei ==3)
    {
        //会议记录
        Meeting_recoderListViewController *Rvc = [[Meeting_recoderListViewController alloc]init];
        Rvc.settingId = tmodel.Id;
        [self.navigationController pushViewController:Rvc animated:NO];
    }else
    {
        
    }
}



@end
