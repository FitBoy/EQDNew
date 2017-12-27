//
//  RSDangAnViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RSDangAnViewController.h"
#import "YuanGongViewController.h"
#import "DAYaoQingViewController.h"
#import "RuZhiSPViewController.h"
#import "RedTip_LabelTableViewCell.h"
@interface RSDangAnViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    UserModel *user;
    NSMutableArray *arr_code;
    
}

@end

@implementation RSDangAnViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self message_recieved];
}
-(void)message_recieved{
    [WebRequest  userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            arr_code  = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0"]];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==151) {
                    [arr_code replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@",dic2[@"count"]]];
                    
                }
            }
            [tableV reloadData];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"员工档案管理";
    arr_names = [NSMutableArray arrayWithArray:@[@"员工状况",@"入职邀请",@"入职审批"]];
    //,@"流程查看"
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
    RedTip_LabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RedTip_LabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    if ([arr_code[indexPath.row] integerValue]>0) {
        cell.L_RedTip.hidden=NO;
        cell.L_RedTip.text =arr_code[indexPath.row];
    }else
    {
        cell.L_RedTip.hidden=YES;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //员工状况
            YuanGongViewController *YGvc =[[YuanGongViewController alloc]init];
            [self.navigationController pushViewController:YGvc animated:NO];
        }
            break;
        case 1:
        {
           //入职邀请
            DAYaoQingViewController *YQvc =[[DAYaoQingViewController alloc]init];
            [self.navigationController pushViewController:YQvc animated:NO];
            
        }
            break;
        case 2:
        {
            //入职审批
            RuZhiSPViewController *SPvc =[[RuZhiSPViewController alloc]init];
            [self.navigationController pushViewController:SPvc animated:NO];
        }
            break;
        case 3:
        {
          //流程查看
        }
            break;
            
        default:
            break;
    }
}




@end
