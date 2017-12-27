//
//  GZQ_ZanViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GZQ_ZanViewController.h"
#import "ZanModel.h"
#import "FBTwo_img11TableViewCell.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "FBConversationViewControllerViewController.h"
#import "SDetailViewController.h"
#import "PPersonCardViewController.h"
@interface GZQ_ZanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_zan;
    NSString *selected_ID;
}

@end

@implementation GZQ_ZanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    
    [WebRequest Get_WorkCircle_ZanWithworkCircleId:self.cell_id ID:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_zan removeAllObjects];
            NSArray *tarr =dic[Y_ITEMS];
            if (tarr.count) {
                for (int i=0; i<tarr.count; i++) {
                    ZanModel *model =[ZanModel mj_objectWithKeyValues:tarr[i]];
                    [arr_zan addObject:model];
                    if (i==tarr.count) {
                        selected_ID =model.ID;
                    }
                }
            }
        
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            [tableV reloadData];
        });
    }];
    
}
-(void)loadOtherData
{
    
    [WebRequest Get_WorkCircle_ZanWithworkCircleId:self.cell_id ID:selected_ID And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            if (tarr.count==0){
                
            } else{
                for (int i=0; i<tarr.count; i++) {
                    ZanModel *model =[ZanModel mj_objectWithKeyValues:tarr[i]];
                    [arr_zan addObject:model];
                    if (i==tarr.count-1) {
                        selected_ID =model.ID;
                    }
                }
                   [tableV reloadData];
            }
        }
        
       
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"点赞人列表";
    selected_ID=@"0";
    arr_zan =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_zan.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZanModel *model =arr_zan[indexPath.row];
    static NSString *cellId=@"cellID";
    FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    [cell setModel:model];
    
    FBindexpathLongPressGestureRecognizer *longPress =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath =indexPath;
    [cell addGestureRecognizer:longPress];
    
    return cell;
}
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)longpress
{
    ZanModel *model =arr_zan[longpress.indexPath.row];
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBConversationViewControllerViewController  *oneTooneChat =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.guid];
        oneTooneChat.navigationItem.title =model.name;
        RCUserInfo *userinfo = [[RCUserInfo alloc]initWithUserId:model.guid  name:model.name portrait:model.headImage];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.guid];
        RCUserInfo *userinfo2 = [[RCUserInfo alloc]initWithUserId:user.Guid name:user.username portrait:user.iphoto];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo2 withUserId:user.Guid];
        
        [self.navigationController pushViewController:oneTooneChat animated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.phone];
        UIWebView *callWebView = [[UIWebView alloc] init];
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebView];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"加好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SDetailViewController *Dvc =[[SDetailViewController alloc]init];
        Dvc.friendID =model.phone;
        [self.navigationController pushViewController:Dvc animated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZanModel *model =arr_zan[indexPath.row];
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =model.guid;
    [self.navigationController pushViewController:Pvc animated:NO];
}





@end
