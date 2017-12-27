//
//  FBFriendViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBFriendViewController.h"
#import "HaoYouModel.h"
#import "BMChineseSort.h"
#import <UIImageView+AFNetworking.h>
#import "FBchengyuanTableViewCell.h"
#import "FBGeRenCardMessageContent.h"
@interface FBFriendViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_haoyou;
    NSMutableArray *tarr;
    NSMutableArray *arr_addhaoyou;
    NSMutableArray *arr_index;
    NSMutableArray *arr_sort;
    UserModel *user;
}


@end

@implementation FBFriendViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    
    [WebRequest User_GetFriendListuid:user.Guid And:^(NSDictionary *dic) {
        [arr_haoyou removeAllObjects];
        [tarr removeAllObjects];
        
        NSNumber *number =dic[Y_STATUS];
        NSArray *arr =dic[Y_ITEMS];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    HaoYouModel *model = [HaoYouModel mj_objectWithKeyValues:dic1];
                    [arr_haoyou addObject:model];
                    [tarr addObject:model];
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
    self.navigationItem.title =@"好友列表";
    arr_addhaoyou = [NSMutableArray arrayWithCapacity:0];
    arr_haoyou = [NSMutableArray arrayWithCapacity:0];
    tarr = [NSMutableArray arrayWithCapacity:0];
    arr_index = [NSMutableArray arrayWithCapacity:0];
    arr_sort = [NSMutableArray arrayWithCapacity:0];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    adjustsScrollViewInsets_NO(tableV, self);
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(yaoqingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)yaoqingClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"发送有延迟，若失败请重发";
    
    for (HaoYouModel *model in arr_addhaoyou) {
        
        RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:model.Guid  name:model.upname portrait:model.iphoto];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.Guid];
        if([self.messageContent isKindOfClass:[RCTextMessage class]]|| [self.messageContent isKindOfClass:[RCVoiceMessage class]]||[self.messageContent isKindOfClass:[RCRichContentMessage class]]|| [self.messageContent isKindOfClass:[RCLocationMessage class]] || [self.messageContent isKindOfClass:[FBGeRenCardMessageContent class]])
        {
            [[RCIM sharedRCIM ]sendMessage:ConversationType_PRIVATE targetId:model.Guid content:self.messageContent pushContent:nil pushData:nil success:^(long messageId) {
              
            } error:^(RCErrorCode nErrorCode, long messageId) {
            }];
            
            
        }
        else if([self.messageContent isKindOfClass:[RCFileMessage class]] || [self.messageContent isKindOfClass:[RCImageMessage class]])
        {
            [[RCIM sharedRCIM]sendMediaMessage:ConversationType_PRIVATE targetId:model.Guid content:self.messageContent pushContent:nil pushData:nil progress:nil success:^(long messageId) {
                
            } error:^(RCErrorCode errorCode, long messageId) {
                
            } cancel:^(long messageId) {
                
            }];
            
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"不支持此类型的转发";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            hud.label.text =@"发送有延迟，若失败请重发";
            [hud hideAnimated:NO];
            [self dismissViewControllerAnimated:NO completion:nil];
        });
    }

    
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
   
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_haoyou =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"upname CONTAINS[cd] %@",searchText];
        arr_haoyou = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    
    arr_index = [BMChineseSort IndexWithArray:arr_haoyou Key:@"upname"];
    arr_sort = [BMChineseSort sortObjectArray:arr_haoyou Key:@"upname"];
    [tableV reloadData];
    
    
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
    FBchengyuanTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBchengyuanTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSArray *arr =arr_sort[indexPath.section];
    HaoYouModel *model =arr[indexPath.row];
    
    
    [cell.IV_headimg setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    cell.L_name.text = model.upname;
    cell.L_date.text = model.uname;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray *arr =arr_sort[indexPath.section];
    HaoYouModel *model =arr[indexPath.row];
    
    if (cell.accessoryType ==UITableViewCellAccessoryNone) {
        
        if (arr_addhaoyou.count>4) {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"最多选中5个"];
        }
        else
        {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [arr_addhaoyou addObject:model];
        }
    }
    else
    {
        cell.accessoryType =UITableViewCellAccessoryNone;
        [arr_addhaoyou removeObject:model];
    }
}




@end
