//
//  SDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SDetailViewController.h"
#import "SDetailModel.h"
#import <UIImageView+AFNetworking.h>
#import "FBTwo_img11TableViewCell.h"
#import "FBButton.h"
#import "FBConversationViewControllerViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
@interface SDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    SDetailModel *model;
    NSInteger temp;
    NSMutableArray *arr_two;
    NSMutableArray *arr_three;
    UserModel *user;
}

@end

@implementation SDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
   [WebRequest User_Friend_SeachWithuserGuid:user.Guid account:self.friendID And:^(NSDictionary *dic) {
       NSNumber *number = dic[Y_STATUS];
      
       if ([number integerValue]==200) {
           //好友的基本信息
           model = [SDetailModel mj_objectWithKeyValues:dic[Y_ITEMS][0]];
           model.type = @"1";
          
       }
       else if([number integerValue]==203)
       {
           ///个人的基本信息
           model = [SDetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
           model.type =@"0";
       }
       else
       {
           //该用户未注册
           model = [[SDetailModel alloc]init];
           model.type=@"2";
       }
       temp=1;
       [tableV reloadData];
   }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title = @"详细资料";
    temp=0;
    arr_two = [NSMutableArray arrayWithArray:@[@"手机号",@"地区"]];
    arr_three = [NSMutableArray arrayWithArray:@[@"公司",@"部门/职务"]];

    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;

}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (model) {
        return 4;
    }
    else
    {
        return 0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (model) {
        if (section==1||section==2) {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return 0;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        FBTwo_img11TableViewCell  *cell = [[FBTwo_img11TableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        if ([model.type integerValue]<2) {
            [cell setModel:model];
        }
        
        else
        {
            cell.textLabel.text = @"该号未注册易企点";
        }
        return cell;
    }
    else if(indexPath.section==1|| indexPath.section==2)
    {
        static NSString *cellid12 =@"cellid12";
        FBTwo_noimg12TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid12];
        if (!cell) {
            cell=[[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid12];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section==1) {
            cell.L_left0.text =arr_two[indexPath.row];
            cell.L_right0.text = indexPath.row==0?model.uname:model.LoginLocation;
        }
        else
        {
            if ([model.type integerValue]==1) {
                cell.L_right0.text=indexPath.row==0?model.com_name:[NSString stringWithFormat:@"%@/ %@",model.departName,model.postName];
            }
            else if([model.type integerValue]==0)
            {
                cell.L_right0.text=indexPath.row==0?model.company:[NSString stringWithFormat:@"%@/ %@",model.department,model.post];
            }
            else
            {
                cell.L_right0.text=@"";
            }
            cell.L_left0.text = arr_three[indexPath.row];
            
        }
        
        return cell;
    }
    
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        if ([model.type integerValue]==0) {
            cell.textLabel.text = @"添加好友";
        }
        else if([model.type integerValue]==1)
        {
            if ([model.Sign integerValue]==0 && [model.ORD isEqualToString:@"user"]) {
                cell.textLabel.text = @"等待对方处理申请";
            }
            else if( [model.Sign integerValue]==0 && [model.ORD isEqualToString:@"friend"])
            {
                cell.backgroundColor = [UIColor whiteColor];
                FBButton *tbtn1 = [FBButton buttonWithType:UIButtonTypeSystem];
                tbtn1.frame = CGRectMake(15, 0, DEVICE_WIDTH/2.0-20, 50);
                [tbtn1 setTitle:@"拒绝" titleColor:nil backgroundColor:nil font:[UIFont systemFontOfSize:21]];
                tbtn1.layer.borderWidth=1;
                tbtn1.layer.borderColor=[UIColor blackColor].CGColor;
                [cell addSubview:tbtn1];
                
                FBButton *tbtn2 =[FBButton buttonWithType:UIButtonTypeSystem];
                tbtn2.frame = CGRectMake(DEVICE_WIDTH/2.0+5, 0, DEVICE_WIDTH/2.0-20, 50);
               
                [tbtn2 setTitle:@"同意" titleColor: [UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:21]];
                [cell addSubview:tbtn2];
                
                [tbtn1 addTarget:self action:@selector(jujueClick) forControlEvents:UIControlEventTouchUpInside];
                [tbtn2 addTarget:self action:@selector(tongyiClick) forControlEvents:UIControlEventTouchUpInside];
                
                
            }
            else if([model.Sign integerValue]==1)
            {
                cell.textLabel.text = @"发消息";
            }
            else
            {
                cell.textLabel.text = @"添加好友";
            }
            
        }
        else
        {
            cell.textLabel.text = @"邀请他(她)注册易企点";
        }
        return  cell;
 
    }
    

}
//添加好友
-(void)addfriend{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"附加信息" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"我是……";
        
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在发送好友申请";
        [WebRequest User_AddFriendWithuserid:user.Guid friendid:model.Guid content:alert.textFields[0].text And:^(NSDictionary *dic) {
            NSNumber *number  = dic[Y_STATUS];
            [hud hideAnimated:NO];
            NSString *msg = dic[Y_MSG];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =msg;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
                [self.navigationController popToRootViewControllerAnimated:NO];
            });
        }];
        
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
    
    
    
}
-(void)jujueClick
{
    [self agreeFriendWithtype:@"false"];
}
-(void)tongyiClick
{
    [self agreeFriendWithtype:@"true"];
}
///同意 拒绝 申请好友
-(void)agreeFriendWithtype:(NSString*)type
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
    [WebRequest User_Friend_OptionWithuserGuid:user.Guid friendGuid:model.Guid type:type And:^(NSDictionary *dic) {
        NSNumber *number = dic[Y_STATUS];
        NSString *msg = dic[Y_MSG];
        hud.label.text =msg;
        if ([number integerValue]==200) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [hud hideAnimated:NO];
                [self.navigationController popToRootViewControllerAnimated:NO];
            });
        }
    }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([model.type integerValue]==0) {
        [self addfriend];
    }
    else if([model.type integerValue]==1)
    {
        if ([model.Sign integerValue]==0 && [model.ORD isEqualToString:@"user"]) {
            //  等待对方处理申请
        }
        else if( [model.Sign integerValue]==0 && [model.ORD isEqualToString:@"friend"])
        {
            //同意好友申请
//            cell.textLabel.text = @"同意";
        }
        else if([model.Sign integerValue]==1)
        {
            ///发消息
            FBConversationViewControllerViewController  *oneTooneChat =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.Guid];
            oneTooneChat.navigationItem.title =model.upname;
            oneTooneChat.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:oneTooneChat animated:NO];
        }
        else
        {
            [self addfriend];
        }
        
    }
    else
    {
//        cell.textLabel.text = @"邀请他(她)注册易企点";
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    temp=0;
}

@end
