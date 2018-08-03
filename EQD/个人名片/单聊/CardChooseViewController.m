//
//  CardChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CardChooseViewController.h"
#import "BMChineseSort.h"
#import "HaoYouModel.h"
#import "FBchengyuanTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "FBGeRenCardMessageContent.h"
#import "Com_UserModel.h"
#import <RongIMKit/RongIMKit.h>
#import "CC_TongShiViewController.h"
@interface CardChooseViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_friends;
    NSMutableArray *tarr;
    NSMutableArray *arr_index;
    NSMutableArray *arr_sort;
    UserModel *user ;
    
    Com_UserModel *com_user;
}

@end

@implementation CardChooseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest User_GetFriendListuid:user.Guid And:^(NSDictionary *dic) {
        [arr_friends removeAllObjects];
        [tarr removeAllObjects];
        
        NSNumber *number =dic[Y_STATUS];
        NSArray *arr =dic[Y_ITEMS];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    HaoYouModel *model = [HaoYouModel mj_objectWithKeyValues:dic1];
                    [arr_friends addObject:model];
                    [tarr addObject:model];
                }
            }
            arr_index = [BMChineseSort IndexWithArray:arr_friends Key:@"upname"];
            arr_sort = [BMChineseSort sortObjectArray:arr_friends Key:@"upname"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV.mj_header endRefreshing];
                [tableV reloadData];
            });
        }
    }];
    
    
    [WebRequest Com_User_BusinessCardWithuserGuid:self.userGuid And:^(NSDictionary *dic) {
        com_user = [Com_UserModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_friends =[NSMutableArray arrayWithCapacity:0];
    arr_index=[NSMutableArray arrayWithCapacity:0];
    arr_sort=[NSMutableArray arrayWithCapacity:0];
    tarr =[NSMutableArray arrayWithCapacity:0];
    
    self.navigationItem.title =@"选择名片";
    adjustsScrollViewInsets_NO(tableV, self);
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"快速查找好友";
    arr_names = [NSMutableArray arrayWithArray:@[@"同事名片"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self );
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_friends =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"upname CONTAINS[cd] %@",searchText];
        arr_friends = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    
    arr_index = [BMChineseSort IndexWithArray:arr_friends Key:@"upname"];
    arr_sort = [BMChineseSort sortObjectArray:arr_friends Key:@"upname"];
    [tableV reloadData];
    
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_index.count+1;
}
-(NSArray<NSString*>*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return arr_index;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return nil;
    }
    return arr_index[section-1];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    NSArray *arr =arr_sort[section-1];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text =arr_names[indexPath.row];
        return cell;
 
    }
    else
    {
        static NSString *chengyuancel =@"chengyuancel";
        FBchengyuanTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:chengyuancel];
        if (!cell1) {
            cell1 =[[FBchengyuanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chengyuancel];
            cell1.accessoryType = UITableViewCellAccessoryNone;
        }
        NSArray *arr = arr_sort[indexPath.section-1];
        HaoYouModel *model =arr[indexPath.row];
        [cell1.IV_headimg setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        cell1.L_name.text = model.upname;
        cell1.L_date.text =model.uname;
        return cell1;
        
    }
    
    
    }

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //同事名片
        CC_TongShiViewController *TSvc =[[CC_TongShiViewController alloc]init];
        TSvc.userGuid =self.userGuid;
        TSvc.isQun =self.isQun;
        [self.navigationController pushViewController:TSvc animated:NO];
        
        
    }
    
    else
    {
        NSArray *arr =arr_sort[indexPath.section-1];
        HaoYouModel *model =arr[indexPath.row];
        NSString *name_str =@"";
        if (self.isQun==NO) {
            
            name_str =[NSString stringWithFormat:@"您将要给%@发%@的名片",com_user.upname,model.upname];
        }
        else
        {
            
            name_str=[NSString stringWithFormat:@"您将要发%@的名片",model.upname];
        }
        
        
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:name_str message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在生成名片";
            
            [WebRequest Com_User_BusinessCardWithuserGuid:model.Guid And:^(NSDictionary *dic) {
                [hud hideAnimated:NO];
                Com_UserModel *com_usermodel2 =[Com_UserModel mj_objectWithKeyValues:dic[Y_ITEMS] ];
                NSDictionary *dic2 = @{
                                       @"imgurl":com_usermodel2.photo,
                                       @"name":com_usermodel2.upname,
                                       @"bumen":com_usermodel2.department,
                                       @"gangwei":com_usermodel2.post,
                                       @"company":com_usermodel2.company,
                                       @"uid":com_usermodel2.userGuid,
                                       @"comid":com_usermodel2.companyId
                                       };
                FBGeRenCardMessageContent *content =[[FBGeRenCardMessageContent alloc]initWithgeRenCardWithcontent:dic2];
                RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:user.uname name:user.upname portrait:user.iphoto];
                content.senderUserInfo =userinfo;
                if(self.isQun==NO)
                {
                    [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:self.userGuid content:content pushContent:nil pushData:nil success:nil error:nil];
                }
                else
                {
                    [[RCIM sharedRCIM] sendMessage:ConversationType_GROUP targetId:self.userGuid content:content pushContent:nil pushData:nil success:nil error:nil];
                }
                 [self.navigationController popViewControllerAnimated:NO];
            }];
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    }
    
}



@end
