//
//  FBConversationViewControllerViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBConversationViewControllerViewController.h"
#import "FBActivityViewController.h"
#import "ExActivity.h"
#import "FBGeRenCardMessageContent.h"
#import "FBMessageCell.h"
#import "CardChooseViewController.h"
#import "RealTimeLocationEndCell.h"
#import "RealTimeLocationStartCell.h"
#import "RealTimeLocationStatusView.h"
#import "RealTimeLocationViewController.h"

#import "PPersonCardViewController.h"
#import "RWFaSongViewController.h"
#import "FBMessage_SearchViewController.h"
#import "Memo_AddViewController.h"
#import "RWFaSongViewController.h"
#import "FBShareUrlMessageCollectionViewCell.h"
#import "EQDR_Article_DetailViewController.h"
#import "FB_ShareEQDViewController.h"
#import "FBWebUrlViewController.h"
#import "FBImgShowViewController.h"

///文件
#import "iCloudManager.h"
#import "FileManagerTool.h"
@interface FBConversationViewControllerViewController ()<UIActionSheetDelegate, RCRealTimeLocationObserver,
RealTimeLocationStatusViewDelegate, UIAlertViewDelegate,
RCMessageCellDelegate,UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate>
{
    RCMessageModel  *M_model;
    FBGeRenCardMessageContent *content ;
    UserModel *user;
    RCUserInfo *userinfo1;
    RCUserInfo *userinfo2;
    FileManagerTool  *fileTool;
}
@property(nonatomic, weak) id<RCRealTimeLocationProxy> realTimeLocation;
@property(nonatomic, strong)
RealTimeLocationStatusView *realTimeLocationStatusView;

@end

@implementation FBConversationViewControllerViewController
-(void)updateUserFriendData
{
    [WebRequest Com_User_BusinessCardWithuserGuid:self.targetId And:^(NSDictionary *dic) {
        Com_UserModel *user_model =[Com_UserModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        RCUserInfo *userinfo1 =[[RCUserInfo alloc]initWithUserId:user.Guid name:user.upname portrait:user.iphoto];
        RCUserInfo *userinfo2 =[[RCUserInfo alloc]initWithUserId:user_model.userGuid name:user_model.upname portrait:user_model.photo];
        
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo1 withUserId:user.Guid];
        [[RCIM sharedRCIM] refreshUserInfoCache:userinfo2 withUserId:user_model.userGuid];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
      fileTool = [[FileManagerTool alloc]init];
    [fileTool context];
    self.conversationMessageCollectionView.frame = CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight);
    adjustsScrollViewInsets_NO(self.conversationMessageCollectionView, self);
    [[RCIM sharedRCIM] registerMessageType:[FBShareMessageContent class]];
    [self.conversationMessageCollectionView registerClass:[FBShareUrlMessageCollectionViewCell class] forCellWithReuseIdentifier:@"FBShareMessageBaseCell"];
    [self registerClass:[FBShareUrlMessageCollectionViewCell class] forMessageClass:[FBShareMessageContent class]];
    
    [[RCIM sharedRCIM] registerMessageType:[FBGeRenCardMessageContent class]];
    [self.conversationMessageCollectionView registerClass:[FBMessageCell class] forCellWithReuseIdentifier:@"FBMessageBaseCell"];
    [self registerClass:[FBMessageCell class] forMessageClass:[FBGeRenCardMessageContent class]];
    user =[WebRequest GetUserInfo];
    self.view.backgroundColor =[UIColor whiteColor];
//     self.displayConversationTypeArray = @[@(ConversationType_PRIVATE),@(ConversationType_GROUP)];
    self.conversationType = ConversationType_PRIVATE;
    self.enableUnreadMessageIcon =YES;
    self.displayUserNameInCell=YES;
    self.enableNewComingMessageIcon=YES;
    [RCIM sharedRCIM].enableTypingStatus =YES;
    [RCIM sharedRCIM].enableSyncReadStatus=YES;
    
    /// 移除音视频

    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:1101];
      [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:1102];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"eqd_myTask.png"] title:@"发任务" atIndex:5 tag:4001];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[RCKitUtility imageNamed:@"card.png" ofBundle:@"RongCloud.bundle"] title:@"个人名片" atIndex:6 tag:4002];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[RCKitUtility imageNamed:@"actionbar_file_icon.png" ofBundle:@"RongCloud.bundle"] title:@"文件" atIndex:6 tag:4003];
    
    [self notifyUpdateUnreadMessageCount];
    
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"me_focu"] style:UIBarButtonItemStylePlain target:self action:@selector(personInfo)];
   /* UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];*/
    [self.navigationItem setRightBarButtonItems:@[right]];
    
    
    /*******************实时地理位置共享***************/
    [self registerClass:[RealTimeLocationStartCell class]
        forMessageClass:[RCRealTimeLocationStartMessage class]];
    [self registerClass:[RealTimeLocationEndCell class]
        forMessageClass:[RCRealTimeLocationEndMessage class]];
    
    __weak typeof(&*self) weakSelf = self;
    [[RCRealTimeLocationManager sharedManager]
     getRealTimeLocationProxy:self.conversationType
     targetId:self.targetId
     success:^(id<RCRealTimeLocationProxy> realTimeLocation) {
         weakSelf.realTimeLocation = realTimeLocation;
         [weakSelf.realTimeLocation addRealTimeLocationObserver:self];
         [weakSelf updateRealTimeLocationStatus];
     }
     error:^(RCRealTimeLocationErrorCode status) {
         NSLog(@"get location share failure with code %d", (int)status);
     }];
    
    
    /******************实时地理位置共享**************/
    
  
}

-(void)searchClick
{
    FBMessage_SearchViewController  *Svc =[[FBMessage_SearchViewController alloc]init];
    Svc.userGuid = self.targetId;
    [self.navigationController pushViewController:Svc animated:NO];
}
-(void)personInfo
{
    PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =self.targetId;
    [self.navigationController pushViewController:Pvc animated:NO];
}

#pragma mark override
- (void)resendMessage:(RCMessageContent *)messageContent {
    if ([messageContent isKindOfClass:[RCRealTimeLocationStartMessage class]]) {
        [self showRealTimeLocationViewController];
    } else {
        [super resendMessage:messageContent];
    }
}

#pragma mark - RCRealTimeLocationObserver
- (void)onRealTimeLocationStatusChange:(RCRealTimeLocationStatus)status {
    __weak typeof(&*self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf updateRealTimeLocationStatus];
    });
}

- (void)onReceiveLocation:(CLLocation *)location fromUserId:(NSString *)userId {
    __weak typeof(&*self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf updateRealTimeLocationStatus];
    });
}

- (void)onParticipantsJoin:(NSString *)userId {
    __weak typeof(&*self) weakSelf = self;
    if ([userId isEqualToString:[RCIMClient sharedRCIMClient]
         .currentUserInfo.userId]) {
        [self notifyParticipantChange:@"你加入了地理位置共享"];
    } else {
        [[RCIM sharedRCIM]
         .userInfoDataSource
         getUserInfoWithUserId:userId
         completion:^(RCUserInfo *userInfo) {
             if (userInfo.name.length) {
                 [weakSelf
                  notifyParticipantChange:
                  [NSString stringWithFormat:@"%@加入地理位置共享",
                   userInfo.name]];
             } else {
                 [weakSelf
                  notifyParticipantChange:
                  [NSString
                   stringWithFormat:@"user<%@>加入地理位置共享",
                   userId]];
             }
         }];
    }
}

- (void)onParticipantsQuit:(NSString *)userId {
    __weak typeof(&*self) weakSelf = self;
    if ([userId isEqualToString:[RCIMClient sharedRCIMClient]
         .currentUserInfo.userId]) {
        [self notifyParticipantChange:@"你退出地理位置共享"];
    } else {
        [[RCIM sharedRCIM]
         .userInfoDataSource
         getUserInfoWithUserId:userId
         completion:^(RCUserInfo *userInfo) {
             if (userInfo.name.length) {
                 [weakSelf
                  notifyParticipantChange:
                  [NSString stringWithFormat:@"%@退出地理位置共享",
                   userInfo.name]];
             } else {
                 [weakSelf
                  notifyParticipantChange:
                  [NSString
                   stringWithFormat:@"user<%@>退出地理位置共享",
                   userId]];
             }
         }];
    }
}

- (void)onRealTimeLocationStartFailed:(long)messageId {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < self.conversationDataRepository.count; i++) {
            RCMessageModel *model = [self.conversationDataRepository objectAtIndex:i];
            if (model.messageId == messageId) {
                model.sentStatus = SentStatus_FAILED;
            }
        }
        NSArray *visibleItem =
        [self.conversationMessageCollectionView indexPathsForVisibleItems];
        for (int i = 0; i < visibleItem.count; i++) {
            NSIndexPath *indexPath = visibleItem[i];
            RCMessageModel *model =
            [self.conversationDataRepository objectAtIndex:indexPath.row];
            if (model.messageId == messageId) {
                [self.conversationMessageCollectionView
                 reloadItemsAtIndexPaths:@[ indexPath ]];
            }
        }
    });
}

- (void)notifyParticipantChange:(NSString *)text {
    __weak typeof(&*self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.realTimeLocationStatusView updateText:text];
        [weakSelf performSelector:@selector(updateRealTimeLocationStatus)
                       withObject:nil
                       afterDelay:0.5];
    });
}

- (void)onFailUpdateLocation:(NSString *)description {
}


- (RCMessage *)willAppendAndDisplayMessage:(RCMessage *)message {
    return message;
}

#pragma mark override cell的点击事件
- (void)didTapMessageCell:(RCMessageModel *)model {
    [super didTapMessageCell:model];
    if ([model.content isKindOfClass:[RCRealTimeLocationStartMessage class]]) {
        [self showRealTimeLocationViewController];
    }else if([model.content isKindOfClass:[FBGeRenCardMessageContent class]])
    {
        FBGeRenCardMessageContent *contet =(FBGeRenCardMessageContent*)model.content;
        PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
        Pvc.userGuid =contet.content[@"uid"];
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if ([model.content isKindOfClass:[FBShareMessageContent class]])
    {
        FBShareMessageContent  *content = (FBShareMessageContent*)model.content;
        NSDictionary *dic = content.content;
       
        if([dic[@"source"] isEqualToString:@"易企创"] && dic[@"articleId"]!=nil)
        {
           
            
            EQDR_Article_DetailViewController  *Dvc = [[EQDR_Article_DetailViewController alloc]init];
            Dvc.articleId = dic[@"articleId"];
            Dvc.temp =1;
            [self.navigationController pushViewController:Dvc animated:NO];
        }else if ([dic[@"source"] isEqualToString:@"易企阅"]&& dic[@"articleId"]!=nil)
        {
            EQDR_Article_DetailViewController  *Dvc = [[EQDR_Article_DetailViewController alloc]init];
            Dvc.articleId = dic[@"articleId"];
            Dvc.temp =0;
            [self.navigationController pushViewController:Dvc animated:NO];
        }else
        {
            FBWebUrlViewController  *wvc = [[FBWebUrlViewController alloc]init];
            wvc.url = dic[@"url"];
            wvc.contentTitle = dic[@"source"];
            [self.navigationController pushViewController:wvc animated:NO];
        }
        
        
    }
   /* else if ([model.content isKindOfClass:[RCImageMessage class]])
    {
        RCImageMessage *imgmess =(RCImageMessage*)model.content;
        
        FBImgShowViewController  *ISvc =[[FBImgShowViewController alloc]init];
        ISvc.selected =0;
        ISvc.imgstrs= @[imgmess.imageUrl];
        [self.navigationController pushViewController:ISvc animated:NO];
    }*/
    else
    {
        
    }
    
    
}

#pragma mark - RealTimeLocationStatusViewDelegate
- (void)onJoin {
    [self showRealTimeLocationViewController];
}
- (RCRealTimeLocationStatus)getStatus {
    return [self.realTimeLocation getStatus];
}

- (void)onShowRealTimeLocationView {
    [self showRealTimeLocationViewController];
}

/******************实时地理位置共享**************/
- (void)showRealTimeLocationViewController {
    RCUserInfo *info1 =[[RCUserInfo alloc]initWithUserId:user.Guid name:user.upname portrait:user.iphoto];
    [[RCIM sharedRCIM] refreshUserInfoCache:info1 withUserId:user.Guid];
    [[RCIM sharedRCIM] getUserInfoCache:self.targetId];
    RealTimeLocationViewController *lsvc =
    [[RealTimeLocationViewController alloc] init];
    lsvc.realTimeLocationProxy = self.realTimeLocation;
    if ([self.realTimeLocation getStatus] ==
        RC_REAL_TIME_LOCATION_STATUS_INCOMING) {
        [self.realTimeLocation joinRealTimeLocation];
    } else if ([self.realTimeLocation getStatus] ==
               RC_REAL_TIME_LOCATION_STATUS_IDLE) {
        [self.realTimeLocation startRealTimeLocation];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController presentViewController:lsvc
                                                animated:YES
                                              completion:^{
                                                  
                                              }];
    });
   
}
- (void)updateRealTimeLocationStatus {
    if (self.realTimeLocation) {
        [self.realTimeLocationStatusView updateRealTimeLocationStatus];
        __weak typeof(&*self) weakSelf = self;
        NSArray *participants = nil;
        switch ([self.realTimeLocation getStatus]) {
            case RC_REAL_TIME_LOCATION_STATUS_OUTGOING:
                [self.realTimeLocationStatusView updateText:@"你正在共享位置"];
                break;
            case RC_REAL_TIME_LOCATION_STATUS_CONNECTED:
            case RC_REAL_TIME_LOCATION_STATUS_INCOMING:
                participants = [self.realTimeLocation getParticipants];
                if (participants.count == 1) {
                    NSString *userId = participants[0];
                    RCUserInfo  *F_user = [[RCIM sharedRCIM] getUserInfoCache:userId];
                    [weakSelf.realTimeLocationStatusView
                     updateText:F_user.name==nil?userId:F_user.name];
                    [[RCIM sharedRCIM]
                     .userInfoDataSource
                     getUserInfoWithUserId:userId
                     completion:^(RCUserInfo *userInfo) {
                         if (userInfo.name.length) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 [weakSelf.realTimeLocationStatusView
                                  updateText:[NSString stringWithFormat:
                                              @"%@正在共享位置",
                                              userInfo.name]];
                             });
                         }
                     }];
                } else {
                    if (participants.count < 1)
                        [self.realTimeLocationStatusView removeFromSuperview];
                    else
                        [self.realTimeLocationStatusView
                         updateText:[NSString stringWithFormat:@"%d人正在共享地理位置",
                                     (int)participants.count]];
                }
                break;
            default:
                break;
        }
    }
}
- (void)leftBarButtonItemPressed:(id)sender {
    if ([self.realTimeLocation getStatus] ==
        RC_REAL_TIME_LOCATION_STATUS_OUTGOING ||
        [self.realTimeLocation getStatus] ==
        RC_REAL_TIME_LOCATION_STATUS_CONNECTED) {
        
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message: @"离开聊天，位置共享也会结束，确认离开" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.realTimeLocation quitRealTimeLocation];
            [self popupChatViewController];
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    } else {
        [self popupChatViewController];
    }
}
- (void)setRealTimeLocation:(id<RCRealTimeLocationProxy>)realTimeLocation {
    _realTimeLocation = realTimeLocation;
}


- (RealTimeLocationStatusView *)realTimeLocationStatusView {
    if (!_realTimeLocationStatusView) {
        _realTimeLocationStatusView = [[RealTimeLocationStatusView alloc]
                                       initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, self.view.frame.size.width, 0)];
        _realTimeLocationStatusView.height_Bar = DEVICE_TABBAR_Height;
        _realTimeLocationStatusView.delegate = self;
        [self.view addSubview:_realTimeLocationStatusView];
    }
    return _realTimeLocationStatusView;
}

- (void)popupChatViewController {
    [super leftBarButtonItemPressed:nil];
    [self.realTimeLocation removeRealTimeLocationObserver:self];
   [self.navigationController popToRootViewControllerAnimated:NO];

}


 #pragma  mark - 长按的列表显示
- (NSArray<UIMenuItem *> *)getLongTouchMessageCellMenuList:(RCMessageModel *)model
{
    
    NSMutableArray<UIMenuItem *> *menuList =
    [[super getLongTouchMessageCellMenuList:model] mutableCopy];
    M_model = model;
    if([M_model.content isKindOfClass:[RCTextMessage class]]||[M_model.content isKindOfClass:[RCImageMessage class]]||[M_model.content isKindOfClass:[RCFileMessage class]]||[M_model.content isKindOfClass:[FBGeRenCardMessageContent class]] ||[M_model.content isKindOfClass:[RCLocationMessage class]] || [M_model.content isKindOfClass:[FBShareMessageContent class]])
    {
    [menuList addObject:[[UIMenuItem alloc] initWithTitle:@"转发"
                                                   action:@selector(zhuanfaClick)]];
    }
    if([model.content isKindOfClass:[RCTextMessage class]])
    {
    [menuList addObject:[[UIMenuItem alloc] initWithTitle:@"转入备忘录"
                                                   action:@selector(jishibenClick)]];
        [menuList addObject:[[UIMenuItem alloc] initWithTitle:@"转入任务"
                                                       action:@selector(renwuClick)]];
    }
  
    if([model.content isKindOfClass:[RCTextMessage class]]||[model.content isKindOfClass:[RCImageMessage class]] || [model.content isKindOfClass:[RCLocationMessage class]] ||[model.content isKindOfClass:[RCRichContentMessage class]] || [model.content isKindOfClass:[FBShareMessageContent class]])
    {
    [menuList addObject:[[UIMenuItem alloc] initWithTitle:@"收藏"
                                                   action:@selector(shoucangClick)]];
    }
/*   [menuList addObject:[[UIMenuItem alloc] initWithTitle:@"更多"
                                                   action:@selector(moreClick)]];*/
    return menuList;
}
-(void)zhuanfaClick
{
    //转发
   //  RCVoiceMessage RCTextMessage RCImageMessage RCFileMessage
    
 /*   ExActivity *activity = [[ExActivity alloc]init];
    activity.messageContent = M_model.content;
  //        FBActivityViewController *ACvc =[[FBActivityViewController alloc]initWithActivityItems:@[message.content] applicationActivities:@[activity]];
  */
    FB_ShareEQDViewController  *Svc = [[FB_ShareEQDViewController alloc]init];
    
    
    if ([M_model.content isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *message =(RCTextMessage*) M_model.content;
        Svc.content = message;
        Svc.EQD_ShareType = EQD_ShareTypeText;
        Svc.text = message.content;
        Svc.sourceOwner = user.Guid;
        Svc.source = [NSString stringWithFormat:@"与[%@]的聊天",self.navigationItem.title];
    }
    else if([M_model.content isKindOfClass:[RCImageMessage class]])
    {
        RCImageMessage *message =(RCImageMessage*) M_model.content;
        Svc.EQD_ShareType = EQD_ShareTypeImage;
        Svc.imageURL = message.imageUrl;
        Svc.content =message;
    }
    else if([M_model.content isKindOfClass:[RCFileMessage class]])
    {
        RCFileMessage *message =(RCFileMessage*) M_model.content;
        Svc.content =message;
        Svc.EQD_ShareType =EQD_ShareTypeFile;
        Svc.url = message.fileUrl;
        Svc.fileExt =message.type;

    }
    else if([M_model.content isKindOfClass:[RCVoiceMessage class]])
    {
        RCVoiceMessage *message =(RCVoiceMessage*) M_model.content;
        Svc.content =message;
        Svc.EQD_ShareType = EQD_ShareTypeVoice;
    }
    else
    {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"易企点暂不支持该消息类转发"];
    }
    Svc.providesPresentationContextTransitionStyle = YES;
    Svc.definesPresentationContext = YES;
    Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:Svc animated:NO completion:nil];
    });
}
-(void)jishibenClick
{

    //转入备忘录
    Memo_AddViewController  *Avc = [[Memo_AddViewController alloc]init];
    NSDateFormatter  *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    Avc.date_selected =[formatter stringFromDate:[NSDate date]];
    RCTextMessage  *message = (RCTextMessage*)M_model.content;
    Avc.content =message.content;
    [self.navigationController pushViewController:Avc animated:NO];
    
}
-(void)renwuClick
{
    //转入任务
    RWFaSongViewController  *FSvc =[[RWFaSongViewController alloc]init];
    RCTextMessage  *message = (RCTextMessage*)M_model.content;
    FSvc.content =message.content;
    FSvc.isChat=2;
    [self.navigationController pushViewController:FSvc animated:NO];
    
    
}
-(void)shoucangClick
{
    //收藏
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在收藏";
    NSString *source =[NSString stringWithFormat:@"私聊-%@",self.navigationItem.title];
    if ([M_model.content isKindOfClass:[RCTextMessage class]]) {
        //文本
        
        RCTextMessage  *message = (RCTextMessage*)M_model.content;
        [WebRequest  Collection_Add_collectionWithowner:user.Guid title: [NSString stringWithFormat:@"与[%@]的聊天",self.navigationItem.title] ccontent:message.content tel:user.uname sourceOwner:M_model.senderUserId source:source  And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
        }];
        
    }else if([M_model.content isKindOfClass:[RCImageMessage class]])
    {
        //图片
        RCImageMessage *message = (RCImageMessage*)M_model.content;
        [WebRequest Collection_Add_collectionWithowner:user.Guid imgArr:@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:message.imageUrl]]]] tel:user.uname sourceOwner:M_model.senderUserId source:source And:^(NSDictionary *dic) {
             hud.label.text =dic[Y_MSG];
        }];
        
        
    }else if ([M_model.content isKindOfClass:[RCLocationMessage class]])
    {
        //位置
        
        RCLocationMessage  *message = (RCLocationMessage*)M_model.content;
        NSString *tstr = [NSString stringWithFormat:@"%f,%f",message.location.latitude,message.location.longitude];
        [WebRequest Collection_Add_collectionWithowner:user.Guid position:tstr ccontent:message.locationName sourceOwner:M_model.senderUserId source:source And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
        }];
        
    }else if ([M_model.content isKindOfClass:[RCVoiceMessage class]])
    {
        //语音
        RCVoiceMessage *message = (RCVoiceMessage*)M_model.content;
        [WebRequest Collection_Add_collectionWithowner:user.Guid data:message.wavAudioData tel:user.uname ccontent:[NSString stringWithFormat:@"%ld",message.duration] sourceOwner:M_model.senderUserId source:source  And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
        }];
        
        
    }else if ([M_model.content isKindOfClass:[RCRichContentMessage class]])
    {
        //图文
        RCRichContentMessage  *message = (RCRichContentMessage*)M_model.content;
        [WebRequest Collection_Add_collectionWithowner:user.Guid type:@"3" title:message.title ccontent:message.digest imgArr:@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:message.imageURL]]]] tel:user.uname And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
        }];
        
    }else
    {
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
    });
    
}
-(void)moreClick
{
    //更多
}

/*
点击Cell中头像的回调
 
 @param userId  点击头像对应的用户ID
 */
- (void)didTapCellPortrait:(NSString *)userId{
   
    PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
    Pvc.userGuid =userId;
    [self.navigationController pushViewController:Pvc animated:NO];
    
}


- (void)didSendMessage:(NSInteger)status
               content:(RCMessageContent *)messageContent
{
    //消息发送完回调   转发也是同样的逻辑
    [super didSendMessage:status content:messageContent];
    
}

-(void)pluginBoardView:(RCPluginBoardView*)pluginBoardView
    clickedItemWithTag:(NSInteger)tag{
    switch (tag) {
            
        case PLUGIN_BOARD_ITEM_LOCATION_TAG: {
            if (self.realTimeLocation) {
                UIAlertController *alert = [[UIAlertController alloc]init];
                [alert addAction:[UIAlertAction actionWithTitle:@"发送位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [super pluginBoardView:self.chatSessionInputBarControl.pluginBoardView
                        clickedItemWithTag:PLUGIN_BOARD_ITEM_LOCATION_TAG];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"位置实时共享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [self showRealTimeLocationViewController];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:alert animated:NO completion:nil];
                });
                
            } else {
                [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
            }
            
        }
            break;
        
   
    
            
        case 4001:
        {
            //发任务
            if ([user.companyId integerValue]>0) {
                RWFaSongViewController *FSvc =[[RWFaSongViewController alloc]init];
                FSvc.isChat =1;
                FSvc.userGuid =self.targetId;
                FSvc.name =self.navigationItem.title;
                [self.navigationController pushViewController:FSvc animated:NO];
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"必须加入企业才可以使用";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
           
        }
            break;
        case 4002:
        {
           //个人名片
            CardChooseViewController *Cvc =[[CardChooseViewController alloc]init];
            Cvc.userGuid =self.targetId;
            [self.navigationController pushViewController:Cvc animated:NO];
        }
            break;
            
        case 4003:
        {
            //发文件
             [self presentDocumentPicker];
        }
            break;
        default:
             [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
            break;
    }
    
}


#pragma  mark - 发文件
- (void)presentDocumentPicker {
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
    
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes
                                                                                                                          inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:documentPickerViewController animated:YES completion:nil];
    });
}
#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
    NSString *fileName = [array lastObject];
    fileName = [fileName stringByRemovingPercentEncoding];
     NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",fileName]];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"url == %@",path];
    NSArray *tarr = [fileTool getDataWithReg:pre];
    if (tarr.count==0) {
    if ([iCloudManager iCloudEnable]) {
        [iCloudManager downloadWithDocumentURL:url callBack:^(id obj) {
            NSData *data = obj;
            //写入沙盒Documents
           
            
            
            
         BOOL issuccess=  [data writeToFile:path atomically:YES];
            
            if (issuccess ==YES) {
                
               
                [fileTool insertDataWithfileData:@{
                                                   @"type":[[fileName componentsSeparatedByString:@"."] lastObject],
                                                   @"url":path,
                                                   @"userGuid":user.Guid
                                                   }];
                RCFileMessage *file = [RCFileMessage messageWithFile:path];
                [[RCIM sharedRCIM] sendMediaMessage:(ConversationType_PRIVATE) targetId:self.targetId content:file pushContent:nil pushData:nil progress:nil success:^(long messageId) {
                    
                } error:nil cancel:nil];
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"存储文件出错";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            
         
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"不支持iCloud访问";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    }else
    {
        RCFileMessage *file = [RCFileMessage messageWithFile:path];
        [[RCIM sharedRCIM] sendMediaMessage:(ConversationType_PRIVATE) targetId:self.targetId content:file pushContent:nil pushData:nil progress:nil success:^(long messageId) {
            
        } error:nil cancel:nil];
    }
}


- (RCMessageBaseCell *)rcConversationCollectionView:(UICollectionView *)collectionView
                             cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    [super rcConversationCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    
  FBMessageCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"FBMessageBaseCell" forIndexPath:indexPath];
    RCMessageModel *model =self.conversationDataRepository[indexPath.row];
    if ([model.content isKindOfClass:[FBGeRenCardMessageContent class]]) {
         [cell1 setDataModel:model];
    }
    
    FBMessageCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"FBShareMessageBaseCell" forIndexPath:indexPath];
    RCMessageModel *model2 =self.conversationDataRepository[indexPath.row];
    if ([model.content isKindOfClass:[FBShareMessageContent class]]) {
        [cell2 setDataModel:model2];
    }
   
    
    return cell1;
}



-(void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[FBMessageCell class]]) {
        FBMessageCell *cell0 = (FBMessageCell*)cell;
        RCMessageModel *model =self.conversationDataRepository[indexPath.row];
        [cell0 setDataModel:model];
        

}
}

- (CGSize)rcConversationCollectionView:(UICollectionView *)collectionView
                                layout:(UICollectionViewLayout *)collectionViewLayout
                sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size =[super rcConversationCollectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
//    size.height+=55;
    
    return size;
}


- (void)notifyUpdateUnreadMessageCount {
    [super notifyUpdateUnreadMessageCount];
    __weak typeof(&*self) __weakself = self;
    int count = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                @(ConversationType_PRIVATE),
                                                                @(ConversationType_GROUP)
                                                                ]];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *backString = nil;
        if (count > 0 && count < 1000) {
            backString = [NSString stringWithFormat:@"返回(%d)", count];
        } else if (count >= 1000) {
            backString = @"返回(...)";
        } else {
            backString = @"返回";
        }
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 6, 87, 23);
        UIImageView *backImg = [[UIImageView alloc]
                                initWithImage:[UIImage imageNamed:@"navigator_btn_back"]];
        backImg.frame = CGRectMake(-6, 4, 10, 17);
        [backBtn addSubview:backImg];
        UILabel *backText =
        [[UILabel alloc] initWithFrame:CGRectMake(9, 4, 85, 17)];
        backText.text = backString;
        // NSLocalizedStringFromTable(@"Back",
        // @"RongCloudKit", nil);
        backText.font = [UIFont systemFontOfSize:17];
        [backText setBackgroundColor:[UIColor clearColor]];
        [backText setTextColor:EQDCOLOR];
        [backBtn addSubview:backText];
        [backBtn addTarget:__weakself
                    action:@selector(leftBarButtonItemPressed:)
          forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButton =
        [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        [__weakself.navigationItem setLeftBarButtonItem:leftButton];
    });
}



@end
