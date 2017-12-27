//
//  BQ_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BQ_DetailViewController.h"
#import "FBOne_img1TableViewCell.h"
#import "BQ_AddViewController.h"
#import "PPersonCardViewController.h"
@interface BQ_DetailViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,BQ_AddViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_chengyuan;
    UISearchBar * searchBar;
    UserModel *user;
}

@end

@implementation BQ_DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Get_labelWithowner:user.Guid labelid:self.model.ID And:^(NSDictionary *dic) {
        [arr_chengyuan removeAllObjects];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            NSArray *tarr =dic2[@"friends"];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    HaoYouModel *model =[HaoYouModel mj_objectWithKeyValues:tarr[i]];
                    [arr_chengyuan addObject:model];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_chengyuan =[NSMutableArray arrayWithCapacity:0];
  searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    self.navigationItem.title =self.model.name;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"编辑成员" style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    [self.navigationItem setRightBarButtonItem:right];

}
#pragma  mark -添加成员
-(void)tianjiaCLick
{
    //添加成员
    BQ_AddViewController *Avc =[[BQ_AddViewController alloc]init];
    Avc.delegate =self;
     Avc.arr_old =arr_chengyuan;
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark -delegate
 -(void)haoyouArr:(NSArray *)arr
{
    NSMutableString *tstr =[NSMutableString string];
    for (int i=0; i<arr.count; i++) {
        HaoYouModel *model =arr[i];
        [tstr appendFormat:@"%@;",model.Guid];
    }
    //添加成员
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在添加";
    [WebRequest Prune_labelmembersWithowner:user.Guid labelid:self.model.ID labelfriends:tstr And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            hud.label.text =@"添加成功";
        }
        else
        {
             hud.label.text =@"服务器错误";
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self loadRequestData];
        });
    }];
     
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_chengyuan.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOne_img1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOne_img1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    HaoYouModel *model =arr_chengyuan[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        HaoYouModel *model =arr_chengyuan[indexPath.row];
        [arr_chengyuan removeObject:model];
        NSMutableString *tstr =[NSMutableString string];
        for (int i=0; i<arr_chengyuan.count; i++) {
            HaoYouModel *model2 =arr_chengyuan[i];
            [tstr appendFormat:@"%@;",model.Guid];
        }
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        [WebRequest Prune_labelmembersWithowner:user.Guid labelid:self.model.ID labelfriends:tstr And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [tableV reloadData];
            });
            
        }];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HaoYouModel *model =arr_chengyuan[indexPath.row];
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =model.Guid;
    [self.navigationController pushViewController:Pvc animated:NO];
}


@end
