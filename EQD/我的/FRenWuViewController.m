//
//  FRenWuViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FRenWuViewController.h"
#import "RWFaSongViewController.h"
#import "MyRenWuViewController.h"
#import "FFaQiViewController.h"
#import "FCanYuViewController.h"
#import "FYanShouViewController.h"
#import "RedTip_LabelTableViewCell.h"
@interface FRenWuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_renwu;
    UserModel *user;
    NSMutableArray *arr_code;
}

@end

@implementation FRenWuViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self message_recieved];
}
-(void)message_recieved
{
    [WebRequest  userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            arr_code = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0"]];
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==140) {
                    //我的任务
                    [arr_code  replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",[arr_code[0] integerValue] +[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==141)
                {
                    //我验收的任务
                    [arr_code  replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",[arr_code[1] integerValue] +[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==142)
                {//我参与的任务
                    [arr_code  replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",[arr_code[2] integerValue] +[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==143)
                {
                    //我发起的任务
                    [arr_code  replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%ld",[arr_code[3] integerValue] +[dic2[@"count"] integerValue]]];
                }else
                {
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"我的任务";
    user = [WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    arr_renwu = [NSMutableArray arrayWithArray:@[@"我的任务",@"我验收的任务",@"我参与的任务",@"我发起的任务"]];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发任务" style:UIBarButtonItemStylePlain target:self action:@selector(farenwuClick)];
    [self.navigationItem setRightBarButtonItem:right];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recieved) name:Z_FB_message_received object:nil];
}
#pragma  mark - 表的数据源

-(void)farenwuClick
{
    //发任务
    RWFaSongViewController *FSvc =[[RWFaSongViewController alloc]init];
    [self.navigationController pushViewController:FSvc animated:NO];
   
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_renwu.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    RedTip_LabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RedTip_LabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font =[UIFont systemFontOfSize:17];
    }
    cell.textLabel.text =arr_renwu[indexPath.row];
    if ([arr_code[indexPath.row] integerValue]>0) {
        cell.L_RedTip.hidden=NO;
        cell.L_RedTip.text = arr_code[indexPath.row];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [arr_code  replaceObjectAtIndex:indexPath.row withObject:@"0"];
    switch (indexPath.row) {
        case 0:
        {
            //我的任务
            MyRenWuViewController *RWvc =[[MyRenWuViewController alloc]init];
            [self.navigationController pushViewController:RWvc animated:NO];
            
        }
            break;
        case 1:
        {
            //我验收的任务
            FYanShouViewController *YSvc =[[FYanShouViewController alloc]init];
            [self.navigationController pushViewController:YSvc animated:NO];
        }
            break;
        case 2:
        {
            //我参与的任务
            FCanYuViewController *CYvc =[[FCanYuViewController alloc]init];
            [self.navigationController pushViewController:CYvc animated:NO];
        }
            break;
        case 3:
        {
            //我发起的任务
            FFaQiViewController *FQvc =[[FFaQiViewController alloc]init];
            [self.navigationController pushViewController:FQvc animated:NO];
        }
            break;
            
        default:
            break;
    }
}



@end
