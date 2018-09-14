//
//  FB_friendSearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_friendSearchViewController.h"
#import "FBOneImg_yyLabelTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface FB_friendSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UISearchBar * searchBar ;
    UserModel *user;
    NSArray *arr_temp;
}

@end

@implementation FB_friendSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)loadrequestData{
    [WebRequest User_GetFriendListuid:user.Guid And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSNumber *number =dic[@"status"];
        NSArray *arr =dic[@"items"];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    HaoYouModel *model = [HaoYouModel mj_objectWithKeyValues:dic1];
                    [arr_model addObject:model];
                }
            }
            arr_temp = arr_model;
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
    }];
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"易企点用户/好友";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
 
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate=self;
    searchBar.placeholder=@"手机号";
    [self loadrequestData];
}

-(void)searchWithText:(NSString*)text
{
    [WebRequest User_Friend_SeachWithuserGuid:user.Guid account:text And:^(NSDictionary *dic) {
        NSNumber *number = dic[Y_STATUS];
        [arr_model removeAllObjects];
        if ([number integerValue]==200) {
            //好友的基本信息
            HaoYouModel  *model = [HaoYouModel mj_objectWithKeyValues:dic[Y_ITEMS][0]];
            [arr_model addObject:model];
        }
        [tableV reloadData];
    }];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchWithText:searchBar.text];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_model =[NSMutableArray arrayWithArray:arr_temp];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"uname CONTAINS[cd] %@",searchText];
        arr_model = [NSMutableArray arrayWithArray:[arr_temp filteredArrayUsingPredicate:predicate]];
       
        if (arr_model.count ==0 && searchText.length==11) {
            [self searchWithText:searchText];
        }
        
    }
    [tableV reloadData];
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOneImg_yyLabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOneImg_yyLabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    HaoYouModel *model = arr_model[indexPath.row];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.upname] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSMutableAttributedString *phone = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.uname] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:phone];
    
    [cell setImg:model.iphoto Context:name isChoose:NO isShow:NO];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HaoYouModel *model = arr_model[indexPath.row];
    if ([self.delegate_friend respondsToSelector:@selector(gethaoyouModel:)]) {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate_friend gethaoyouModel:model];
    }
}




@end
