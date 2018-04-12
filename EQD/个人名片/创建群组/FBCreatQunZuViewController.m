//
//  FBCreatQunZuViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBCreatQunZuViewController.h"
#import "FBHaoYouModel.h"
#import "WebRequest.h"
#import "FBCreateQunZuTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
#import "WebRequest.h"
#import "FBHaoYouModel.h"
#import <UIImageView+WebCache.h>
#import "UITextField+Tool.h"
@interface FBCreatQunZuViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,RCIMGroupInfoDataSource>
{
    UITextField *TF_mingCheng;
    UITableView *tableV;
    NSMutableArray *arr_haoyou;
   
    NSMutableArray *tarr;
    NSMutableArray *arr_add;
    UserModel *user;
}

@end

@implementation FBCreatQunZuViewController
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
                    FBHaoYouModel *model = [FBHaoYouModel mj_objectWithKeyValues:dic1];
                    [arr_haoyou addObject:model];
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
    user = [WebRequest GetUserInfo];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title =@"创建群组";
    arr_add =[NSMutableArray arrayWithCapacity:0];
    
    tarr = [NSMutableArray arrayWithCapacity:0];
    adjustsScrollViewInsets_NO(tableV, self);
    arr_haoyou = [NSMutableArray arrayWithCapacity:0];
    TF_mingCheng =[[UITextField alloc]initWithFrame:CGRectMake(10, DEVICE_TABBAR_Height, DEVICE_WIDTH-20, 50)];
    [self.view addSubview:TF_mingCheng];
    TF_mingCheng.placeholder= @"请输入群组名称";
    [TF_mingCheng setTextFieldInputAccessoryView];
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"创建群组" style:UIBarButtonItemStylePlain target:self action:@selector(wanchengnClick)];
    
    [self.navigationItem setRightBarButtonItem:right];
    
    UISearchBar *searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 114-64+DEVICE_TABBAR_Height, DEVICE_WIDTH, 50)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索好友";
    
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 170-64+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height+64-170) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    
}
-(void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion
{
    RCGroup *group = [[RCGroup alloc]initWithGroupId:groupId groupName:TF_mingCheng.text portraitUri:nil];
    completion(group);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_haoyou =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"upname CONTAINS[cd] %@",searchText];
        arr_haoyou = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    [tableV reloadData];
    
    
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_haoyou.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBCreateQunZuTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBCreateQunZuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    FBHaoYouModel *model =arr_haoyou[indexPath.row];
    [cell.IV_headimg sd_setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    
   
    cell.L_name.text = [NSString stringWithFormat:@"%@(%@)",model.upname,model.uname];
    if (cell.isChoose==NO) {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_tluntan.png"];
        model.ischoose=NO;
    }
    else
    {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_landui.png"];
        model.ischoose=YES;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBCreateQunZuTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.isChoose = !cell.isChoose;
    [tableView reloadData];
    
}


-(void)wanchengnClick{
    NSLog(@"创建群组");
    [arr_add removeAllObjects];
    for(int i = 0;i<arr_haoyou.count;i++)
    {
        FBHaoYouModel *model = arr_haoyou[i];
        if (model.ischoose==YES) {
            
            [arr_add addObject:model.Guid];
        }
        }
    
    if (TF_mingCheng.text.length==0) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"群名称不能为空";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    else
    {
        NSMutableString  *str =[NSMutableString stringWithFormat:@";%@",user.Guid];
        for (int i=0; i<arr_add.count; i++) {
            [str appendFormat:@";%@",arr_add[i]];
        }
        NSDate *date = [NSDate date];
        NSTimeInterval  groupid = date.timeIntervalSince1970;
        NSString *groupid1 =[NSString stringWithFormat:@"%d%@",(int)groupid,user.uname];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在创群";
        [WebRequest User_Group_CreateWithuserid:user.Guid groupid:groupid1 groupname:TF_mingCheng.text GroupMembers:str And:^(NSDictionary *dic) {
            NSNumber *number = dic[Y_STATUS];
            NSString *msg = dic[Y_MSG];
            hud.label.text =msg;
            if ([number integerValue]==200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
            }
        }];
        
   
        
    }
}




@end
