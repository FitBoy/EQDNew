//
//  FBMyPiZhunViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBMyPiZhunViewController.h"
#import "PZLiZhiViewController.h"
#import "PZXZWuZiViewController.h"
#import "PZGangWeiDDViewController.h"
#import "PZZhuanZhengViewController.h"
#import "PZXuQiuPersonViewController.h"
#import "QingJiaPiZhun_ViewController.h"
#import "PZ_TiaoBan_ListViewController.h"
#import "PZ_TiaoXiuListViewController.h"
#import "PZ_JiaBan_ListViewController.h"
#import "PZ_ChuChai_ListViewController.h"
#import "HeTong_list_LeaderViewController.h"
#import "TongZhi_listViewController.h"
#import "GongGao_ListViewController.h"
#import "LianLuoBook_ListViewController.h"
#import "LateLeaver_ListViewController.h"
#import "RedTip_LabelTableViewCell.h"
#import "CarUse_ListViewController.h"
#import "FB_MyPeiXunListViewController.h"
@interface FBMyPiZhunViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_big;
    NSMutableArray *arr_leibie;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *arr_three;
    NSMutableArray *arr_four;
    UserModel *user;
}

@end

@implementation FBMyPiZhunViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self message_recieved];
}
-(void)message_recieved
{
    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            arr_one =[NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
            arr_four=[NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0"]];
            for (int i=0; i<tarr.count; i++) {
                NSDictionary  *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==100) {
                    //请假
                    [arr_one replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",[arr_one[0] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==110)
                {
                    //出差
                    [arr_one replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",[arr_one[1] integerValue]+[dic2[@"count"] integerValue]]];
                    
                }else if ([dic2[@"code"] integerValue]==250)
                {
                    //加班
                    [arr_one replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",[arr_one[2] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==240)
                {
                    //调休
                    [arr_one replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%ld",[arr_one[3] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==120)
                {
                    //调班
                    [arr_one replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%ld",[arr_one[4] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==260)
                {
                    //迟到早退
                    [arr_one replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%ld",[arr_one[5] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==280)
                {
                    //漏打卡
                    [arr_one replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%ld",[arr_one[6] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==221)
                {
                    //通知
                    [arr_four replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",[arr_four[0] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==211)
                {
                    //公告
                    [arr_four replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",[arr_four[1] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==231)
                {
                    //联络书
                    [arr_four replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",[arr_four[2] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==300)
                {
                    //离职审批
                    [arr_four replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%ld",[arr_four[3] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==162)
                {
                    //劳动合同
                    [arr_four replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%ld",[arr_four[4] integerValue]+[dic2[@"count"] integerValue]]];
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
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"我的批准";
    ///@[@"用车",@"报废",@"行政物资"],@[@"调薪",@"费用报销",@"福利",@"社保"],
    arr_big =[NSMutableArray arrayWithArray:@[@[@"请假",@"出差",@"加班",@"调休",@"调班",@"迟到早退",@"漏打卡"],@[@"用车申请"],@[],@[@"通知",@"公告",@"联络书",@"离职批准",@"劳动合同",@"培训申请"]]];//@"转正",@"岗位异动",@"人力资源需求",
    arr_leibie = [NSMutableArray arrayWithArray:@[@"考勤",@"后勤",@"薪酬福利",@"组织管理"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recieved) name:Z_FB_message_received object:nil];
    
}

#pragma  mark - 表的数据源

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_leibie[section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_big.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tarr = arr_big[section];
    return tarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    RedTip_LabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RedTip_LabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *tarr = arr_big[indexPath.section];
    cell.textLabel.text =tarr[indexPath.row];
    if (indexPath.section==0) {
      //考勤
        if ([arr_one[indexPath.row] integerValue] >0) {
            cell.L_RedTip.hidden =NO;
            cell.L_RedTip.text = arr_one[indexPath.row];
        }
    }else if (indexPath.section==1)
    {
        //后勤
        cell.L_RedTip.hidden =YES;
    }else if (indexPath.section==2)
    {
        //薪资福利
    }else if (indexPath.section==3)
    {
        //组织管理
        if ([arr_four[indexPath.row] integerValue]>0) {
            cell.L_RedTip.hidden=NO;
            cell.L_RedTip.text =arr_four[indexPath.row];
        }
    }else
    {
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RedTip_LabelTableViewCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.L_RedTip.hidden=YES;
    switch (indexPath.section) {
        case 0:
            [arr_one replaceObjectAtIndex:indexPath.row withObject:@"0"];
        {//考勤
            switch (indexPath.row) {
                case 0:
                {
                    //请假
                    QingJiaPiZhun_ViewController *QJvc =[[QingJiaPiZhun_ViewController alloc]init];
                    [self.navigationController pushViewController:QJvc animated:NO];
                    
                }
                    break;
                case 1:
                {
                    //出差
                    PZ_ChuChai_ListViewController *CCvc =[[PZ_ChuChai_ListViewController alloc]init];
                    [self.navigationController pushViewController:CCvc animated:NO];
                }
                    break;
              
                case 2:
                {
                    //加班
                    PZ_JiaBan_ListViewController *JBvc =[[PZ_JiaBan_ListViewController alloc]init];
                    [self.navigationController pushViewController:JBvc animated:NO];
                }
                    break;
                case 3:
                {
                    //调休
                    PZ_TiaoXiuListViewController *TXvc =[[PZ_TiaoXiuListViewController alloc]init];
                    [self.navigationController pushViewController:TXvc animated:NO];
                    
                }
                    break;
                case 4:
                {
                    //调班
                    PZ_TiaoBan_ListViewController  *TBvc =[[PZ_TiaoBan_ListViewController alloc]init];
                    [self.navigationController pushViewController:TBvc animated:NO];
                }
                    break;
                    case 5:
                {
                    //迟到早退
                    LateLeaver_ListViewController *LLvc =[[LateLeaver_ListViewController alloc]init];
                    LLvc.isShenpi=1;
                    [self.navigationController pushViewController:LLvc animated:NO];
                    
                }
                    break;
                    case 6:
                {
                    //漏打卡
                    LateLeaver_ListViewController *LLvc =[[LateLeaver_ListViewController alloc]init];
                    LLvc.isShenpi=4;
                    [self.navigationController pushViewController:LLvc animated:NO];
                    
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 1:
        {//后勤
            
            switch (indexPath.row) {
                case 0:
                {
                    //用车
                    CarUse_ListViewController  *lvc =[[CarUse_ListViewController alloc]init];
                    lvc.isrenshi =2;
                    [self.navigationController pushViewController:lvc animated:NO];
                    
                }
                    break;
                    
                case 1:
                {
                    //报废
                }
                    break;
                    case 2:
                {
                  //行政物资
                    PZXZWuZiViewController *WZvc =[[PZXZWuZiViewController alloc]init];
                    [self.navigationController pushViewController:WZvc animated:NO];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {//薪酬福利
            switch (indexPath.row) {
                case 0:
                {
                    //调薪
                }
                    break;
                case 1:
                {
                    //费用报销
                }
                    break;
                case 2:
                {
                    //福利
                }
                    break;
                case 3:
                {
                    //社保
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            [arr_four replaceObjectAtIndex:indexPath.row withObject:@"0"];
            //组织管理
            switch (indexPath.row) {
                case 0:
                {
                    //通知
                    TongZhi_listViewController  *Lvc =[[TongZhi_listViewController alloc]init];
                    Lvc.isShenPi =1 ;
                    [self.navigationController pushViewController:Lvc animated:NO];
                    
                }
                    break;
                    case 1:
                {
                    //公告
                    GongGao_ListViewController *Lvc =[[GongGao_ListViewController alloc]init];
                    Lvc.ischeker =1;
                    [self.navigationController pushViewController:Lvc animated:NO];
                }
                    break;
                    case 2:
                {
                    //联络书
                    LianLuoBook_ListViewController *Lvc =[[LianLuoBook_ListViewController  alloc]init];
                    Lvc.isShenPi =1;
                    [self.navigationController pushViewController:Lvc animated:NO];
                }
                    break;
                    
                case 5:
                {
                    //转正
                    FB_MyPeiXunListViewController  *Lvc=[[FB_MyPeiXunListViewController alloc]init];
                    Lvc.isRenshi=2;
                    [self.navigationController pushViewController:Lvc animated:NO];
                  /*  PZZhuanZhengViewController *ZZvc =[[PZZhuanZhengViewController alloc]init];
                    [self.navigationController pushViewController:ZZvc animated:NO];*/
                    
                }
                    break;
               
                case 6:
                {
                    //岗位异动
                    PZGangWeiDDViewController *GWvc =[[PZGangWeiDDViewController alloc]init];
                    [self.navigationController pushViewController:GWvc animated:NO];
                    
                }
                    break;
                case 3:
                {
                    //离职批准
                    PZLiZhiViewController *LZvc =[[PZLiZhiViewController alloc]init];
                    [self.navigationController pushViewController:LZvc animated:NO];
                    
                }
                    break;
                    case 7:
                {
                    //人力资源需求
                    PZXuQiuPersonViewController *XQvc=[[PZXuQiuPersonViewController alloc]init];
                    [self.navigationController pushViewController:XQvc animated:NO];
                    
                }
                    break;
                case 4:
                {
                    //劳动合同
                    HeTong_list_LeaderViewController *Lvc =[[HeTong_list_LeaderViewController alloc]init];
                    [self.navigationController pushViewController:Lvc animated:NO];
                    
                }
                    break;
         
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}



@end
