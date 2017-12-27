//
//  MMyViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MMyViewController.h"
#import "EQDLoginViewController.h"
#import "WebRequest.h"
#import "MMGeRenCardViewController.h"
#import "LTrueNameViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <JrmfWalletKit/JrmfWalletKit.h>
#import "MSafeViewController.h"
#import "MyShouCangViewController.h"
@interface MMyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_big;
    NSMutableArray *arr_one;
    NSMutableArray *arr_two;
    NSMutableArray *arr_three;
    NSMutableArray *arr_four;
    UserModel *user;
}

@end

@implementation MMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"我的";
    arr_one = [NSMutableArray arrayWithArray:@[@"个人资料",@"个人实名认证"]];
    arr_two = [NSMutableArray arrayWithArray:@[@"钱包",@"收藏"]];
    arr_three = [NSMutableArray arrayWithArray:@[@"安全"]];
    arr_four = [NSMutableArray arrayWithArray:@[@"退出登录"]];
    arr_big = [NSMutableArray arrayWithCapacity:0];
    [arr_big addObject:arr_one];
    [arr_big addObject:arr_two];
    [arr_big addObject:arr_three];
    [arr_big addObject:arr_four];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=40;
    

    
}

#pragma  mark - 表的数据源
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
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if (indexPath.section==3) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.contentView.layer.backgroundColor = [UIColor redColor].CGColor;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSArray *arr = arr_big[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //个人名片   个人实名认证
        switch (indexPath.row) {
            case 0:
            {
                MMGeRenCardViewController *GRvc =[[MMGeRenCardViewController alloc]init];
                [self.navigationController pushViewController:GRvc animated:NO];
            }
                break;
            case 1:
            {
                
                if ([user.authen integerValue]==0) {
                    LTrueNameViewController *TNvc =[[LTrueNameViewController alloc]init];
                    TNvc.isFirst=NO;
                    [self.navigationController pushViewController:TNvc animated:NO];
                }
                else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"您已实名认证";
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
    else if (indexPath.section==1)
    {
        switch (indexPath.row) {
            case 0:
            {
               //钱包
                [JrmfWalletSDK openWallet];
           
            }
                break;
            case 1:
            {
                NSLog(@"收藏");
                MyShouCangViewController  *SCvc =[[MyShouCangViewController alloc]init];
                [self.navigationController pushViewController:SCvc animated:NO];
            }
                break;

                
            default:
                break;
        }
    }
    else if (indexPath.section==2)
    {
        switch (indexPath.row) {
            case 0:
            {
                //安全
                MSafeViewController *Svc =[[MSafeViewController alloc]init];
                [self.navigationController pushViewController:Svc animated:NO];
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        NSLog(@"退出");
        [USERDEFAULTS removeObjectForKey:Y_USERINFO];
        [USERDEFAULTS removeObjectForKey:RC_TOKEN];
        [USERDEFAULTS removeObjectForKey:Y_MIMA];
        [USERDEFAULTS synchronize];
        [[RCIM sharedRCIM] logout];
        EQDLoginViewController *login =[[EQDLoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        self.view.window.rootViewController =nav;
    }
    
    
}



@end
