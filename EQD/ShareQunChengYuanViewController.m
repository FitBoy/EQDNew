//
//  ShareQunChengYuanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ShareQunChengYuanViewController.h"
#import "qunListModel.h"
#import <UIImageView+AFNetworking.h>
#import "ChengYuanViewController.h"
#import "FBchengyuanTableViewCell.h"
#import <Masonry.h>
@interface ShareQunChengYuanViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *tarr;
    NSMutableArray *arr_qun;
    UserModel *user;
}

@end

@implementation ShareQunChengYuanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest User_GetGroupsWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        [arr_qun removeAllObjects];
        [tarr removeAllObjects];
        NSNumber *number =dic[@"status"];
        NSArray *arr =dic[@"items"];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    qunListModel *model = [qunListModel mj_objectWithKeyValues:dic1];
                    [arr_qun addObject:model];
                    [tarr addObject:model];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [tableV reloadData];
            });
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_qun = [NSMutableArray arrayWithCapacity:0];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"快速查找群";
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    adjustsScrollViewInsets_NO(tableV, self);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_qun =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"groupname CONTAINS[cd] %@",searchText];
        arr_qun = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    [tableV reloadData];
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_qun.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBchengyuanTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBchengyuanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    qunListModel *model = arr_qun[indexPath.row];
    
    [cell.IV_headimg setImageWithURL:[NSURL URLWithString:model.groupphoto] placeholderImage:[UIImage imageNamed:@"qun"]];
    [cell.L_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.mas_centerY);
    }];
    cell.L_name.text = model.groupname;
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    qunListModel *model = arr_qun[indexPath.row];
    ChengYuanViewController *CYvc =[[ChengYuanViewController alloc]init];
    CYvc.targeId =model.groupid;
    CYvc.MessageContent =self.MessageContent;
    [self.navigationController pushViewController:CYvc animated:NO];
    
}



@end
