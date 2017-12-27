//
//  TXLQunLiaoViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TXLQunLiaoViewController.h"
#import "WebRequest.h"
#import "FBCreatQunZuViewController.h"
#import "FBCreateQunZuTableViewCell.h"
#import "qunListModel.h"
#import "FBQunChatViewController.h"
#import "QLSearchViewController.h"
#import <UIImageView+AFNetworking.h>
#import <Masonry.h>
#import "FBBaseModel.h"
#import "FBOne_img1TableViewCell.h"
@interface TXLQunLiaoViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_name;
    NSMutableArray *arr_qun;
    NSMutableArray *tarr;
    UserModel *user;
}

@end

@implementation TXLQunLiaoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest User_GetGroupsWithuserGuid:user.Guid  And:^(NSDictionary *dic) {
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
                [tableV.mj_header endRefreshing];
                [tableV reloadData];
            });
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
     self.view.backgroundColor =[UIColor whiteColor];
    adjustsScrollViewInsets_NO(tableV, self);
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"快速查找本地群";
    self.navigationItem.title =@"群管理";
    
    FBBaseModel *model1 = [[FBBaseModel alloc]init];
    model1.img_header =@"chuanjian.png";
    model1.left0 =@"创建群";
    
    /*FBBaseModel *model2 = [[FBBaseModel alloc]init];
    model2.img_header = @"sousuoqun.png";
    model2.left0 =@"搜索群";*/
    
    arr_name=[NSMutableArray arrayWithObjects:model1, nil];
    arr_qun=[NSMutableArray arrayWithCapacity:0];
    tarr = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    
    
    
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return  arr_name.count;
    }
    else
    {
        return arr_qun.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOne_img1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOne_img1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
    if (indexPath.section==0) {
        FBBaseModel *model = arr_name[indexPath.row];
        [cell setModel:model];
    }
    if (indexPath.section==1) {
        qunListModel *model = arr_qun[indexPath.row];
        RCGroup  *Group0 = [[RCIM sharedRCIM] getGroupInfoCache:model.groupid];
        if (Group0.groupName.length==0) {
            RCGroup  *group = [[RCGroup alloc]initWithGroupId:model.groupid groupName:model.groupname portraitUri:model.groupphoto];
            [[RCIM sharedRCIM] refreshGroupInfoCache:group withGroupId:model.groupid];
        }
        
        
        [cell setModel:model];
    }
    
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return nil;
    }
    else
    {
        return @"我所在的群";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else
    {
        return 20;
    }
}
#pragma  mark - 表的协议代理
//shequ_tluntan  空的 shequ_landui 实心
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            NSLog(@"创建群");
            FBCreatQunZuViewController *CQvc =[[FBCreatQunZuViewController alloc]init];
            [self.navigationController pushViewController:CQvc animated:NO];
        }
        if (indexPath.row==1) {
            //搜索群聊
            QLSearchViewController *Svc =[[QLSearchViewController alloc]init];
            [self.navigationController pushViewController:Svc animated:NO];
        }
    }
    
    else
    {
        //群组
        qunListModel *model = arr_qun[indexPath.row];
        FBQunChatViewController *QunVc =[[FBQunChatViewController alloc]init];
        QunVc.conversationType =ConversationType_GROUP;
        QunVc.targetId =model.groupid;
        QunVc.title = model.groupname;
        QunVc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:QunVc animated:NO];
        
    }
    
    
}




@end
