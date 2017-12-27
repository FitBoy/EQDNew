//
//  FBMessage_SearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBMessage_SearchViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "FBTwo_img11TableViewCell.h"
#import <UIImageView+WebCache.h>
#import "FBQunChatViewController.h"
#import "FBConversationViewControllerViewController.h"
@interface FBMessage_SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSArray *arr_model;
}

@end

@implementation FBMessage_SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title=self.userGuid==nil?@"搜索聊天会话":@"搜索聊天内容";
    
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   

}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(self.userGuid)
    {
        arr_model =[[RCIMClient sharedRCIMClient] searchMessages:ConversationType_PRIVATE targetId:self.userGuid keyword:searchBar.text count:50 startTime:0];
    }else
    {
  arr_model =[[RCIMClient sharedRCIMClient] searchConversations:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)] messageType:@[@"RC:TxtMsg"] keyword:searchBar.text];
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
    FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (self.userGuid) {
        RCMessage   *meesage = arr_model[indexPath.row];
        NSLog(@" cless==%@",[meesage class]);
        //这个逻辑先放一放，理由有些问题
        
    }else
    {
    RCSearchConversationResult  *result = arr_model[indexPath.row];
    RCConversation *conversation = result.conversation;
    RCTextMessage  *message =(RCTextMessage*)conversation.lastestMessage;
    RCUserInfo  *userInfo = conversation.lastestMessage.senderUserInfo;
    if (conversation.conversationType == ConversationType_GROUP) {
      RCGroup *group= [[RCIM sharedRCIM] getGroupInfoCache:conversation.targetId];
        [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:group.portraitUri] placeholderImage:[UIImage imageNamed:@"qun"]];
        cell.L_left0.text = group.groupName;
        cell.L_left1.text = [NSString stringWithFormat:@"包含:%@(%@)",userInfo.name,message.content];
        
    }else if (conversation.conversationType ==ConversationType_PRIVATE)
    {
        RCUserInfo *user_info =[[RCIM sharedRCIM] getUserInfoCache:conversation.targetId];
        [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:user_info.portraitUri] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        cell.L_left0.text = user_info.name;
        cell.L_left1.text = message.content;
    }else
    {
    }
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCSearchConversationResult  *result = arr_model[indexPath.row];
    RCConversation *conversation = result.conversation;
     if (conversation.conversationType == ConversationType_GROUP) {
         RCGroup *group= [[RCIM sharedRCIM] getGroupInfoCache:conversation.targetId];
         FBQunChatViewController *qun = [[FBQunChatViewController alloc]initWithConversationType:ConversationType_GROUP targetId:conversation.targetId];
         qun.navigationItem.title =group.groupName;
         [self.navigationController  pushViewController:qun animated:NO];
     }else if (conversation.conversationType ==ConversationType_PRIVATE)
     {
          RCUserInfo *user_info =[[RCIM sharedRCIM] getUserInfoCache:conversation.targetId];
    FBConversationViewControllerViewController  *Cvc =[[FBConversationViewControllerViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:conversation.targetId];
         Cvc.navigationItem.title =user_info.name;
         [self.navigationController pushViewController:Cvc animated:NO];
        
     }else
     {
     }
}




@end
