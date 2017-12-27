//
//  QYQHaoYouViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QYQHaoYouViewController.h"
#import "HaoYouModel.h"
#import "BMChineseSort.h"
#import <UIImageView+AFNetworking.h>
#import "FBOne_imgChooseTableViewCell.h"
#import "QunMember.h"
@interface QYQHaoYouViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_haoyou;
    NSMutableArray *arr_addhaoyou;
    NSMutableArray *arr_index;
    NSMutableArray *arr_sort;
    UserModel *user;
}

@end

@implementation QYQHaoYouViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest User_GetFriendListuid:user.Guid And:^(NSDictionary *dic) {
        [arr_haoyou removeAllObjects];

        
        NSNumber *number =dic[Y_STATUS];
        NSArray *arr =dic[Y_ITEMS];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    HaoYouModel *model = [HaoYouModel mj_objectWithKeyValues:dic1];
                    [arr_haoyou addObject:model];
                }
            }
            arr_index = [BMChineseSort IndexWithArray:arr_haoyou Key:@"upname"];
            arr_sort = [BMChineseSort sortObjectArray:arr_haoyou Key:@"upname"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV.mj_header endRefreshing];
                [tableV reloadData];
            });
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"邀请好友加群";
    arr_addhaoyou = [NSMutableArray arrayWithCapacity:0];
    arr_haoyou = [NSMutableArray arrayWithCapacity:0];
    arr_index = [NSMutableArray arrayWithCapacity:0];
    arr_sort = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"邀请" style:UIBarButtonItemStylePlain target:self action:@selector(yaoqingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    /*arr_qunChengyuan =[NSMutableArray arrayWithCapacity:0];
    [WebRequest User_GroupmemberWithgroupid:self.model.groupid And:^(NSDictionary *dic) {
        NSArray *tarr1 =dic[Y_ITEMS];
        for (int i=0; i<tarr1.count; i++) {
            QunMember *model=[QunMember mj_objectWithKeyValues:tarr[i]];
            [arr_qunChengyuan addObject:model];
        }
        [tableV reloadData];
    }];*/


}
-(void)yaoqingClick
{
    NSMutableString *uid =[NSMutableString string];
   
    for (int i=0; i<arr_haoyou.count; i++) {
        HaoYouModel  *model =arr_haoyou[i];
        if(model.ischoose==YES)
        {
        [uid appendFormat:@";%@",model.Guid];
        }else
        {
            
        }
    }
    
    if(uid.length==0)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"请选择至少一个人";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在添加";
    
    [WebRequest User_AddgroupWithuserGuid:uid Groupid:self.model.groupid GroupName:self.model.groupname And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    
    }
    
}

#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_index.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = arr_sort[section];
    return arr.count;
}

-(NSArray <NSString*>*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return arr_index;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return arr_index.count;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_index[section];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOne_imgChooseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOne_imgChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSArray *arr =arr_sort[indexPath.section];
    HaoYouModel *model =arr[indexPath.row];
    
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBOne_imgChooseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray *arr =arr_sort[indexPath.section];
  
    HaoYouModel *model =arr[indexPath.row];
    model.ischoose = !model.ischoose;
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
   
}



@end
