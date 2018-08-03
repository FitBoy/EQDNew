//
//  TAddFriendViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TAddFriendViewController.h"
#import "FBScanViewController.h"
#import "ASearchViewController.h"
#import "FBActivityViewController.h"
#import "ExActivity.h"
#import "FB_ShareEQDViewController.h"
#import "Add_phoneContactViewController.h"
@interface TAddFriendViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    UserModel *user;
    
}

@end

@implementation TAddFriendViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title= @"添加好友方式";
    
    
    arr_names = [NSMutableArray arrayWithArray:@[@[@"",@"手机号/易企点号加好友"],@[@"",@"扫一扫加好友"],@[@"",@"邀请朋友注册易企点"],@[@"",@"批量添加手机联系人"]]];

    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *arr = arr_names[indexPath.row];
    cell.textLabel.text =arr[1];
    cell.imageView.image = [UIImage imageNamed:arr[0]];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            case 0:
        {
            NSLog(@"手机号/易企点号加好友");
            ASearchViewController *Avc =[[ASearchViewController alloc]init];
            Avc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:Avc animated:NO];
        }
            break;
        case 1:
        {
        NSLog(@"扫一扫");
            FBScanViewController  *Svc =[[FBScanViewController alloc]init];
            [self.navigationController pushViewController:Svc animated:NO];
        }
            break;
        
        case 2:
        {
            NSString  *Tstr = @"";
            if (user.username.length>1) {
                Tstr =[NSString stringWithFormat:@"%@(%@)",user.uname,user.username];
            }else
            {
                Tstr =user.uname;
            }
            
            FB_ShareEQDViewController *Svc = [[FB_ShareEQDViewController alloc]init];
            Svc.providesPresentationContextTransitionStyle = YES;
            Svc.definesPresentationContext = YES;
            Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            Svc.EQD_ShareType= EQD_ShareTypeText;
            Svc.text =[NSString stringWithFormat:@"【易企点】您的朋友:%@邀请您注册易企点,点击 https://www.eqidd.com/html/adjust.html 注册",Tstr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:Svc animated:NO completion:nil];
            });
          
            /*
         //邀请好友注册易企点
            ExActivity *activity=[[ExActivity alloc]init];
            activity.messageContent = [RCTextMessage messageWithContent:[NSString stringWithFormat:@"【易企点】您的朋友:%@邀请您注册易企点,点击 https://www.eqidd.com/relatedLink/related.html 注册",Tstr]];
           
            FBActivityViewController *ACvc =[[FBActivityViewController alloc]initWithActivityItems:@[[NSString stringWithFormat:@"【易企点】您的朋友:<%@>邀请您注册易企点,点击 https://www.eqidd.com/relatedLink/related.html 注册",Tstr]] applicationActivities:@[activity]];
            
            [self  presentViewController:ACvc animated:NO completion:nil];*/
        }
            break;
        case 3:{
           //添加手机联系人
            Add_phoneContactViewController *Avc =[[Add_phoneContactViewController alloc]init];
            [self.navigationController pushViewController:Avc animated:NO];
        }
            break;
        default:
            break;
    }
}


@end
