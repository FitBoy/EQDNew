//
//  FBOneViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBOneViewController.h"
#import "FBConversationViewControllerViewController.h"
#import "FBQunChatViewController.h"
#import "WebRequest.h"
#import "qunListModel.h"
#import <UIImageView+AFNetworking.h>
#import "FBindexpathLongPressGestureRecognizer.h"
#import "ASearchViewController.h"
#import <Photos/Photos.h>
#import "FBMessage_SearchViewController.h"
#import "RWFaSongViewController.h"
@interface FBOneViewController ()<RCIMReceiveMessageDelegate>
{
    NSMutableArray *tarr;
    UserModel *user;
}

@end

@implementation FBOneViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest User_GetGroupsWithuserGuid:user.Guid  And:^(NSDictionary *dic) {
        [tarr removeAllObjects];
        NSNumber *number =dic[@"status"];
        NSArray *arr =dic[@"items"];
        if ([number integerValue]==200 ) {
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    qunListModel *model = [qunListModel mj_objectWithKeyValues:dic1];
                    [tarr addObject:model];
                    
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.conversationListTableView reloadData];
            });
        }
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationController.navigationBarHidden=NO;
    tarr = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"消息";
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
    [RCIM sharedRCIM].receiveMessageDelegate=self;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(kuaijiefangshi)];

   UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItems:@[right,right1]];

}

-(void)searchClick
{
   //搜索
    FBMessage_SearchViewController  *MSvc =[[FBMessage_SearchViewController alloc]init];
    MSvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:MSvc animated:NO];
    
    
}

-(void)kuaijiefangshi
{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"添加好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ASearchViewController *Svc =[[ASearchViewController alloc]init];
        Svc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Svc animated:NO];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"扫一扫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 1、 获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if (device) {
            // 判断授权状态
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
            } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.detailsLabel.text =@"请到设置->易企点->修改访问权限";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view.window animated:YES];
                });
            } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
                FBScanViewController *Svc =[[FBScanViewController alloc]init];
                Svc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:Svc animated:NO];
            } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
                // 弹框请求用户授权
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                        FBScanViewController *Svc =[[FBScanViewController alloc]init];
                        Svc.hidesBottomBarWhenPushed=YES;
                        [self.navigationController pushViewController:Svc animated:NO];
                        
                    }
                }];
            }
            
        } else {
            
            //模拟器
        }
        
        
        
        
        
        
        
    }]];
    
    //    [alert addAction:[UIAlertAction actionWithTitle:@"易企点FAQ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //            TFAQViewController *FAQvc =[[TFAQViewController alloc]init];
    //            FAQvc.hidesBottomBarWhenPushed=YES;
    //            [self.navigationController pushViewController:FAQvc animated:NO];
    //
    //
    //
    //
    //    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left
{
   int unread_num= [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
    
    if (unread_num==0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tabBarItem.badgeValue=nil;
        });
        
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
           self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unread_num];
        });
   
    }
}

-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *messagenum = self.tabBarItem.badgeValue;
    
    NSInteger  unread = [messagenum integerValue]-model.unreadMessageCount;
    if (unread >1) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)unread];
    }
    else
    {
        self.tabBarItem.badgeValue=nil;

    }
    
    if (model.conversationType == ConversationType_PRIVATE) {
        FBConversationViewControllerViewController *conversationVC = [[FBConversationViewControllerViewController alloc]init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;
        conversationVC.navigationItem.title = model.conversationTitle;
        conversationVC.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:conversationVC animated:NO];
    }
    if (model.conversationType == ConversationType_GROUP) {

        FBQunChatViewController *QunVc =[[FBQunChatViewController alloc]init];
        QunVc.conversationType = model.conversationType;
        QunVc.targetId =model.targetId;
        QunVc.navigationItem.title = model.conversationTitle;
        QunVc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:QunVc animated:NO];
        
    }
    
    
    
   
}
-(void)didReceiveMessageNotification:(NSNotification *)notification
{
    [super didReceiveMessageNotification:notification];
  
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell
                             atIndexPath:(NSIndexPath *)indexPath{
    [super willDisplayConversationTableCell:cell atIndexPath:indexPath];
    RCConversationCell *cell1 =(RCConversationCell*)cell;
    RCConversationModel  *model1 = cell1.model;
    if (model1.conversationType == ConversationType_PRIVATE) {
        
    }
    else
    {
        RCGroup  *Group0 = [[RCIM sharedRCIM] getGroupInfoCache:model1.targetId];
        if (Group0.groupName.length==0) {
            if (tarr.count) {
                NSPredicate *predicate =[NSPredicate predicateWithFormat:@"groupid CONTAINS[cd] %@",cell.model.targetId];
                NSArray *arr = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
                if (arr.count) {
                    qunListModel *model = arr[0];
                    cell1.conversationTitle.text = model.groupname;
                    model1.conversationTitle =model.groupname;
                    UIImageView *imageView=(UIImageView *)cell1.headerImageView;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [imageView setImageWithURL:[NSURL URLWithString:model.groupphoto] placeholderImage:[UIImage imageNamed:@"qun"]];
                    });
                    RCGroup  *group = [[RCGroup alloc]initWithGroupId:model.groupid groupName:model.groupname portraitUri:model.groupphoto];
                    
                    [[RCIM sharedRCIM] refreshGroupInfoCache:group withGroupId:model.groupid];
                    
                    
                }
            }
            
        }else
        {
            
        }
        
        
    }
  //增加长按操作
    FBindexpathLongPressGestureRecognizer *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath = indexPath;
    [cell1 addGestureRecognizer:longPress];
    
    
}
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)press
{
    RCConversationModel *model = self.conversationListDataSource[press.indexPath.row];
    
    UIAlertController *alert = [[UIAlertController alloc]init];
    if(model.conversationType ==ConversationType_PRIVATE)
    {
    [alert addAction:[UIAlertAction actionWithTitle:@"发任务" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RWFaSongViewController *FSvc =[[RWFaSongViewController alloc]init];
        FSvc.isChat =1;
        FSvc.userGuid =model.targetId;
        FSvc.name =model.conversationTitle;
        [self.navigationController pushViewController:FSvc animated:NO];
    }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"置顶该会话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RCConversationModel *model2 = self.conversationListDataSource[0];
        model2.isTop=NO;
        [self.conversationListDataSource removeObject:model];
        [self.conversationListDataSource insertObject:model atIndex:0];
        model.isTop=YES;
        
        [self.conversationListTableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除该会话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.conversationListDataSource removeObject:model];
        [[RCIMClient sharedRCIMClient] removeConversation:model.conversationType targetId:model.targetId];
        [self.conversationListTableView reloadData];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"清空该聊天记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[RCIMClient sharedRCIMClient] clearMessages:model.conversationType targetId:model.targetId];
        [self.conversationListTableView reloadRowsAtIndexPaths:@[press.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }]];
    
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
    
}

#pragma mark ---点击头像后的操作
-(void)didTapCellPortrait:(RCConversationModel *)model
{
    //点击头像
    [super didTapCellPortrait:model];
    
}
-(void)didLongPressCellPortrait:(RCConversationModel *)model
{
    //长按头像
    [super didLongPressCellPortrait:model];
    
}

@end
