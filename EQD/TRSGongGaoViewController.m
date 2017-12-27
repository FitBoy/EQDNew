//
//  TRSGongGaoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TRSGongGaoViewController.h"
#import "FBTextVViewController.h"
#import "Trumpt_ListViewController.h"
#import "GongGao_AddViewController.h"
#import "GongGao_ListViewController.h"
@interface TRSGongGaoViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    UserModel *user;
}

@end

@implementation TRSGongGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"公告-小喇叭管理";
    arr_names =[NSMutableArray arrayWithArray:@[@"发布小喇叭",@"查看发布的小喇叭",@"发布公告",@"查看发布的公告"]];
    //,@"流程查询"
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{//@[@"发布小喇叭",@"查看发布的小喇叭",@"发布公告",@"查看发布的公告",@"流程查询"]
    switch (indexPath.row) {
        case 0:
        {
           ///发布小喇叭
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.delegate =self;
            TVvc.contentTitle =@"发布小喇叭";
            TVvc.content=@"请输入";
            TVvc.S_maxnum =@"100";
            [self.navigationController pushViewController:TVvc animated:NO];
        }
            break;
        case 1:
        {
            //查看发布的小喇叭
            Trumpt_ListViewController *Lvc =[[Trumpt_ListViewController alloc]init];
            [self.navigationController pushViewController:Lvc animated:NO];
        }
            break;
            case 2:
        {
            ///发布公告
            GongGao_AddViewController *Avc =[[GongGao_AddViewController alloc]init];
            [self.navigationController pushViewController:Avc animated:NO];
        }
            break;
            case 3:
        {
            ///查看发布的公告
            GongGao_ListViewController *Lvc=[[GongGao_ListViewController alloc]init];
            [self.navigationController pushViewController:Lvc animated:NO];
        }
            break;
        default:
            break;
    }
}
#pragma  mark - 自定义的协议代理
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在发布";
    [WebRequest trumpet_Push_trumpetWithuserGuid:user.Guid comid:user.companyId content:text And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
}


@end
