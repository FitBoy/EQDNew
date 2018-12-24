//
//  FBFiveViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBFiveViewController.h"
#import "MyFirstTableViewCell.h"
#import "WebRequest.h"
#import "FBMyErWeiMaViewController.h"
#import "MyDangAn1ViewController.h"
#import "MGongSiViewController.h"
#import "MMyViewController.h"
#import "FXiTongViewController.h"
#import <UIImageView+AFNetworking.h>

#import "FRenWuViewController.h"
#import "FBeiWangLuViewController.h"
#import "FBMyPiZhunViewController.h"

#import "FShenQingViewController.h"
#import "MMGeRenCardViewController.h"
#import "TKaoQinViewController.h"
#import "RedTipTableViewCell.h"
#import "MyShouCangViewController.h"
#import "FFMyExpensesViewController.h"
#import "PPersonCardViewController.h"
#import "BPCenterViewController.h"
#import "YaoQingRegisterViewController.h"
#import "FBTextFieldViewController.h"

@interface FBFiveViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_info;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *arr_big;
    NSMutableArray *arr_three;
    NSMutableArray *arr_four;
    NSMutableArray *arr_five;
    NSMutableArray *arr_type;
    
    ///增加的积分
    NSMutableArray *arr_jifen;
    
    
    NSMutableArray *arr_code;
    NSString *qiyecode;
}


@end

@implementation FBFiveViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    user =[WebRequest GetUserInfo];
    [self  message_recieved];
}

-(void)message_recieved
{
    [WebRequest  userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            arr_code = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0"]];
            qiyecode = @"0";
            NSArray *tarr = dic[Y_ITEMS];
            NSInteger code_five =0;
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 = tarr[i];
                if ([dic2[@"code"] integerValue]==102||[dic2[@"code"] integerValue]==112||[dic2[@"code"] integerValue]==122||[dic2[@"code"] integerValue]==252||[dic2[@"code"] integerValue]==242||[dic2[@"code"] integerValue]==262||[dic2[@"code"] integerValue]==282||[dic2[@"code"] integerValue]==232||[dic2[@"code"] integerValue]==302||[dic2[@"code"] integerValue]==222 || [dic2[@"code"] integerValue]==322 || [dic2[@"code"] integerValue]==323 ) {
                    //我的申请
                    [arr_code  replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",[arr_code[0] integerValue] +[dic2[@"count"] integerValue]]];
                    code_five = code_five + [dic2[@"count"] integerValue];
                }else if ([dic2[@"code"] integerValue]==100 ||[dic2[@"code"] integerValue]==110||[dic2[@"code"] integerValue]==120||[dic2[@"code"] integerValue]==250||[dic2[@"code"] integerValue]==240||[dic2[@"code"] integerValue]==260||[dic2[@"code"] integerValue]==280||[dic2[@"code"] integerValue]==231||[dic2[@"code"] integerValue]==162||[dic2[@"code"] integerValue]==300 || [dic2[@"code"] integerValue]==221||[dic2[@"code"] integerValue]==211||[dic2[@"code"] integerValue]==370 || [dic2[@"code"] integerValue]==320 || [dic2[@"code"] integerValue]==321 || [dic2[@"code"] integerValue]==581)
                {//我的批准
                    code_five = code_five + [dic2[@"count"] integerValue];
                    [arr_code  replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",[arr_code[1] integerValue] +[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==140||[dic2[@"code"] integerValue]==141||[dic2[@"code"] integerValue]==142||[dic2[@"code"] integerValue]==143)
                {//我的任务
                    code_five = code_five + [dic2[@"count"] integerValue];
                    [arr_code  replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d",[arr_code[2] integerValue] +[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==230||[dic2[@"code"] integerValue]==160||[dic2[@"code"] integerValue]==150)
                {//我的
                    code_five = code_five + [dic2[@"count"] integerValue];
                    qiyecode =[NSString stringWithFormat:@"%d",[qiyecode integerValue] +[dic2[@"count"] integerValue]] ;
                }else if ([dic2[@"code"] integerValue]==371)
                {
                    //我的报销
                    code_five = code_five + [dic2[@"count"] integerValue];
                  [arr_code  replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%d",[arr_code[3] integerValue] +[dic2[@"count"] integerValue]]];

                }
                else
                {
                }
            }
           
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tabBarItem.badgeValue = [self changeWithnumber:code_five];
                [tableV reloadData];
            });
            
            
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     self.navigationItem.title=@"我的";
    user =[WebRequest GetUserInfo];
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(kuaijiefangshi)];
    [self.navigationItem setRightBarButtonItem:right];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, CGRectGetMinY(self.tabBarController.tabBar.frame)-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    adjustsScrollViewInsets_NO(tableV, self); 
    arr_info = [NSMutableArray arrayWithArray:@[@"个人档案"]];
    
    arr_one = [NSMutableArray arrayWithArray:@[@[@"shenq.png",@"我的申请"],@[@"pizhun.png",@"我的批准"],@[@"renwu.png",@"我的任务"],@[@"my_baobiao",@"我的报销"]]];
    arr_two=[NSMutableArray arrayWithArray:@[@[@"dak.png",@"我的打卡"],@[@"kanb.png",@"我的收藏"],@[@"beiWangLu",@"我的备忘录"],@[@"my_study",@"我的学习"]]];
    
    arr_jifen = [NSMutableArray arrayWithArray:@[@[@"jifenCenter",@"积分中心"],@[@"yaoqing",@"邀请注册"],@[@"writePhone",@"填写邀请人手机号"]]];
    
    
    arr_three=[NSMutableArray arrayWithArray:@[@[@"gere",@"我"],@[@"qiye.png",@"我的企业"]]];
    //
    arr_four=[NSMutableArray arrayWithArray:@[@[@"shezh",@"系统设置"]]];
//    arr_five = [NSMutableArray arrayWithArray:@[]];
    arr_big =[NSMutableArray arrayWithCapacity:0];
    [arr_big addObject:arr_info];
    [arr_big addObject:arr_one];
    [arr_big addObject:arr_two];
    [arr_big addObject:arr_jifen];
    [arr_big addObject:arr_three];
    [arr_big addObject:arr_four];
//    [arr_big addObject:arr_five];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recieved) name:Z_FB_message_received object:nil];
    
}


#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr_big.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr =arr_big[section];
    return arr.count;
}

-(void)erWeimaclick{
    NSLog(@"二维码");
    FBMyErWeiMaViewController  *EWMvc =[[FBMyErWeiMaViewController alloc]init];
    EWMvc.hidesBottomBarWhenPushed=YES;
    [self .navigationController pushViewController:EWMvc animated:NO];
    
}
-(void)headClick
{
    //个人名片
    MMGeRenCardViewController *GRvc =[[MMGeRenCardViewController alloc]init];
    GRvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:GRvc animated:NO];
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    NSArray *arr =arr_big[indexPath.section];
    static NSString *cellId=@"cellID";
    static NSString *cellId1=@"cellID1";
    if (indexPath.section==0) {
        MyFirstTableViewCell *cell1 =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell1) {
            cell1 =[[MyFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        [cell1.IV_headimg setImageWithURL:[NSURL URLWithString:user.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head.png"]];
        
        [cell1.B_erWeima addTarget:self action:@selector(erWeimaclick) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick)];
        [cell1.IV_headimg addGestureRecognizer:tap];
        cell1.L_name.text = user.upname;
        
        cell1.L_zhanghao.text = [NSString stringWithFormat:@"易企点号:%@",user.EQDCode];
        
        return cell1;
    }
    
    else{
        
        RedTipTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId1];
        if (!cell) {
            cell = [[RedTipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        NSArray *arr1 =arr[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:arr1[0]];
        cell.textLabel.text =arr1[1];
        if (indexPath.section==1) {
            if ([arr_code[indexPath.row] integerValue]>0) {
                cell.L_RedTip.hidden=NO;
                cell.L_RedTip.text =arr_code[indexPath.row];
            }else
            {
                cell.L_RedTip.hidden=YES;
            }
            
           
        }else if (indexPath.section==2)
        {
            cell.L_RedTip.hidden=YES;
        }else if (indexPath.section==4)
        {
            if (indexPath.row==1 && [qiyecode integerValue]>0) {
                cell.L_RedTip.hidden=NO;
                cell.L_RedTip.text =qiyecode;
            }else
            {
                cell.L_RedTip.hidden=YES;
            }
        }else
        {
            cell.L_RedTip.hidden=YES;
        }
       
        return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
           //修改个人档案详情
            [WebRequest user_enterWithu1:user.uname u2:[USERDEFAULTS objectForKey:Y_MIMA] And:^(NSDictionary *dic) {
                NSNumber *number =dic[Y_STATUS];
                if ([number integerValue]==200) {
                    [USERDEFAULTS setObject:dic[Y_ITEMS] forKey:Y_USERINFO];
                    [USERDEFAULTS synchronize];
                    NSDictionary *dic2=dic[Y_ITEMS] ;
                    if ([dic2[@"authen"] integerValue]==1) {
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"查看个人档案前需要密码再次确认" preferredStyle:UIAlertControllerStyleAlert];
                        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                            textField.placeholder = @"请再次输入密码";
                            textField.secureTextEntry=YES;
                        }];
                        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                        }]];
                        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            
                            MyDangAn1ViewController *DAvc1 =[[MyDangAn1ViewController alloc]init];
                            DAvc1.hidesBottomBarWhenPushed=YES;
                            DAvc1.password =alert.textFields[0].text;
                            [self.navigationController pushViewController:DAvc1 animated:NO];

                        }]];

                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self presentViewController:alert animated:NO completion:nil];

                        });
                        
                        
                        
                    }
                    else
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text =@"实名认证后才可查看个人档案";
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [MBProgressHUD hideHUDForView:self.view  animated:YES];
                        });
 
                    }
                }
                else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =dic[Y_MSG];
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
            }];

            
        }
        
    }
    
    
    
    
 else  if (indexPath.section==1) {
        
        RedTipTableViewCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.L_RedTip.hidden=YES;
        self.tabBarItem.badgeValue=nil;
        switch (indexPath.row) {
            case 0:
            {
                if([user.companyId integerValue]>0)
                {
                NSLog(@"我的申请");
                FShenQingViewController *SQvc =[[FShenQingViewController alloc]init];
                SQvc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:SQvc animated:NO];
                }else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"加入企业后才可使用";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
            }
                break;
            case 1:
            {
               if([user.companyId integerValue]>0)
                {
                NSLog(@"我的批准");
                FBMyPiZhunViewController  *PZvc =[[FBMyPiZhunViewController alloc]init];
                PZvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:PZvc animated:NO];
                }else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"加入企业后才可使用";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
                
            }
                break;
                
            case 2:
            {
                if([user.companyId integerValue]>0)
                {
                NSLog(@"我的任务");
                FRenWuViewController *EWvc =[[FRenWuViewController alloc]init];
                EWvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:EWvc animated:NO];
                }else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"加入企业后才可使用";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
                
            }
                break;
                case 3:
            {
                //我的报销
                 if([user.companyId integerValue]>0)
                 {
                FFMyExpensesViewController *Evc =[[FFMyExpensesViewController alloc]init];
                Evc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Evc animated:NO];
                 }else
                 {
                     MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                     hud.mode = MBProgressHUDModeText;
                     hud.label.text =@"加入企业后才可以使用";
                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                         [MBProgressHUD hideHUDForView:self.view  animated:YES];
                     });
                 }
            }
                break;
            default:
                break;
        }
    }
    
  else  if (indexPath.section==2) {
        switch (indexPath.row) {
            case 0:
            {
                if([user.companyId integerValue]>0)
                {
                NSLog(@"我的打卡");
                TKaoQinViewController *KQvc =[[TKaoQinViewController alloc]init];
                KQvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:KQvc animated:NO];
                }else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"加入企业后才可使用";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
            }
                break;
                
            case 1:
            {
                NSLog(@"我的看板");
                MyShouCangViewController  *SCvc =[[MyShouCangViewController alloc]init];
                SCvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:SCvc animated:NO];
                
            }
                break;
            case 2:
            {
               //我的备忘录
                FBeiWangLuViewController *BWLvc =[[FBeiWangLuViewController alloc]init];
                BWLvc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:BWLvc animated:NO];
                
                
            }
                break;
                case 3:
            {
               //我的学习
            }
                break;
                case 4:
            {
                //我的学习
                
            }
                break;
           
            default:
                break;
        }
    }
    
   else if (indexPath.section==4) {
        
        
        switch (indexPath.row) {
            case 0:
            {
                //我
                MMyViewController *Myvc =[[MMyViewController alloc]init];
                Myvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:Myvc animated:NO];
            }
                break;
            case 1:
            {
                RedTipTableViewCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.L_RedTip.hidden=YES;
                self.tabBarItem.badgeValue=nil;
                if([user.authen integerValue]==0)
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"您未实名认证，不能查看";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }else
                {
                    //我的企业
                    MGongSiViewController *GSvc =[[MGongSiViewController alloc]init];
                    GSvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:GSvc animated:NO];
                }
                
                
            }
                break;
            default:
                break;
        }
       
    }
    
  else  if (indexPath.section==5) {
        //系统设置
        FXiTongViewController *XTvc =[[FXiTongViewController alloc]init];
        XTvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:XTvc animated:NO];
       
        
    }
  else  if (indexPath.section ==3) {
      switch (indexPath.row) {
          case 0:
          {
              //积分中心
              BPCenterViewController *Cvc = [[BPCenterViewController alloc]init];
              Cvc.hidesBottomBarWhenPushed = YES;
              [self.navigationController pushViewController:Cvc animated:NO];
          }
              break;
          case 1:
          {
             ///邀请注册
              YaoQingRegisterViewController *YQvc = [[YaoQingRegisterViewController alloc]init];
              YQvc.hidesBottomBarWhenPushed = YES;
              [self.navigationController pushViewController:YQvc animated:NO];
          }
              break;
              case 2:
          {
             /// 填写邀请人手机号
              
              [WebRequest BP_bind_tele_getPhone_bindWithuserGuid:user.Guid And:^(NSDictionary *dic) {
                  if ([dic[Y_STATUS] integerValue]==200) {
                      MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                      NSDictionary *tdic  = dic[Y_ITEMS];
                      hud.mode = MBProgressHUDModeText;
                      hud.label.text =[NSString stringWithFormat:@"您已经绑定%@",tdic[@"phone"]];
                      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                          [MBProgressHUD hideHUDForView:self.view  animated:YES];
                      });
                  }else
                  {
                      FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                      TFvc.delegate =self;
                      TFvc.indexPath =indexPath;
                      TFvc.content =@"邀请人手机号";
                      TFvc.contentTitle =@"填写邀请人的手机号";
                      TFvc.contentTishi = @"绑定成功后，邀请人与被邀请人各得1000积分";
                      TFvc.hidesBottomBarWhenPushed = YES;
                      [self.navigationController pushViewController:TFvc animated:NO];
                  }
              }];
              
              
          }
              break;
            
          default:
              break;
      }
        
    }
    else
    {
        
    }
    
    
}

#pragma  mark - 单行文字的delegate
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [WebRequest BP_bind_tele_setPhoneBindWithuserGuid:user.Guid phone:content And:^(NSDictionary *dic) {
        
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = dic[Y_MSG];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
       
    }];
}

@end
