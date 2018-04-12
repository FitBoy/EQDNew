//
//  FShenQingViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FShenQingViewController.h"
#import "SQQingJiaViewController.h"
#import "SQChuChaViewController.h"
#import "SQTiaoXiuViewController.h"
#import "SQLiZhiListViewController.h"
#import "SQXZWuZiViewController.h"
#import "ZZGangWeiDDViewController.h"
#import "XuQiuPerson_listViewController.h"
#import "SQ_tiaobanViewController.h"
#import "SQ_JiaBan_ListViewController.h"
#import "SQTiaoGangViewController.h"
#import "TongZhi_listViewController.h"
#import "LianLuoBook_ListViewController.h"
#import "RedTip_LabelTableViewCell.h"
#import "LateLeaver_ListViewController.h"
#import "CarUse_ListViewController.h"
#import "FB_MyPeiXunListViewController.h"
@interface FShenQingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_big;
    NSMutableArray *arr_leibie;
    UserModel *user;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *arr_three;
    NSMutableArray *arr_four;
    
}

@end

@implementation FShenQingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self  message_recieved];
    
}

-(void)message_recieved
{
    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            arr_one =[NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
            arr_four = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0"]];
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 = tarr[i];
                if ([dic2[@"code"] integerValue]==102) {
                    //请假
                    [arr_one replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",[arr_one[0] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==112)
                {
                    //出差
                    [arr_one replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",[arr_one[1] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==252)
                {
                    //加班
                    [arr_one replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",[arr_one[2] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==242)
                {
                    [arr_one replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%ld",[arr_one[3] integerValue]+[dic2[@"count"] integerValue]]];
                    //调休
                }else if ([dic2[@"code"] integerValue]==122)
                {
                    //调班
                    [arr_one replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%ld",[arr_one[4] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==262)
                {
                    //迟到早退
                    [arr_one replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%ld",[arr_one[5] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==282)
                {
                    //漏打卡
                    [arr_one replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%ld",[arr_one[6] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==232)
                {
                    //联络书
                    [arr_four replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",[arr_four[1] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==302)
                {
                    //离职申请
                    [arr_four replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",[arr_four[2] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==222)
                {
                    //通知
                    [arr_four replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",[arr_four[0] integerValue]+[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==322 ||[dic2[@"code"] integerValue]==323 ){
                  [arr_four replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%ld",[arr_four[4] integerValue]+[dic2[@"count"] integerValue]]];
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
    user =[WebRequest GetUserInfo];
    self.navigationItem.title=@"我的申请";
    //@[@"用车",@"报废",@"行政物资"],@[@"调薪",@"费用报销",@"福利",@"社保"],,@"转正",@"岗位异动",
    arr_big =[NSMutableArray arrayWithArray:@[@[@"请假",@"出差",@"加班",@"调休",@"调班",@"迟到早退",@"漏打卡"],@[@"用车申请"],@[],@[@"通知",@"联络书",@"离职申请",@"人力需求",@"培训申请"]]];//,@"调岗申请"
    arr_leibie = [NSMutableArray arrayWithArray:@[@"考勤",@"后勤",@"薪酬福利",@"组织管理"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recieved) name:Z_FB_message_received object:nil];
    
    
}



#pragma  mark - 表的数据源
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_leibie[section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return   arr_big.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr =arr_big[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    RedTip_LabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RedTip_LabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *tarr =arr_big[indexPath.section];
    
    cell.textLabel.text =tarr[indexPath.row];
    if (indexPath.section==0) {
        if ([arr_one[indexPath.row] integerValue]>0) {
            cell.L_RedTip.hidden=NO;
            cell.L_RedTip.text = arr_one[indexPath.row];
        }
    }else if (indexPath.section==3)
    {
        if ([arr_four[indexPath.row] integerValue]>0) {
            cell.L_RedTip.hidden=NO;
            cell.L_RedTip.text =arr_four[indexPath.row];
        }
    }else if (indexPath.section==1)
    {
      if(indexPath.row==0)
      {
          //用车申请
         cell.L_RedTip.hidden=YES;
          
      }else
      {
      }
        
    }else if (indexPath.section==2)
    {
        
    }else
    {
    }
    
    return cell;
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}

#pragma  mark - 表的协议代理
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {//考勤
            [arr_one replaceObjectAtIndex:indexPath.row withObject:@"0"];
            switch (indexPath.row) {
                case 0:
                {
                    //请假
                    SQQingJiaViewController *QJvc =[[SQQingJiaViewController alloc]init];
                    [self.navigationController pushViewController:QJvc animated:NO];
                    
                }
                    break;
                case 1:
                {
                  //出差
                    SQChuChaViewController *CCvc =[[SQChuChaViewController alloc]init];
                    [self.navigationController pushViewController:CCvc animated:NO];
                    
                }
                    break;
               
                case 2:
                {
                    //加班
                    SQ_JiaBan_ListViewController *JBvc =[[SQ_JiaBan_ListViewController alloc]init];
                    [self.navigationController pushViewController:JBvc animated:NO];
                }
                    break;
                case 3:
                {
                    //调休
                    SQTiaoXiuViewController *TXvc =[[SQTiaoXiuViewController alloc]init];
                    [self.navigationController pushViewController:TXvc animated:NO];
                    
                }
                    break;
                case 4:
                {
                    //调班
                    SQ_tiaobanViewController *TBvc =[[SQ_tiaobanViewController alloc]init];
                    [self.navigationController pushViewController:TBvc animated:NO];
                }
                    break;
                    case 5:
                {
                    //迟到早退
                    LateLeaver_ListViewController  *Lvc =[[LateLeaver_ListViewController alloc]init];
                    Lvc.isShenpi=0;
                    [self.navigationController pushViewController:Lvc animated:NO];
                }
                    break;
                    case 6:
                {
                    //漏打卡
                    LateLeaver_ListViewController  *Lvc =[[LateLeaver_ListViewController alloc]init];
                    Lvc.isShenpi=3;
                    [self.navigationController pushViewController:Lvc animated:NO];

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
                    CarUse_ListViewController  *Lvc =[[CarUse_ListViewController alloc]init];
                    [self.navigationController pushViewController:Lvc animated:NO];
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
                    SQXZWuZiViewController *WZvc =[[SQXZWuZiViewController alloc]init];
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
//                  社保
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            [arr_four  replaceObjectAtIndex:indexPath.row withObject:@"0"];
            //组织管理
            switch (indexPath.row) {
                case 0:
                {
                    //通知
                    TongZhi_listViewController *Lvc =[[TongZhi_listViewController alloc]init];
                    [self.navigationController pushViewController:Lvc animated:NO];
                    
                }
                    break;
                case 1:
                {
                    //联络书
                    LianLuoBook_ListViewController *Lvc =[[LianLuoBook_ListViewController alloc]init];
                    [self.navigationController pushViewController:Lvc animated:NO];
                    
                }
                    break;
                    case 4:
                {
                    //培训
                    FB_MyPeiXunListViewController  *Lvc =[[FB_MyPeiXunListViewController alloc]init];
                    [self.navigationController pushViewController:Lvc animated:NO];
                    
                }
                    break;

                case 5:
                {
                    //岗位异动
                    ZZGangWeiDDViewController *GWvc =[[ZZGangWeiDDViewController alloc]init];
                    [self.navigationController pushViewController:GWvc animated:NO];
                }
                    break;
                case 2:
                {
                    //离职申请
                    if ([user.companyId integerValue]==0) {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text =@"您不在企业或者重登一下";
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [MBProgressHUD hideHUDForView:self.view  animated:YES];
                        });
                    }
                    else
                    {
                        SQLiZhiListViewController  *LZvc =[[SQLiZhiListViewController alloc]init];
                        [self.navigationController pushViewController:LZvc animated:NO];
                    }
                    
                }
                    break;
                    case 3:
                {
                    //人力需求申请  这个只能部门领导才有这个权限，到时候根据情况来
                    if ([user.isleader integerValue]==1) {
                        
                    }
                    XuQiuPerson_listViewController *XQPvc =[[XuQiuPerson_listViewController alloc]init];
                    [self.navigationController pushViewController:XQPvc animated:NO];
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
