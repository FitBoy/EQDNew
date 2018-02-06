//
//  FB_ShareEQDViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/*
 LYvc.providesPresentationContextTransitionStyle = YES;
 LYvc.definesPresentationContext = YES;
 LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
 */
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FB_ShareEQDViewController.h"
#import "FB_shareEQDCollectionViewCell.h"
#import <MJExtension.h>
#import "JSHAREService.h"
#import "MBFadeAlertView.h"
#import "FBShareViewController.h"
#import "FBShareMessageContent.h"
#import "FBGeRenCardMessageContent.h"
@interface FB_ShareEQDViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *CollectionV;
    NSMutableArray  *arr_model;
    NSArray  *arr_json;
    MBProgressHUD *hud;
}

@end

@implementation FB_ShareEQDViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [arr_model removeAllObjects];
    for(int i=0;i<arr_json.count;i++)
    {
        NSDictionary *tdic = arr_json[i];
        FB_ShareModel *model =[FB_ShareModel mj_objectWithKeyValues:tdic];
        [arr_model addObject:model];
    }
    [CollectionV reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.EQD_ShareType == EQD_ShareTypeText) {
        arr_json = @[
                     @{
                         @"img":@"share_friend",
                         @"biaoji":@"10",
                         @"name":@"发送给好友"
                         },
                     @{
                         @"img":@"share_eqd",
                         @"biaoji":@"11",
                         @"name":@"工作圈"
                         },
                     @{
                         @"img":@"share_shoucang",
                         @"biaoji":@"13",
                         @"name":@"我的收藏"
                         },
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         },
                     @{
                         @"img":@"wechat_moment",
                         @"biaoji":@"22",
                         @"name":@"朋友圈"
                         },
                     @{
                         @"img":@"qq",
                         @"biaoji":@"30",
                         @"name":@"QQ"
                         },
                     @{
                         @"img":@"qzone",
                         @"biaoji":@"31",
                         @"name":@"qq空间"
                         },
                     @{
                         @"img":@"weibo",
                         @"biaoji":@"40",
                         @"name":@"新浪微博"
                         },
                     ];
    }else if (self.EQD_ShareType ==EQD_ShareTypeImage || self.EQD_ShareType ==EQD_ShareTypeImage2)
    {
        arr_json = @[
                     @{
                         @"img":@"share_friend",
                         @"biaoji":@"10",
                         @"name":@"发送给好友"
                         },
                     @{
                         @"img":@"share_eqd",
                         @"biaoji":@"11",
                         @"name":@"工作圈"
                         },
                     @{
                         @"img":@"share_shoucang",
                         @"biaoji":@"13",
                         @"name":@"我的收藏"
                         },
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         },
                     @{
                         @"img":@"wechat_moment",
                         @"biaoji":@"22",
                         @"name":@"朋友圈"
                         },
                     @{
                         @"img":@"qq",
                         @"biaoji":@"30",
                         @"name":@"QQ"
                         },
                     @{
                         @"img":@"qzone",
                         @"biaoji":@"31",
                         @"name":@"qq空间"
                         },
                     @{
                         @"img":@"weibo",
                         @"biaoji":@"40",
                         @"name":@"新浪微博"
                         },
                     ];
    }else if (self.EQD_ShareType ==EQD_ShareTypeLink)
    {
        arr_json = @[
                     @{
                         @"img":@"share_friend",
                         @"biaoji":@"10",
                         @"name":@"发送给好友"
                         },
                     @{
                         @"img":@"share_eqd",
                         @"biaoji":@"11",
                         @"name":@"工作圈"
                         },
                     
                     @{
                         @"img":@"share_shoucang",
                         @"biaoji":@"13",
                         @"name":@"我的收藏"
                         },
                     @{
                         @"img":@"share_safari",
                         @"biaoji":@"16",
                         @"name":@"用safari打开"
                         },
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         },
                     @{
                         @"img":@"wechat_moment",
                         @"biaoji":@"22",
                         @"name":@"朋友圈"
                         },
                     @{
                         @"img":@"qq",
                         @"biaoji":@"30",
                         @"name":@"QQ"
                         },
                     @{
                         @"img":@"qzone",
                         @"biaoji":@"31",
                         @"name":@"qq空间"
                         },
                     @{
                         @"img":@"weibo",
                         @"biaoji":@"40",
                         @"name":@"新浪微博"
                         },
                     ];
    }else if (self.EQD_ShareType ==EQD_ShareTypeFile)
    {
        arr_json = @[
                     @{
                         @"img":@"share_friend",
                         @"biaoji":@"10",
                         @"name":@"发送给好友"
                         },
                     
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         }
                     ];
    }else if (self.EQD_ShareType == EQD_ShareTypeVideo)
    {
        arr_json = @[
                     
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         },
                     @{
                         @"img":@"wechat_moment",
                         @"biaoji":@"22",
                         @"name":@"朋友圈"
                         },
                     @{
                         @"img":@"qq",
                         @"biaoji":@"30",
                         @"name":@"QQ"
                         },
                     @{
                         @"img":@"qzone",
                         @"biaoji":@"31",
                         @"name":@"qq空间"
                         }
                     ];
    }else if (self.EQD_ShareType ==EQD_ShareTypeGerenCard || self.EQD_ShareType ==EQD_ShareTypeVoice)
    {
        arr_json = @[
                     @{
                         @"img":@"share_friend",
                         @"biaoji":@"10",
                         @"name":@"发送给好友"
                         }
                     ];
    }
    else
    {
        arr_json = nil;
    }
    float  width_cell = (DEVICE_WIDTH - 50)/4.0;
    arr_model =[NSMutableArray arrayWithCapacity:0];
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake(width_cell, width_cell+30);
    flowL.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    flowL.minimumLineSpacing=5;
    flowL.minimumInteritemSpacing=5;
//    flowL.headerReferenceSize = CGSizeMake(DEVICE_WIDTH, 40);
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-(width_cell+40)*(arr_json.count/4+1)-kBottomSafeHeight, DEVICE_WIDTH, (width_cell+40)*(arr_json.count/4+1)) collectionViewLayout:flowL];
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    self.view.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    [CollectionV registerClass:[FB_shareEQDCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    CollectionV.backgroundColor = [UIColor whiteColor];
   


}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - collection 数据源与代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arr_model.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FB_shareEQDCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    FB_ShareModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    
    return cell;
}
-(void)sendFriend{
   
    FBShareViewController  *Svc =[[FBShareViewController alloc]init];
    NSInteger temp =0;
    if(self.content)
    {
        //消息体
    Svc.messageContent = self.content;
        temp =0;
    }else
    {
        temp =0;
        //纯文本
        if (self.EQD_ShareType ==EQD_ShareTypeText) {
            RCTextMessage *textMessage = [RCTextMessage messageWithContent:self.text];
            Svc.messageContent = textMessage;
        }else if (self.EQD_ShareType ==EQD_ShareTypeImage)
        {
            
            NSData *dataUrl = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:self.imageURL]];
            
            RCImageMessage  *imgMessage = [RCImageMessage messageWithImageData:dataUrl];
            Svc.messageContent = imgMessage;
        }else if (self.EQD_ShareType == EQD_ShareTypeImage2)
        {
            RCImageMessage  *imgMessage = [RCImageMessage messageWithImage:self.image_local];
            Svc.messageContent = imgMessage;
        }else if (self.EQD_ShareType ==EQD_ShareTypeLink)
        {
            /*String title;
            String content;
            String url;
            String imgUrl;
            String source;
            String sourceOwner;
            articleId*/
            NSDictionary  *dic = @{
                                   @"title":self.Stitle,
                                   @"content":self.text,
                                   @"url":self.url,
                                   @"imgUrl":self.imageURL,
                                   @"sourceOwner":self.sourceOwner,
                                   @"source":self.source,
                                   @"articleId":self.articleId
                                   };
            FBShareMessageContent *message=[[FBShareMessageContent alloc]initWithgeRenCardWithcontent:dic];
            Svc.messageContent =message;
        }else if (self.EQD_ShareType ==EQD_ShareTypeGerenCard)
        {
            NSDictionary *dic = @{
                                  @"imgurl":self.imgurl,
                                  @"name":self.name,
                                  @"bumen":self.bumen,
                                  @"gangwei":self.gangwei,
                                  @"company":self.company,
                                  @"uid":self.uid,
                                  @"comid":self.comid
                                  };
            FBGeRenCardMessageContent  *gerenMessage = [[FBGeRenCardMessageContent alloc]initWithgeRenCardWithcontent:dic];
            Svc.messageContent =gerenMessage;
            
        }else if (self.EQD_ShareType == EQD_ShareTypeFile)
        {
            RCFileMessage  *fileMessage = [RCFileMessage messageWithFile:self.fileLocalPath];
            Svc.messageContent =fileMessage;
        }
        else
        {
            temp =1;
        }
    }
    if (temp==0) {
        
        
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Svc];
                [self  presentViewController:nav animated:NO completion:nil];
      
       
    }else
    {
        MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"暂不支持此类型的消息"];
    }
    
}
#pragma  mark - 发送到工作圈
-(void)sendWorkCircle{
    ///文字 ，图片 ，链接
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在后台运行";
    UserModel *user = [WebRequest GetUserInfo];
    NSString *address = [USERDEFAULTS objectForKey:Y_AMAP_address];
    if (self.EQD_ShareType ==EQD_ShareTypeText) {
        [WebRequest Add_WorkCircleWithcompanyId:user.companyId userGuid:user.Guid message:self.text name:user.upname location:address imgarr:nil And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text = @"分享成功";
            }else
            {
                hud.label.text =@"分享失败,请重试";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
    }else if (self.EQD_ShareType ==EQD_ShareTypeImage2)
    {
        [WebRequest Add_WorkCircleWithcompanyId:user.companyId userGuid:user.Guid message:@" " name:user.upname location:address imgarr:@[self.image_local] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text = @"分享成功";
            }else
            {
                hud.label.text =@"分享失败,请重试";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
    }else if (self.EQD_ShareType == EQD_ShareTypeImage)
    {
        //图片的连接
    }else if (self.EQD_ShareType ==EQD_ShareTypeLink)
    {
        //纯连接
    }else
    {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"暂不支持此类文件"];
    }
}
#pragma  mark - 我的收藏
-(void)sendMyShouCang{

    UserModel *user = [WebRequest GetUserInfo];
    if (self.EQD_ShareType ==EQD_ShareTypeText) {
        [WebRequest Collection_Add_collectionWithowner:user.Guid title:@"我的收藏" ccontent:self.text tel:user.uname sourceOwner:self.sourceOwner source:self.source And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                MBFadeAlertView  *alert =[[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"收藏成功"];
            }else
            {
                MBFadeAlertView  *alert =[[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"收藏失败,请重试"];
            }
        }];
        
    }else if (self.EQD_ShareType ==EQD_ShareTypeImage)
    {
        [WebRequest Collection_Add_collectionWithowner:user.Guid url:self.imageURL source:self.source sourceOwner:self.sourceOwner And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                MBFadeAlertView  *alert =[[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"收藏成功"];
            }else
            {
                MBFadeAlertView  *alert =[[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"收藏失败,请重试"];
            }
        }];
    }else if (self.EQD_ShareType ==EQD_ShareTypeImage2)
    {
        [WebRequest Collection_Add_collectionWithowner:user.Guid type:@"3" title:@"我的收藏" ccontent:@" " imgArr:@[self.image_local] tel:user.uname And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                MBFadeAlertView  *alert =[[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"收藏成功"];
            }else
            {
                MBFadeAlertView  *alert =[[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"收藏失败,请重试"];
            }
        }];
        
    }else if (self.EQD_ShareType ==EQD_ShareTypeLink)
    {
        [WebRequest Collection_Add_collectionowner:user.Guid type:[NSString stringWithFormat:@"%ld",self.type] title:self.Stitle url:self.url source:self.source sourceOwner:self.sourceOwner articleId:self.articleId And:^(NSDictionary *dic) {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"收藏成功"];
            }else
            {
                [alert showAlertWith:@"收藏失败，请重试"];
            }
        }];
        
    }else
    {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
         [alert showAlertWith:@"暂不支持此类型"];
    }
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FB_ShareModel *model =arr_model[indexPath.row];
    switch ([model.biaoji integerValue]) {
        case 10:
            {
                //发送到朋友
              
                [self sendFriend];
            }
            break;
        case 11:
        {
            //工作圈
            [self sendWorkCircle];
        }
            break;
        case 13:
        {
            //我的收藏
            [self sendMyShouCang];
        }
            break;
        case 15:
        {
            //复制链接
            UIPasteboard   *pasted = [UIPasteboard generalPasteboard];
            pasted.string = self.url;
        }
            break;
        case 16:
        {
            //用safari打开
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.url]])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.url] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
                    if (success == NO) {
                        MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
                        [alert showAlertWith:@"服务器错误"];
                    }
                }];
            }else
            {
                MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"无效的地址"];
            }
        }
            break;
        case 20:
        {
            //微信
            [self shareAutoWithPlatform:JSHAREPlatformWechatSession];
        }
            break;
        case 21:
        {
            //微信收藏
            [self shareAutoWithPlatform:JSHAREPlatformWechatFavourite];
        }
            break;
        case 22:
        {
            //朋友圈
            [self shareAutoWithPlatform:JSHAREPlatformWechatTimeLine];
        }
            break;
        case 30:
        {
            //QQ
            [self shareAutoWithPlatform:JSHAREPlatformQQ];
        }
            break;
        case 31:
        {
            //qq空间
            [self shareAutoWithPlatform:JSHAREPlatformQzone];
            
        }
            break;
        case 40:
        {
            //微博
            [self shareAutoWithPlatform:JSHAREPlatformSinaWeibo];
            
        }
            break;
        default:
            break;
    }
    
}

-(void)shareAutoWithPlatform:(JSHAREPlatform)platform
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在跳转";
    if (self.EQD_ShareType ==EQD_ShareTypeText) {
        [self shareTextWithPlatform:platform];
    }else if (self.EQD_ShareType ==EQD_ShareTypeImage|| self.EQD_ShareType ==EQD_ShareTypeImage2)
    {
        [self shareImageWithPlatform:platform];
    }else if (self.EQD_ShareType ==EQD_ShareTypeLink)
    {
        [self shareLinkWithPlatform:platform];
    }else if (self.EQD_ShareType ==EQD_ShareTypeFile)
    {
        [self shareMusicWithPlatform:platform];
    }else
    {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"暂不支持此类型的转发"];
    }
}

- (void)shareTextWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.text = self.text;
    message.platform = platform;
    message.mediaType = JSHAREText;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
}

- (void)shareImageWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    NSData *imageData =nil;
    if (self.EQD_ShareType == EQD_ShareTypeImage) {
        NSString *imageURL = self.imageURL;
      imageData  = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    }else if (self.EQD_ShareType == EQD_ShareTypeImage2)
    {
        imageData = UIImagePNGRepresentation(self.image_local);
    }else
    {
        
    }
   
    
    message.mediaType = JSHAREImage;
    message.platform = platform;
    message.image = imageData;
    
    /*QQ 空间 和 Facebook/Messenger 支持多张图片
     1.QQ 空间图片数量限制为20张。若只分享单张图片使用 image 字段即可。
     2.Facebook/Messenger 图片数量限制为6张。如果分享单张图片，图片大小建议不要超过12M；如果分享多张图片，图片大小建议不要超过700K，否则可能出现重启手机或者不能分享。*/
    
    //message.images = @[imageData,imageData];
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        [hud hideAnimated:NO];
        NSLog(@"分享回调");
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
}
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHARELink;
    message.url = self.url;
    message.text = self.text;
    message.title = self.Stitle;
    message.platform = platform;
    NSString *imageURL = self.imageURL;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.image = imageData;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
}

- (void)shareMusicWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREAudio;
    message.url =  self.url;
    message.text = self.text;
    message.title = self.Stitle;
    message.platform = platform;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)shareVideoWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREVideo;
    message.url =self.url;
    message.text = self.text;
    message.title = self.Stitle;
    message.platform = platform;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)shareAppWithPlatform:(JSHAREPlatform)platform {
    Byte* pBuffer = (Byte *)malloc(10*1024*1024);
    memset(pBuffer, 0, 10*1024);
    NSData* data = [NSData dataWithBytes:pBuffer length:10*1024*1024];
    free(pBuffer);
    
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREApp;
    message.url =self.url;
    message.text = self.text;
    message.title = self.Stitle;
    message.extInfo = @"<xml>extend info</xml>";
    message.fileData = data;
    message.platform = platform;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)shareEmoticonWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREEmoticon;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6" ofType:@"gif"];
    NSData *emoticonData = [NSData dataWithContentsOfFile:filePath];
    message.emoticonData = emoticonData;
    message.platform = platform;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)shareFileWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREFile;
    NSData *fileData=nil;
    if (self.filePath) {
      
       fileData = [NSData dataWithContentsOfFile:self.filePath];
    }else
    {
        fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.url]];
    }
   
    message.fileData = fileData;
    message.fileExt = self.fileExt;
    message.platform = platform;
    message.title = [NSString stringWithFormat:@"ios_file%@",self.fileExt];
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)shareLinkToSinaWeiboContact{
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHARELink;
    message.url = self.url;
    message.text = self.text;
    message.title = self.Stitle;
    message.platform = JSHAREPlatformSinaWeiboContact;
    NSString *imageURL = self.imageURL;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.image = imageData;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        [hud hideAnimated:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}




@end
