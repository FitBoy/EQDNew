//
//  RSShenPi_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RSShenPi_ViewController.h"
#import "SP_QingJiaViewController.h"
#import "PZ_TiaoBan_ListViewController.h"
#import "PZ_TiaoXiuListViewController.h"
#import "PZ_JiaBan_ListViewController.h"
#import "PZ_ChuChai_ListViewController.h"
#import "LateLeaver_ListViewController.h"
#import "PZLiZhiViewController.h"
#import "RedTip_LabelTableViewCell.h"
#import "XuQiuPerson_listViewController.h"
@interface RSShenPi_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_shenpi;
    NSMutableArray *arr_titles;
    UserModel *user;
    NSMutableArray *arr_one;
    NSMutableArray *arr_four;
}

@end

@implementation RSShenPi_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self message_recieved];
}

-(void)message_recieved
{
    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        
        if([dic[Y_STATUS] integerValue]==200){
            NSArray *tarr = dic[Y_ITEMS];
            arr_one = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
            arr_four = [NSMutableArray arrayWithArray:@[@"0",@"0"]];
            for(int i=0;i<tarr.count;i++)
            {
                NSDictionary *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==101) {
                   //请假
                    [arr_one replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",[arr_one[0] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==111)
                {
                    //出差
                    [arr_one replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",[arr_one[1] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==251)
                {
                    //加班
                  [arr_one replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",[arr_one[2] integerValue]+[dic2[@"count"] integerValue]]];
                }else if([dic2[@"code"] integerValue]==241)
                {
                    //调休
                   [arr_one replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%ld",[arr_one[3] integerValue]+[dic2[@"count"] integerValue]]];
                }else if([dic2[@"code"] integerValue]==121)
                {
                    //调班
                    [arr_one replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%ld",[arr_one[4] integerValue]+[dic2[@"count"] integerValue]]];
                }else if([dic2[@"code"] integerValue]==261)
                {
                    //迟到早退
                    [arr_one replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%ld",[arr_one[5] integerValue]+[dic2[@"count"] integerValue]]];
                }else if([dic2[@"code"] integerValue]==281)
                {
                    //漏打卡
                   [arr_one replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%ld",[arr_one[6] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==301)
                {
                    //离职审批
                    [arr_four replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",[arr_four[0] integerValue]+[dic2[@"count"] integerValue]]];
                }
                else
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
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"人事的审批";
    arr_shenpi =[NSMutableArray arrayWithArray:@[@[@"请假",@"出差",@"加班",@"调休",@"调班",@"迟到早退",@"漏打卡"],@[],@[],@[@"离职审批",@"人力资源"]]];//@"转正",@"岗位异动",
    arr_titles =[NSMutableArray arrayWithArray:@[@"考勤",@"后勤",@"薪酬福利",@"组织管理"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recieved) name:Z_FB_message_received object:nil];
    
}
#pragma  mark - 表的数据源
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_titles[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_shenpi.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tarr =arr_shenpi[section];
    return tarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    RedTip_LabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RedTip_LabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    NSArray *tarr =arr_shenpi[indexPath.section];
    cell.textLabel.text =tarr[indexPath.row];
    if (indexPath.section==0) {
        if ([arr_one[indexPath.row] integerValue] > 0) {
            cell.L_RedTip.hidden=NO;
            cell.L_RedTip.text =arr_one[indexPath.row];
        }else
        {
            cell.L_RedTip.hidden=YES;
        }
    }else if (indexPath.section==3)
    {
        if ([arr_four[indexPath.row] integerValue] >0) {
            cell.L_RedTip.hidden=NO;
            cell.L_RedTip.text =arr_four[indexPath.row];
        }else
        {
            cell.L_RedTip.hidden=YES;
        }
    }else
    {
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            [arr_one replaceObjectAtIndex:indexPath.row withObject:@"0"];
        {
            if (indexPath.row==0) {
                //请假
                SP_QingJiaViewController *QJvc =[[SP_QingJiaViewController alloc]init];
                [self.navigationController pushViewController:QJvc animated:NO];
            }
            else if (indexPath.row==1)
            {
                //出差
                PZ_ChuChai_ListViewController *CCvc =[[PZ_ChuChai_ListViewController alloc]init];
                CCvc.isRenShi =1;
                [self.navigationController pushViewController:CCvc animated:NO];
            }
            else if (indexPath.row==2)
            {
                //加班
                PZ_JiaBan_ListViewController *JBvc =[[PZ_JiaBan_ListViewController alloc]init];
                JBvc.isRenShi =1;
                [self.navigationController pushViewController:JBvc animated:NO];
            }
            else if (indexPath.row==3)
            {
                //调休
                PZ_TiaoXiuListViewController *TXvc =[[PZ_TiaoXiuListViewController alloc]init];
                TXvc.isRenShi =1;
                [self.navigationController pushViewController:TXvc animated:NO];
                
            }
            else if(indexPath.row==4)
            {
                //调班
                PZ_TiaoBan_ListViewController *TBvc =[[PZ_TiaoBan_ListViewController alloc]init];
                TBvc.isRenShi=1;
                [self.navigationController pushViewController:TBvc animated:NO];
            }else if (indexPath.row==5)
            {
               //迟到早退
                LateLeaver_ListViewController *LLvc =[[LateLeaver_ListViewController alloc]init];
                LLvc.isShenpi =2;
                [self.navigationController pushViewController:LLvc animated:NO];
            }else if (indexPath.row==6)
            {
                LateLeaver_ListViewController *LLvc =[[LateLeaver_ListViewController alloc]init];
                LLvc.isShenpi =5;
                [self.navigationController pushViewController:LLvc animated:NO];
 
            }
            
            else
            {
                
            }
        }
            break;
        case 1:
        {
            if(indexPath.row==0)
            {
                //用车
            }
            else if (indexPath.row==1)
            {
                //报废
            }
            else
            {
                //行政物资
            }
        }
            break;
        case 2:
        {
            if(indexPath.row==0)
            {
                //调薪
            }
            else if (indexPath.row==1)
            {
                //费用报销
            }
            else if (indexPath.row==2)
            {
                //福利
            }
            else
            {
                //社保
            }
        }
            break;
        case 3:
        {
            if(indexPath.row==0)
            {
                //离职审批
                PZLiZhiViewController  *LZvc =[[PZLiZhiViewController alloc]init];
                LZvc.isrenshi =2;
                [self.navigationController pushViewController:LZvc animated:NO];
            }
            else if (indexPath.row==1)
            {
                //人力资源
                XuQiuPerson_listViewController  *Xvc =[[XuQiuPerson_listViewController alloc]init];
                Xvc.isrenShi =1;
                [self.navigationController pushViewController:Xvc animated:NO];
                
            }
            else if (indexPath.row==2)
            {
                //转正
              
            }
            else
            {
                //人力资源需求
            }
        }
            break;
        default:
            break;
    }
}




@end
