//
//  TXLFriendShengQingViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TXLFriendShengQingViewController.h"
#import "WebRequest.h"
#import "FBHaoYouModel.h"
#import "FBNewFriendTableViewCell.h"
#import <UIImageView+AFNetworking.h>
@interface TXLFriendShengQingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_friendShenqing;
    UserModel *user;
}

@end

@implementation TXLFriendShengQingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"200" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    
    [WebRequest User_AddFriend_RequestWithuid:user.Guid And:^(NSDictionary *dic) {
        [arr_friendShenqing removeAllObjects];
        NSNumber *number =dic[Y_STATUS];
        NSString *msg =dic[Y_MSG];
        if ([number integerValue]==200 ) {
            NSArray *arr =dic[Y_ITEMS];
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    FBHaoYouModel  *model = [FBHaoYouModel mj_objectWithKeyValues:dic1];
                    if ([model.ORD isEqualToString:@"friend"]) {
                         [arr_friendShenqing addObject:model];
                    }
                    else
                    {
                        
                    }
                   
                    
                }
            }
            
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"没有好友申请";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        });
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    
     self.view.backgroundColor =[UIColor whiteColor];
    arr_friendShenqing =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"新朋友";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    [tableV.mj_header beginRefreshing];
}





#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_friendShenqing.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBNewFriendTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBNewFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    FBHaoYouModel *model =arr_friendShenqing[indexPath.row];
    
    cell.L_name.text=[NSString stringWithFormat:@"%@",model.upname];
    cell.L_date.text =[NSString stringWithFormat:@"备注：%@",model.Message] ;
    
    if ([model.Sign integerValue]==1) {
        [cell.B_btn setTitle:@"已添加" forState:UIControlStateNormal];
        [cell.B_btn setBackgroundColor:[UIColor whiteColor]];
        [cell.B_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cell.B_btn.enabled=NO;
    }
    else if([model.Sign integerValue]==-1)
    {
        [cell.B_btn setTitle:@"已拒绝" forState:UIControlStateNormal];
        [cell.B_btn setBackgroundColor:[UIColor whiteColor]];
        [cell.B_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cell.B_btn.enabled=NO;
    }
    else
    {
        [cell.B_btn addTarget:self action:@selector(tongyiClilck:) forControlEvents:UIControlEventTouchUpInside];
        cell.B_btn.indexPath=indexPath;
    }
    
   
    [cell.IV_headimg setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    
    
    
    return cell;
}

///同意 拒绝 申请好友
-(void)agreeFriendWithtype:(NSString*)type Withguid:(NSString*)guid
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
    [WebRequest User_Friend_OptionWithuserGuid:user.Guid friendGuid:guid type:type And:^(NSDictionary *dic) {
        NSNumber *number = dic[Y_STATUS];
        NSString *msg = dic[Y_MSG];
        hud.label.text =msg;
        if ([number integerValue]==200) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [hud hideAnimated:NO];
            });
        }
        [self loadRequestData];
    }];
    
}
-(void)tongyiClilck:(FBindexpathButton*)btn{
    FBHaoYouModel *model =arr_friendShenqing[btn.indexPath.row];
    [self agreeFriendWithtype:@"true" Withguid:model.Guid];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBHaoYouModel *model = arr_friendShenqing[indexPath.row];
    if ([model.Sign integerValue]==1) {
        return NO;
    }
    else if([model.Sign integerValue]==-1)
    {
        return NO;
    }
    else
    {
      return YES;  
    }
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBHaoYouModel *model =arr_friendShenqing[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self agreeFriendWithtype:@"false" Withguid:model.Guid];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"拒绝";
}




@end
