//
//  FBQunChatViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBQunChatViewController.h"
#import "FBActivityViewController.h"
#import "ExActivity.h"
#import "QCYDetailViewController.h"
#import "FBGeRenCardMessageContent.h"
#import "FBMessageCell.h"
#import "CardChooseViewController.h"
#import "qunListModel.h"
#import <UIButton+WebCache.h>
#import "PPersonCardViewController.h"
#import "Memo_AddViewController.h"
#import "RWFaSongViewController.h"
#import "FBShareUrlMessageCollectionViewCell.h"
#import "EQDR_Article_DetailViewController.h"
#import "FB_ShareEQDViewController.h"
@interface FBQunChatViewController ()<RCIMGroupMemberDataSource>
{
    
     RCMessageModel  *M_model;
    UserModel *user;
    NSMutableArray *arr1;
    qunListModel *model1;
    UIButton *rightBtn;
    
}

@end

@implementation FBQunChatViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   /* [WebRequest Usre_SearchGroupWithgroupname:nil groupid:self.targetId And:^(NSDictionary *dic) {
        NSNumber *number = dic[Y_STATUS];
        if ([number integerValue]==200) {
            NSArray *items = dic[Y_ITEMS];
            model1 = [qunListModel mj_objectWithKeyValues:items[0]];
            
            [rightBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model1.groupphoto]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"qun"]];
         
        }
    }];*/
    
   
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn addTarget:self action:@selector(QunDetailClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame =CGRectMake(0, 0, 30, 30);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"qun"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:right];
    arr1=[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    self.view.backgroundColor =[UIColor whiteColor];
//    self.displayConversationTypeArray = @[@(ConversationType_PRIVATE),@(ConversationType_GROUP)];
    self.conversationType = ConversationType_GROUP;
    self.enableUnreadMessageIcon =YES;
    self.displayUserNameInCell=YES;
    self.enableNewComingMessageIcon=YES;
    [RCIM sharedRCIM].enableTypingStatus =YES;
    [RCIM sharedRCIM].enableSyncReadStatus=YES;
    //@的设置
    [RCIM sharedRCIM].enableMessageMentioned=YES;

   
    [RCIM sharedRCIM].groupMemberDataSource=self;
//    [RCIM sharedRCIM].userInfoDataSource =self;
//    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"renwu.png"] title:@"发任务" atIndex:5 tag:4001];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[RCKitUtility imageNamed:@"card.png" ofBundle:@"RongCloud.bundle"] title:@"个人名片" atIndex:6 tag:4002];
    [self notifyUpdateUnreadMessageCount];
    
    
    [[RCIM sharedRCIM] registerMessageType:[FBGeRenCardMessageContent class]];
    [self.conversationMessageCollectionView registerClass:[FBMessageCell class] forCellWithReuseIdentifier:@"FBMessageBaseCell"];
    [self registerClass:[FBMessageCell class] forMessageClass:[FBGeRenCardMessageContent class]];
    [[RCIM sharedRCIM] registerMessageType:[FBShareMessageContent class]];
    [self.conversationMessageCollectionView registerClass:[FBShareUrlMessageCollectionViewCell class] forCellWithReuseIdentifier:@"FBShareMessageBaseCell"];
    [self registerClass:[FBShareUrlMessageCollectionViewCell class] forMessageClass:[FBShareMessageContent class]];
    
}
//、扩展功能
-(void)pluginBoardView:(RCPluginBoardView*)pluginBoardView
    clickedItemWithTag:(NSInteger)tag{
    [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
    switch (tag) {
        case 4002:
        {
            
            
                        
                        CardChooseViewController *Cvc =[[CardChooseViewController alloc]init];
                        Cvc.userGuid = self.targetId;
                        Cvc.isQun=YES;
            [self.navigationController pushViewController:Cvc animated:NO];
            
            
        }
            break;
            
        default:
            break;
    }
    
}




//群组红包设置 音视频群成员设置
-(void)getAllMembersOfGroup:(NSString *)groupId result:(void (^)(NSArray<NSString *> *))resultBlock
{
    
    groupId =self.targetId;
    if(arr1.count)
    {
        resultBlock(arr1);
    }
    else
    {
    [arr1 removeAllObjects];
        [WebRequest User_GroupmemberWithgroupid:self.targetId And:^(NSDictionary *dic) {
            [arr1 removeAllObjects];
            NSNumber *number =dic[Y_STATUS];
            NSArray *arr =dic[Y_ITEMS];
            if ([number integerValue]==200 ) {
                if(arr.count)
                {
                    for (NSDictionary *dic1 in arr) {
                        NSString *uname = dic1[@"Guid"];
                        NSString *upname =dic1[@"upname"];
                        NSString *iphoto =dic1[@"iphoto"];
                        RCUserInfo *info =[[RCUserInfo alloc]initWithUserId:uname name:upname portrait:iphoto];
//                        [[RCIM sharedRCIM] refreshGroupUserInfoCache:info withUserId:uname withGroupId:self.targetId];
                        [[RCIM sharedRCIM] refreshUserInfoCache:info withUserId:uname];
                        [arr1 addObject:uname];
                    }
                    
                }
                resultBlock(arr1);
            }
        }];
        
    }
    
}
-(void)QunDetailClick
{
    //群设置
    QCYDetailViewController *Dvc =[[QCYDetailViewController alloc]init];
    Dvc.qunid = self.targetId;
    Dvc.qunname =self.navigationItem.title;
    [self.navigationController pushViewController:Dvc animated:NO];
    
    
    
}
//长按的列表显示
- (NSArray<UIMenuItem *> *)getLongTouchMessageCellMenuList:(RCMessageModel *)model
{
    
    NSMutableArray<UIMenuItem *> *menuList =
    [[super getLongTouchMessageCellMenuList:model] mutableCopy];
    M_model = model;
    if([M_model.content isKindOfClass:[RCTextMessage class]]||[M_model.content isKindOfClass:[RCImageMessage class]]||[M_model.content isKindOfClass:[RCFileMessage class]]||[M_model.content isKindOfClass:[FBGeRenCardMessageContent class]]|| [M_model.content isKindOfClass:[FBShareMessageContent class]])
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
  
    if([model.content isKindOfClass:[RCTextMessage class]]||[model.content isKindOfClass:[RCImageMessage class]] || [model.content isKindOfClass:[RCLocationMessage class]] ||[model.content isKindOfClass:[RCRichContentMessage class]] || [M_model.content isKindOfClass:[FBShareMessageContent class]])
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
    FB_ShareEQDViewController  *Svc = [[FB_ShareEQDViewController alloc]init];
    
    
    if ([M_model.content isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *message =(RCTextMessage*) M_model.content;
        Svc.content = message;
        Svc.EQD_ShareType = EQD_ShareTypeText;
        Svc.text = message.content;
    }
    else if([M_model.content isKindOfClass:[RCImageMessage class]])
    {
        RCImageMessage *message =(RCImageMessage*) M_model.content;
        Svc.EQD_ShareType = EQD_ShareTypeImage2;
        Svc.image_local = message.originalImage;
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
    [self presentViewController:Svc animated:NO completion:nil];
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
    NSString  *source =[NSString stringWithFormat:@"群组-%@",self.navigationItem.title];
    if ([M_model.content isKindOfClass:[RCTextMessage class]]) {
        //文本
        RCTextMessage  *message = (RCTextMessage*)M_model.content;
        [WebRequest  Collection_Add_collectionWithowner:user.Guid title:@"群聊" ccontent:message.content tel:user.uname sourceOwner:M_model.senderUserId source:source  And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
        }];
        
    }else if([M_model.content isKindOfClass:[RCImageMessage class]])
    {
        //图片
        RCImageMessage *message = (RCImageMessage*)M_model.content;
        [WebRequest Collection_Add_collectionWithowner:user.Guid imgArr:@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:message.imageUrl]]]] tel:user.uname sourceOwner:M_model.senderUserId source:source  And:^(NSDictionary *dic) {
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
        [WebRequest Collection_Add_collectionWithowner:user.Guid data:message.wavAudioData tel:user.uname ccontent:[NSString stringWithFormat:@"%ld",message.duration] sourceOwner:M_model.senderUserId source:source And:^(NSDictionary *dic) {
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
#pragma  mark - 点击cell的事件
- (void)didTapMessageCell:(RCMessageModel *)model {
    [super didTapMessageCell:model];
    if([model.content isKindOfClass:[FBGeRenCardMessageContent class]])
    {
        FBGeRenCardMessageContent *contet =(FBGeRenCardMessageContent*)model.content;
        PPersonCardViewController  *Pvc =[[PPersonCardViewController alloc]init];
        Pvc.userGuid =contet.content[@"uid"];
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if ([model.content isKindOfClass:[FBShareMessageContent class]])
    {
        FBShareMessageContent  *content = (FBShareMessageContent*)model.content;
        NSDictionary *dic = content.content;
        EQDR_Article_DetailViewController  *Dvc = [[EQDR_Article_DetailViewController alloc]init];
        Dvc.articleId = dic[@"articleId"];
        if([dic[@"source"] isEqualToString:@"易企创"])
        {
            Dvc.temp =1;
        }else if ([dic[@"source"] isEqualToString:@"易企阅"])
        {
            Dvc.temp =0;
        }
        
        [self.navigationController pushViewController:Dvc animated:NO];
    }
    
    else
    {
        
    }
    
    
}


- (void)didSendMessage:(NSInteger)status
               content:(RCMessageContent *)messageContent
{
    //消息发送完回调   转发也是同样的逻辑
    [super didSendMessage:status content:messageContent];
    
}


-(void)leftBarButtonItemPressed:(id)sender
{
    [super leftBarButtonItemPressed:sender];
    [self.navigationController  popToRootViewControllerAnimated:NO];
}


- (RCMessageBaseCell *)rcConversationCollectionView:(UICollectionView *)collectionView
                             cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    [super rcConversationCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    FBMessageCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"FBMessageBaseCell" forIndexPath:indexPath];
    RCMessageModel *model =self.conversationDataRepository[indexPath.row];
    if([model.content isKindOfClass:[FBGeRenCardMessageContent class]])
    {
         [cell1 setDataModel:model];
    }
    FBMessageCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"FBShareMessageBaseCell" forIndexPath:indexPath];
    RCMessageModel *model2 =self.conversationDataRepository[indexPath.row];
    if([model.content isKindOfClass:[FBShareMessageContent class]])
    {
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
    size.height+=66;
    
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
        backText.text = backString; // NSLocalizedStringFromTable(@"Back",
        // @"RongCloudKit", nil);
        //   backText.font = [UIFont systemFontOfSize:17];
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
