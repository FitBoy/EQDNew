//
//  Person_zhihui_xiezhuViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Person_zhihui_xiezhuViewController.h"
#import "RWD_FuJiamodel.h"
#import "FBConversationViewControllerViewController.h"
#import "FBTwo_img11TableViewCell.h"
#import <MJExtension.h>
@interface Person_zhihui_xiezhuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
}

@end

@implementation Person_zhihui_xiezhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =self.contentTitle;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_list.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    RWD_FuJiamodel *model =self.arr_list[indexPath.row];
    [cell setModel:model];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWD_FuJiamodel *model =self.arr_list[indexPath.row];
    FBConversationViewControllerViewController  *Cvc =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.guid];
    Cvc.navigationItem.title = model.name;
    RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:model.guid name:model.name portrait:model.headImage];
    [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:model.guid];
    RCUserInfo *userinfo2 = [[RCUserInfo alloc]initWithUserId:user.Guid name:user.username portrait:user.iphoto];
    [[RCIM sharedRCIM] refreshUserInfoCache:userinfo2 withUserId:user.Guid];
    [self.navigationController pushViewController:Cvc animated:NO];
}



@end
