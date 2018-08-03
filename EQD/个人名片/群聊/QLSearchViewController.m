//
//  QLSearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "QLSearchViewController.h"
#import <UIImageView+AFNetworking.h>
#import "qunListModel.h"
#import "FBOne_img1TableViewCell.h"
#import <Masonry.h>
@interface QLSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_result;
    UISearchBar * searchBar;
    UserModel *user;
}

@end

@implementation QLSearchViewController
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"搜索群";
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索易企点的群";
    
    arr_result = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [tableV reloadData];
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return arr_result.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 20;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return nil;
    }
    return @"搜索群的结果";
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOne_img1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOne_img1TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
    if(indexPath.section==0)
    {
        [cell.B_img setBackgroundImage:[UIImage imageNamed:@"seach.png"] forState:UIControlStateNormal];
       cell.L_name.text = [NSString stringWithFormat:@"搜索：%@",searchBar.text];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        qunListModel *model = arr_result[indexPath.row];
        [cell setModel:model];
    }
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [WebRequest Usre_SearchGroupWithgroupname:searchBar.text groupid:nil  And:^(NSDictionary *dic) {
            [arr_result removeAllObjects];
            NSNumber *number = dic[Y_STATUS];
            NSArray *arr = dic[Y_ITEMS];
            if ([number integerValue]==200) {
                if (arr.count) {
                    for (NSDictionary *dic1  in arr) {
                        qunListModel *model = [qunListModel mj_objectWithKeyValues:dic1];
                        [arr_result addObject:model];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadData];
                });
            }
            
        }];
        
    }
    else
    {
        qunListModel *model = arr_result[indexPath.row];
        UIAlertController *alert = [self alertWithTitle:model.groupname message:@"您将要加入该群" alertControllerStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在处理";
            NSString *userGuid = [NSString stringWithFormat:@";%@",user.Guid];
            [WebRequest User_AddgroupWithuserGuid:userGuid Groupid:model.groupid  GroupName:model.groupname And:^(NSDictionary *dic) {
                NSString *msg =dic[Y_MSG];
                hud.label.text = msg;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }];
          
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
        
    }
}


@end
