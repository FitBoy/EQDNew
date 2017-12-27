//
//  ChengYuanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ChengYuanViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "QunMember.h"
#import "FBTwo_img11TableViewCell.h"
@interface ChengYuanViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_chengyuan;
    NSMutableArray *tarr;
    NSMutableArray *arr_chengyun_small;
    UIBarButtonItem *right;
}
@end

@implementation ChengYuanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [arr_chengyun_small removeAllObjects];
}
-(void)loadRequestData{
    
    [WebRequest  User_GroupmemberWithgroupid:self.targeId And:^(NSDictionary *dic) {
        [arr_chengyuan removeAllObjects];
        [tarr removeAllObjects];
        NSNumber *number = dic[@"status"];
        NSArray *users = dic[@"items"];
        if ([number integerValue]==200) {
            if (users.count) {
                for (NSDictionary *dic1 in users) {
                    QunMember *model = [QunMember mj_objectWithKeyValues:dic1];
                    [arr_chengyuan addObject:model];
                    [tarr addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadData];
                });
            }
        }
    }];
    
  
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_chengyuan = [NSMutableArray arrayWithCapacity:0];
    tarr  = [NSMutableArray arrayWithCapacity:0];
    arr_chengyun_small = [NSMutableArray arrayWithCapacity:0];
    
    right = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(QunFaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   adjustsScrollViewInsets_NO(tableV, self);

  }

-(void)QunFaClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"发送有延迟，若失败请重发";
    //针对某个群成员群发
    [[RCIM sharedRCIM] sendDirectionalMessage:ConversationType_GROUP targetId:self.targeId toUserIdList:arr_chengyun_small content:self.MessageContent pushContent:nil pushData:nil success:^(long messageId) {
       
       
    } error:^(RCErrorCode nErrorCode, long messageId) {
        
       
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.label.text =@"发送有延迟，若失败请重发";
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    });
    
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_chengyuan =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"upname CONTAINS[cd] %@",searchText];
        arr_chengyuan = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    [tableV reloadData];
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_chengyuan.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    QunMember *model = arr_chengyuan[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QunMember *model = arr_chengyuan[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType ==UITableViewCellAccessoryNone ) {
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
        RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:model.Guid  name:model.upname portrait:model.iphoto];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.Guid];
        [arr_chengyun_small addObject:model.Guid];
    }
    else
    {
        cell.accessoryType =UITableViewCellAccessoryNone;
        [arr_chengyun_small removeObject:model.Guid];
        
    }
}



@end
