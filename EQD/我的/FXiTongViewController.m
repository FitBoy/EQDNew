//
//  FXiTongViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FXiTongViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "MyAboutUsViewController.h"
#import "EQDLoginViewController.h"
#import "FanKui_ListViewController.h"
#import <StoreKit/StoreKit.h>
@interface FXiTongViewController ()<UITableViewDelegate,UITableViewDataSource,SKStoreProductViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *arr_three;
    NSMutableArray *arr_four;
    NSMutableArray *arr_big;
    UISwitch *S_voice;
    UISwitch *S_notification;
}

@end

@implementation FXiTongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统设置";
    arr_one = [NSMutableArray arrayWithArray:@[@"消息提示音",@"通知"]];
    arr_two = [NSMutableArray arrayWithArray:@[@"帮助与反馈",@"关于易企点"]];
    arr_four = [NSMutableArray arrayWithArray:@[@"当前版本"]];
    arr_three = [NSMutableArray arrayWithArray:@[@"退出登录"]];
    arr_big = [NSMutableArray arrayWithCapacity:0];
    
    [arr_big addObject:arr_one];
    [arr_big addObject:arr_two];
    [arr_big addObject:arr_four];
    [arr_big addObject:arr_three];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    S_voice = [[UISwitch alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-70, 5, 70, 30)];
    [S_voice setOn:![RCIM sharedRCIM].disableMessageAlertSound animated:YES];
    [S_voice addTarget:self action:@selector(voiceClick) forControlEvents:UIControlEventValueChanged];
    
    S_notification=[[UISwitch alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-70, 5, 70, 30)];
    [S_notification setOn:![RCIM sharedRCIM].disableMessageNotificaiton animated:YES];
    [S_notification addTarget:self action:@selector(notificationClick) forControlEvents:UIControlEventValueChanged];
    
    
    
}
-(void)voiceClick
{
    [RCIM sharedRCIM].disableMessageAlertSound = !S_voice.on;
}
-(void)notificationClick
{
    [RCIM sharedRCIM].disableMessageNotificaiton = !S_notification.on;
   
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_big.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = arr_big[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        
    }
    cell.detailTextLabel.text =nil;
    NSArray *arr = arr_big[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    if(indexPath.section==0)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row==0) {
            [cell addSubview:S_voice];
        }
        else
        {
            [cell addSubview:S_notification];
        }
    }
    else if(indexPath.section==1)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.section==2)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text =arr_four[indexPath.row];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // 当前应用软件版本  比如：1.0.1
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        cell.detailTextLabel.text = appCurVersion;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.contentView.backgroundColor  =[UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:
            {//帮助与反馈
                FanKui_ListViewController *Fvc =[[FanKui_ListViewController alloc]init];
                [self.navigationController pushViewController:Fvc animated:NO];
            }
                break;
            case 1:
            {
                //关于易企点
                MyAboutUsViewController *AUvc =[[MyAboutUsViewController alloc]init];
                [self.navigationController pushViewController:AUvc animated:NO];
            }
                break;
            default:
                break;
        }
    }else if (indexPath.section==2)
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        //检测版本
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在检测版本";
        [WebRequest Extended_Get_VersionInfoWithtype:@"iOS" version:appCurVersion And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==300)
            {
                hud.label.text = @"当前已经是最新的版本";
            }else if ([dic[Y_STATUS] integerValue]==200)
            {
                [hud hideAnimated:NO];
                NSDictionary *dic2 =dic[Y_ITEMS];
                UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"新版本" message:dic2[@"remark"] preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
                    //设置代理请求为当前控制器本身
                    storeProductViewContorller.delegate = self;
                    //加载一个新的视图展示
                    [storeProductViewContorller loadProductWithParameters:
                     //appId唯一的
                     @{SKStoreProductParameterITunesItemIdentifier : @"1313172913"} completionBlock:^(BOOL result, NSError *error) {
                         //block回调
                         if(error){
                             NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
                         }else{
                             //模态弹出appstore
                             [self presentViewController:storeProductViewContorller animated:YES completion:^{
                                 
                             }
                              ];
                         }
                     }];
                    
                    
                    
                    
                                  
                    
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:NO completion:nil];
                
            }else
            {
                hud.label.text =@"服务器错误";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
        
    }else if (indexPath.section==3) {
        
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"您确认退出登录？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"登出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [USERDEFAULTS removeObjectForKey:Y_USERINFO];
            [USERDEFAULTS removeObjectForKey:RC_TOKEN];
            [USERDEFAULTS removeObjectForKey:Y_MIMA];
            [USERDEFAULTS synchronize];
            [[RCIM sharedRCIM] logout];
            EQDLoginViewController *login =[[EQDLoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
            self.view.window.rootViewController =nav;

        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
    }
    else
    {
    }
}

//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
