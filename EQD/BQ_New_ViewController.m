//
//  BQ_New_ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BQ_New_ViewController.h"
#import "BMChineseSort.h"
#import "HaoYouModel.h"
#import "FBOne_imgChooseTableViewCell.h"
#import "UISearchBar+ToolDone.h"
#import "UITextField+Tool.h"
@interface BQ_New_ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *tableV;
    
    NSMutableArray *arr_index;
    NSMutableArray *arr_name;
    
    UserModel *user;
    NSMutableArray *arr_haoyou;
    
    UISearchBar * searchBar ;
    UITextField *TF_text;
}

@end

@implementation BQ_New_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
   [WebRequest User_GetFriendListuid:user.Guid And:^(NSDictionary *dic) {
       [arr_haoyou removeAllObjects];
       NSNumber *number =dic[@"status"];
       NSArray *arr =dic[@"items"];
       if ([number integerValue]==200 ) {
           if(arr.count)
           {
               for (NSDictionary *dic1 in arr) {
                   HaoYouModel *model = [HaoYouModel mj_objectWithKeyValues:dic1];
                   [arr_haoyou addObject:model];
               }
               
               
               arr_index = [BMChineseSort IndexWithArray:arr_haoyou Key:@"upname"];
               arr_name = [BMChineseSort sortObjectArray:arr_haoyou Key:@"upname"];
               
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
   
    TF_text =[[UITextField alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 40)];
    [self.view addSubview:TF_text];
    TF_text.placeholder=@"请输入标签名称";
    [TF_text setTextFieldInputAccessoryView];
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, 40)];
    [searchBar setTextFieldInputAccessoryView];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"快速查找好友";
    self.navigationItem.title =@"创建标签";
    arr_haoyou =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 144-64+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-144+64-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.contentInset=UIEdgeInsetsMake(15, 0, 0, 0);
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"创建" style:UIBarButtonItemStylePlain target:self action:@selector(chuangjianCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)chuangjianCLick
{
    //创建标签
    NSMutableString  *tstr =[NSMutableString string];
    for (int i=0; i<arr_haoyou.count; i++) {
        HaoYouModel *model =arr_haoyou[i];
        if (model.ischoose==YES) {
            [tstr appendFormat:@"%@;",model.Guid];
        }
    }
    if(TF_text.text.length==0 || tstr.length==0)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"请输入标签名字或选人";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在创建";
        [WebRequest create_labelWithowner:user.Guid labelName:TF_text.text labelfriends:tstr And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }
}
#pragma  mark - 搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_index = [BMChineseSort IndexWithArray:arr_haoyou Key:@"upname"];
        arr_name =[BMChineseSort sortObjectArray:arr_haoyou Key:@"upname"];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"upname CONTAINS[cd] %@",searchText];
        NSMutableArray *tarr = [NSMutableArray arrayWithArray:[arr_haoyou filteredArrayUsingPredicate:predicate]];
        
        arr_index = [BMChineseSort IndexWithArray:tarr Key:@"upname"];
        arr_name =[BMChineseSort sortObjectArray:tarr Key:@"upname"];
    }
    [tableV reloadData];
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma  mark - 表的数据源
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return arr_index;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_index[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_index.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tarr =arr_name[section];
    return tarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOne_imgChooseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOne_imgChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    NSArray *tarr =arr_name[indexPath.section];
    HaoYouModel *model =tarr[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tarr =arr_name[indexPath.section];
    HaoYouModel *model =tarr[indexPath.row];
    model.ischoose =!model.ischoose;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}




@end
