//
//  AppDelegate.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define BUGLY_APP_ID @"509c4047f7"
#import "AppDelegate.h"
#import "FBTabBarViewController.h"

#import <RongIMKit/RongIMKit.h>
#import <RongCallKit/RongCallKit.h>
#import <JPUSHService.h>
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "StartViewController.h"
#import "WebRequest.h"
#import "EQDLoginViewController.h"
#import "FBShareViewController.h"
#import "FBGeRenCardMessageContent.h"
#import <Bugly/Bugly.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "FBSocketTool.h"
#import "TKaoQinViewController.h"
#import "SDAdImageView.h"
#import "JSHAREService.h"
#import "FBShareMessageContent.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<RCIMConnectionStatusDelegate,
RCIMReceiveMessageDelegate,JPUSHRegisterDelegate,BuglyDelegate,UNUserNotificationCenterDelegate>
{
    UserModel *user;
    NSInteger temp;
}

@end

@implementation AppDelegate



-(void)setProductImgage{
    if ([SDLaunchImageTool isAdImageExist]) {
        SDAdImageView *adImageView = [[SDAdImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        adImageView.delaySeconds = 3.0f;
        [adImageView show];
        adImageView.tapActionBlock = ^(SDAdImageView *adImageView ,NSString *destUrl) {
            NSLog(@"点击开屏广告");
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:destUrl]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:destUrl] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
                    
                }];
            }
            
            return YES;
        };
    }
}
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window

{
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
    
}

-(void)addnotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comeHome:) name:@"UIApplicationDidEnterBackgroundNotification" object:nil];
}
- (void)comeHome:(UIApplication *)application {
    NSLog(@"进入后台");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"程序被杀死");
    [self quiteLogin];
    
}
///极光分享用的
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    [JSHAREService handleOpenUrl:url];
    return YES;
}
-(void)setUpJshareServer
{
    JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
    config.appKey = appKey;
    config.SinaWeiboAppKey = @"3719457495";
    config.SinaWeiboAppSecret = @"06de570974a5aa3568a19dbdeaae603d";
    config.SinaRedirectUri = @"https://www.eqidd.com";
    config.QQAppId = @"1106545812";
    config.QQAppKey = @"2mH9J8txuUtg5YCL";
    config.WeChatAppId = @"wx225929aa256e2053";
    config.WeChatAppSecret = @"980d8583d596984fb5c162f6baf1f215";
    config.isProduction = YES;
    config.isSupportWebSina = YES;
    
    [JSHAREService setupWithConfig:config];
    ///发布产品后改成NO 
    [JSHAREService setDebug:NO];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc]init];
    [self.window makeKeyAndVisible];
    ///本地通知的注册
    /******/
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //监听回调事件
    center.delegate = self;
    
    //iOS 10 使用以下方法注册，才能得到授权
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                          }];
    /****/
  
    
//    if (@available(iOS 11.0, *)) {
//       [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
    temp = 1;
    
    
    [self addnotification];
//    [FBSocketTool sharedInstance].socketHost =@"47.94.173.253";
//    [FBSocketTool sharedInstance].socketPort = 8008;
//    [[FBSocketTool sharedInstance] cutOffSocket];
//    [[FBSocketTool sharedInstance] socketConnectHost];
   
  
    //删除推送条幅
//     [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
//
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
  
    
    //高德地图的设置
    [AMapServices sharedServices].apiKey = AMAP_KEY;
    
    /**********极光推送设置************/
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
              NSSet<UNNotificationCategory *> *categories;
              entity.categories = categories;
            }
            else {
              NSSet<UIUserNotificationCategory *> *categories;
              entity.categories = categories;
            }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // 3.0.0以前版本旧的注册方式
    //  if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
    //#ifdef NSFoundationVersionNumber_iOS_9_x_Max
    //    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    //    entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
    //    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //#endif
    //  } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    //      //可以添加自定义categories
    //      [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
    //                                                        UIUserNotificationTypeSound |
    //                                                        UIUserNotificationTypeAlert)
    //                                            categories:nil];
    //  } else {
    //      //categories 必须为nil
    //      [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
    //                                                        UIRemoteNotificationTypeSound |
    //                                                        UIRemoteNotificationTypeAlert)
    //                                            categories:nil];
    //  }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    [JPUSHService crashLogON];
    [JPUSHService resetBadge];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    [self setUpJshareServer];
    /**********极光推送设置************/
    
    //融云的一些配置与设置
    // 远程推送的内容
    NSDictionary *remoteNotificationUserInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"收到的远程推送===%@",remoteNotificationUserInfo);
    [[RCIM sharedRCIM] initWithAppKey:APPKEY_RongCloud];
    [RCIM sharedRCIM].globalNavigationBarTintColor =YQDCOLOR;
   
    //设置红包扩展的Url Scheme。
    [[RCIM sharedRCIM] setScheme:@"RedPacketEQDLXS" forExtensionModule:@"JrmfPacketManager"];
    
    //设置会话列表头像和会话页面头像
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
    
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    //    [RCIM sharedRCIM].portraitImageViewCornerRadius = 10;
    //开启用户信息和群组信息的持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    //    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    
    //注册自定义的消息
    [[RCIM sharedRCIM] registerMessageType:[FBGeRenCardMessageContent class]];
    [[RCIM sharedRCIM] registerMessageType:[FBShareMessageContent class]];
    //开启发送已读回执
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList = @[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP)];
    
    //开启多端未读状态同步
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    //群成员数据源
    
    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    
    
    //  设置头像为圆形
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    //   设置优先使用WebView打开URL
    [RCIM sharedRCIM].embeddedWebViewPreferred = YES;
    
    
    //  设置通话视频分辨率
         [[RCCallClient sharedRCCallClient] setVideoProfile:RC_VIDEO_PROFILE_480P];
    
    //设置Log级别，开发阶段打印详细log
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
    
    if (iOS10_1Later) {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            NSLog(@"注册通知成功");
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                NSLog(@"%@", settings);
            }];
        } else {
            //点击不允许
            NSLog(@"注册通知失败");
        }
    }];
    
    }else
    {
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        
        
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    }
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    user = [WebRequest GetUserInfo];
    if(user)
    {
        [WebRequest user_enterWithu1:user.uname u2:[USERDEFAULTS objectForKey:Y_MIMA] And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==200)
            {
                NSDictionary *items =dic[Y_ITEMS];
                [USERDEFAULTS setObject:items forKey:Y_USERINFO];
                [USERDEFAULTS synchronize];
            }else
            {
                EQDLoginViewController *login =[[EQDLoginViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
                self.window.rootViewController = nav;
            }
            
        }];
    }
    else
    {
        
    }
    
    /*****/
    if (![USERDEFAULTS boolForKey:Y_first_Start]) {
        
        StartViewController  *Svc =[[StartViewController alloc]init];
        self.window.rootViewController =Svc;
        
        
    }
    
    else
    {
        if (user.Guid==nil) {
            EQDLoginViewController *login =[[EQDLoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
            self.window.rootViewController = nav;
           
        }
        else
        {
 
    FBTabBarViewController *tabBar =[[FBTabBarViewController alloc]init];
              self.window.rootViewController = tabBar;
        
        }
    
    }
 
    //配置崩溃日志
//    [self setupBugly];
//     [self setProductImgage];
    return YES;
    
}


-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSLog(@"3333334");
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置

    // 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
//    completionHandler(UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"易企点打卡提醒" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.window.rootViewController presentViewController:alert animated:NO completion:nil];

    });
    
    
    completionHandler();
}

- (void)setupBugly {
    // Get the default config
    BuglyConfig * config = [[BuglyConfig alloc] init];
    
    // Open the debug mode to print the sdk log message.
    // Default value is NO, please DISABLE it in your RELEASE version.
    //#if DEBUG
    config.debugMode = YES;
    //#endif
    
    // Open the customized log record and report, BuglyLogLevelWarn will report Warn, Error log message.
    // Default value is BuglyLogLevelSilent that means DISABLE it.
    // You could change the value according to you need.
    //    config.reportLogLevel = BuglyLogLevelWarn;
    
    // Open the STUCK scene data in MAIN thread record and report.
    // Default value is NO
    config.blockMonitorEnable = YES;
    
    // Set the STUCK THRESHOLD time, when STUCK time > THRESHOLD it will record an event and report data when the app launched next time.
    // Default value is 3.5 second.
    config.blockMonitorTimeout = 1.5;
    
    // Set the app channel to deployment
    config.channel = @"Bugly";
    
    config.delegate = self;
    
    config.consolelogEnable = NO;
    config.viewControllerTrackingEnable = NO;
    
    // NOTE:Required
    // Start the Bugly sdk with APP_ID and your config
    [Bugly startWithAppId:BUGLY_APP_ID
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    
    // Set the customizd tag thats config in your APP registerd on the  bugly.qq.com
    // [Bugly setTag:1799];
    
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    
}

#pragma mark - BuglyDelegate
- (NSString *)attachmentForException:(NSException *)exception {
    NSLog(@"(%@:%d) %s %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__,exception);
    
    return @"This is an attachment";
}
//极光推送的自定义消息
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSLog(@"==自定义消息===%@",content);
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    
    NSString *customizeField1 = [extras valueForKey:@"type"]; //服务端传递的Extras附加字段，key是自己定义的  根据type不同做不同的逻辑处理
    /*
     100：请假  110：出差，103：外出，104：加班，105：调休，120：调班，.。。。。。。130：离职申请  140：责任人收到的任务 141：协助人，知会人收到的任务 142：验收人收到的验收任务  150入驻邀请 151入驻审批，160:劳动合同，  200：添加好友 ,201:同意  公告：210 ，通知：220  联络书230  240:调休 250：加班 260：消迟到早退，270 ：人力需求申请  360 好友评论
     */
   /* if(customizeField1)
    {
    NSMutableArray *arr_type =[NSMutableArray arrayWithArray:[USERDEFAULTS  objectForKey:Y_type]];
    [arr_type addObject:customizeField1];
    [USERDEFAULTS setObject:arr_type forKey:Y_type];
    [USERDEFAULTS synchronize];
    }*/
    [[NSNotificationCenter defaultCenter]  postNotificationName:@"FB_message_received" object:nil];
    if([customizeField1 isEqualToString:@"152"]||[customizeField1 isEqualToString:@"302"]||[customizeField1 isEqualToString:@"310"] || [customizeField1 isEqualToString:@"381"])
    {
        user =[WebRequest GetUserInfo];
        if(user)
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
            [WebRequest user_enterWithu1:user.uname u2:[USERDEFAULTS objectForKey:Y_MIMA] And:^(NSDictionary *dic) {
                if([dic[Y_STATUS] integerValue]==200)
                {
                    NSDictionary *items =dic[Y_ITEMS];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [USERDEFAULTS setObject:items forKey:Y_USERINFO];
                        [USERDEFAULTS synchronize];
                    });
                   
                }else
                {
                    EQDLoginViewController *login =[[EQDLoginViewController alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
                    self.window.rootViewController = nav;
                }
                
            }];
            });
        }
        else
        {
            
        }
    }
    NSLog(@"=附加字段==%@",customizeField1);
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // userInfo为远程推送的内容
    NSLog(@"融云的远程推送===%@",userInfo);
    
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
    
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
        
    }
    completionHandler(UIBackgroundFetchResultNewData);
}
//本地通知
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}
/*
-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
{
     if (![notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    // 本地通知为notification
     
         
     }
}
-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    // if (![response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    // 本地通知为response.notification
    // }
}
*/
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        ///收到入职审批的时候要要重新登录一次
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);

    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif


//注册用户通知设置

- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
     [JPUSHService registerDeviceToken:deviceToken];
    NSString *token = [deviceToken description];
    token = [token stringByReplacingOccurrencesOfString:@"<"
                                             withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">"
                                             withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" "
                                             withString:@""];

    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [[RCIMClient sharedRCIMClient] setDeviceToken:token];
       
    });
   


}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    RCConnectionStatus status = [[RCIMClient sharedRCIMClient] getConnectionStatus];
    if (status != ConnectionStatus_SignUp) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient]
                              getUnreadCount:@[
                                               @(ConversationType_PRIVATE),
                                               @(ConversationType_DISCUSSION),
                                               @(ConversationType_APPSERVICE),
                                               @(ConversationType_PUBLICSERVICE),
                                               @(ConversationType_GROUP)
                                               ]];
        application.applicationIconBadgeNumber = unreadMsgCount;
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    }
}
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT|| status == ConnectionStatus_TOKEN_INCORRECT) {
        NSLog(@"被迫下线");
        [USERDEFAULTS removeObjectForKey:Y_USERINFO];
        [USERDEFAULTS removeObjectForKey:RC_TOKEN];
        [USERDEFAULTS removeObjectForKey:Y_MIMA];
        [USERDEFAULTS setBool:YES forKey:Y_quit];
        [USERDEFAULTS synchronize];
        [[RCIM sharedRCIM] logout];
        
        EQDLoginViewController *login =[[EQDLoginViewController alloc]init];
        UINavigationController  *nav = [[UINavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController =nav;
        [self quiteLogin];
        
    }else if ((status ==ConnectionStatus_UNKNOWN &&temp==0) || status == ConnectionStatus_Unconnected )
    {
        [self quiteLogin];
        temp=1;
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"网络变化" message:@"您似乎与网络断开了,连接网络后请手动刷新" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.window.rootViewController presentViewController:alert animated:NO completion:nil];

        });
    }else if (status ==ConnectionStatus_Connected )
    {
        temp=0;
    }else
    {
        
    }
}
///退出登录
-(void)quiteLogin{
    NSString  *loginedId =[NSString stringWithFormat:@"%@",[USERDEFAULTS objectForKey:Y_LoginedId]] ;
    NSDate *date = [NSDate date];
    NSDateFormatter  *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString  *time = [formatter stringFromDate:date];
    user = [WebRequest GetUserInfo];
  
    if (loginedId.length !=0) {
        [USERDEFAULTS setObject:time forKey:Y_quitTime];
        [USERDEFAULTS synchronize];
        
       /* [WebRequest userashx_LoginLog_Set_QuitLogsWithuserGuid:user.Guid logId:loginedId time:time  And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                [USERDEFAULTS removeObjectForKey:Y_LoginedId];
                [USERDEFAULTS synchronize];
            }else
            {
                [USERDEFAULTS setObject:time forKey:Y_quitTime];
                [USERDEFAULTS synchronize];
            }
        }];*/
    }
    
}

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].applicationIconBadgeNumber =
        left;
    });
   
   
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    NSNumber *left = [notification.userInfo objectForKey:@"left"];
   
    if ([RCIMClient sharedRCIMClient].sdkRunningMode ==
        RCSDKRunningMode_Background &&
        0 == left.integerValue) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                             @(ConversationType_PRIVATE),
                                                                             @(ConversationType_DISCUSSION),
                                                                             @(ConversationType_APPSERVICE),
                                                                             @(ConversationType_PUBLICSERVICE),
                                                                             @(ConversationType_GROUP)
                                                                             ]];
        [UIApplication sharedApplication].applicationIconBadgeNumber =
        unreadMsgCount;

    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //极光推送
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //极光推送
    [application setApplicationIconBadgeNumber:0];
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}



- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
//    [NSPropertyListSerialization propertyListFromData:tempData
//                                     mutabilityOption:NSPropertyListImmutable
//                                               format:NULL
//                                     errorDescription:NULL];
    [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return str;
}


/*- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    NSLog(@"url  %@",[url absoluteString]);
    
    if ([[url absoluteString] containsString:@"file"]) {
        NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
        NSString *fileName = [array lastObject];
        fileName = [fileName stringByRemovingPercentEncoding];
        
        NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/Inbox/%@",fileName]];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
    }
    return YES;
}
*/
/*
///分享逻辑
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
    // 1.其他应用进来的唤醒
    //2.本应用分享后成功从其他应用回来的回调
    
    if (self.window) {
                if (url) {
                        NSString *fileNameStr = [url lastPathComponent];
                      NSString *Doc = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/localFile"] stringByAppendingPathComponent:fileNameStr];
                       NSData *data = [NSData dataWithContentsOfURL:url];
                       [data writeToFile:Doc atomically:YES];
                    
                    
                    RCFileMessage  *FileMessage = [RCFileMessage messageWithFile:Doc];
                    
                    FBShareViewController *Svc =[[FBShareViewController alloc]init];
                    Svc.messageContent = FileMessage;
                    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:Svc];
                    
                    [self.window.rootViewController  presentViewController:nav animated:NO completion:nil];

            
                     }
           }
    
    
    
    
    return YES;
}

#else
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if ([[RCIM sharedRCIM] openExtensionModuleUrl:url]) {
        return YES;
    }
    else
    {
        // 1.其他应用进来的唤醒
        //url 本地手机的url路径
        //2.本应用分享后成功从其他应用回来的回调
        if (self.window) {
            if (url) {
                NSString *fileNameStr = [url lastPathComponent];
                NSString *Doc = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/localFile"] stringByAppendingPathComponent:fileNameStr];
                NSData *data = [NSData dataWithContentsOfURL:url];
                [data writeToFile:Doc atomically:YES];
                
                
                RCFileMessage  *FileMessage = [RCFileMessage messageWithFile:Doc];
                
                FBShareViewController *Svc =[[FBShareViewController alloc]init];
                Svc.messageContent = FileMessage;
                UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:Svc];
                
                [self.window.rootViewController  presentViewController:nav animated:NO completion:nil];
                
                
            }
        }
        
        
         return YES;
    }
   
    
    
   
}

#endif*/
///下面两个是融云红包设置
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if ([url.absoluteString containsString:@"eqdcomein://"]) {
        if (user.Guid==nil) {
            EQDLoginViewController *login =[[EQDLoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
            self.window.rootViewController = nav;
            
        }
        else
        {
            
            TKaoQinViewController *tabBar =[[TKaoQinViewController alloc]init];
            UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:tabBar];
            self.window.rootViewController = nav;
            
        }
    }else if ([[url absoluteString] containsString:@"file"]) {
        NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
        NSString *fileName = [array lastObject];
        fileName = [fileName stringByRemovingPercentEncoding];
        
        NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/Inbox/%@",fileName]];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
    }
    
    else
    {
    }
    
    if ([[RCIM sharedRCIM] openExtensionModuleUrl:url]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[RCIM sharedRCIM] openExtensionModuleUrl:url]) {
        return YES;
    }
    return YES;
}


@end
