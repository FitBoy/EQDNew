//
//  SetPerson_QuanXianViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SetPerson_QuanXianViewController.h"
#import "FBTwo_SwitchTableViewCell.h"
@interface SetPerson_QuanXianViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray  *arr_model;
    BOOL  one ;
    BOOL  two;
}

@end

@implementation SetPerson_QuanXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"工作圈设置";
    user =[WebRequest GetUserInfo];
    
    [WebRequest FriendCircles_Get_NotLook_PowerWithuserGuid:user.Guid friendGuid:self.userGuid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic= dic[Y_ITEMS];
            one = [tdic[@"NotAllToSee"] boolValue];
           two = [tdic[@"NotSee"] boolValue];
            [tableV reloadData];
        }
    }];
     arr_model = [NSMutableArray arrayWithArray:@[@{@"name":@"不让对方看我的工作圈",@"content":@"打开后，对方将无法看到你在工作圈发的动态"},@{@"name":@"不看对方的工作圈",@"content":@"打开后，你将无法看到对方在工作圈发的动态"}]];
    arr_model = [NSMutableArray arrayWithArray:@[@{@"name":@"不让对方看我的工作圈",@"content":@"打开后，对方将无法看到你在工作圈发的动态",@"isKai":@"NO"},@{@"name":@"不看对方的工作圈",@"content":@"打开后，你将无法看到对方在工作圈发的动态",@"isKai":@"NO"}]];
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
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_SwitchTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_SwitchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *tdic = arr_model[indexPath.row];
    cell.L_left0.text = tdic[@"name"];
    cell.L_left1.text =tdic[@"content"];
    cell.S_kai.on = indexPath.row==0?one:two;
    cell.S_kai.indexPath =indexPath;
      [cell.S_kai addTarget:self action:@selector(kaiguanClick:) forControlEvents:UIControlEventValueChanged];
    return cell;
}
-(void)kaiguanClick:(FBindexPathSwitch*)kaiguan
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    if (kaiguan.indexPath.row==0) {
        if (kaiguan.on ==NO) {
            [WebRequest FriendCircles_Set_Cancle_NotAllowToSeeWithuserGuid:user.Guid friendGuid:self.userGuid And:^(NSDictionary *dic) {
                if([dic[Y_STATUS] integerValue]==200)
                {
                    hud.label.text =@"修改成功";
                    one=kaiguan.on;
                }else
                {
                    hud.label.text =@"未知错误，请重试";
                }
            }];
        }else
        {
        [WebRequest  FriendCircles_Set_NotAllowToSeeWithuserGuid:user.Guid friendGuid:self.userGuid And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==200)
            {
                hud.label.text =@"修改成功";
                one=kaiguan.on;
            }else
            {
                hud.label.text =@"未知错误，请重试";
            }
        }];
        }
    }else
    {
        if (kaiguan.on==NO) {
            [WebRequest FriendCircles_Set_Cancle_NotLookWithuserGuid:user.Guid friendGuid:self.userGuid And:^(NSDictionary *dic) {
                if([dic[Y_STATUS] integerValue]==200)
                {
                    hud.label.text =@"修改成功";
                    one=kaiguan.on;
                }else
                {
                    hud.label.text =@"未知错误，请重试";
                }
            }];
            
        }else
        {
            [WebRequest FriendCircles_Set_NotLookWithuserGuid:user.Guid friendGuid:self.userGuid And:^(NSDictionary *dic) {
                if([dic[Y_STATUS] integerValue]==200)
                {
                    hud.label.text =@"修改成功";
                    one=kaiguan.on;
                }else
                {
                    hud.label.text =@"未知错误，请重试";
                }
            }];
        }
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
    });
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
