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
@interface FB_ShareEQDViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *CollectionV;
    NSMutableArray  *arr_model;
    NSArray  *arr_json;
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
    }else if (self.EQD_ShareType ==EQD_ShareTypeImage)
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
    }else
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
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-(width_cell+40)*(arr_json.count/4+1), DEVICE_WIDTH, (width_cell+40)*(arr_json.count/4+1)) collectionViewLayout:flowL];
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
    Svc.messageContent = self.content;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Svc];
    [self  presentViewController:nav animated:NO completion:nil];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [self dismissViewControllerAnimated:NO completion:nil];
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
        }
            break;
        case 13:
        {
            //我的收藏
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
    if (self.EQD_ShareType ==EQD_ShareTypeText) {
        [self shareTextWithPlatform:platform];
    }else if (self.EQD_ShareType ==EQD_ShareTypeImage )
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
        
    }];
}

- (void)shareImageWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    NSString *imageURL = self.imageURL;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.mediaType = JSHAREImage;
    message.platform = platform;
    message.image = imageData;
    
    /*QQ 空间 和 Facebook/Messenger 支持多张图片
     1.QQ 空间图片数量限制为20张。若只分享单张图片使用 image 字段即可。
     2.Facebook/Messenger 图片数量限制为6张。如果分享单张图片，图片大小建议不要超过12M；如果分享多张图片，图片大小建议不要超过700K，否则可能出现重启手机或者不能分享。*/
    
    //message.images = @[imageData,imageData];
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];
}
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHARELink;
    message.url = self.url;
    message.text = self.text;
    message.title = self.text;
    message.platform = platform;
    NSString *imageURL = self.imageURL;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.image = imageData;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
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
    }];
}

- (void)shareFileWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREFile;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jiguang" ofType:@"mp4"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    message.fileData = fileData;
    message.fileExt = @"mp4";
    message.platform = platform;
    message.title = @"jiguang.mp4";
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
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
        
    }];
}




@end
