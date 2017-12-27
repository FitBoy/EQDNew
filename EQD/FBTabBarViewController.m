//
//  FBTabBarViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTabBarViewController.h"
#import "WebRequest.h"
#import <JPUSHService.h>
#import <RongIMKit/RongIMKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "SDAdImageView.h"
#import "FBPeople.h"
@interface FBTabBarViewController ()
{
    UserModel *user;
    UINavigationController *nav1;
    AMapLocationManager *locationManager;
}

@end

@implementation FBTabBarViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    int unread_numm= [[RCIMClient sharedRCIMClient]getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
   
    if (unread_numm==0) {
        nav1.tabBarItem.badgeValue= nil;
    }
    else
    {
    nav1.tabBarItem.badgeValue= [NSString stringWithFormat:@"%d",unread_numm];
    }
    //    高德地图定位
    locationManager =[[AMapLocationManager alloc]init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    locationManager.reGeocodeTimeout = 10;
    [self dingwei];
    [self loadRequestData];
}
-(void)loadRequestData{
    [self  FBmeesage_received];
}
//高德地图定位
-(void)dingwei{
   
    [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        //地址   regeocode.formattedAddress  经纬度 location.coordinate
        NSString* jinwei =[NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
        NSString*  address =regeocode.formattedAddress;
        if(address.length==0)
        {
            [self dingwei];
        }else
        {
            NSArray  *tarr = @[regeocode.province,regeocode.city];
        [USERDEFAULTS setObject:jinwei forKey:Y_AMAP_coordation];
        [USERDEFAULTS setObject:address forKey:Y_AMAP_address];
            [USERDEFAULTS setObject:tarr forKey:Y_AMAP_cityProvince];
        [USERDEFAULTS synchronize];
        }
        
    }];
}
-(void)FBmeesage_received
{
    ///针对消息机制的处理

    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSArray *tarr = dic[Y_ITEMS];
             NSInteger  code_two=0,code_three=0,code_four=0,code_five=0;
            for (int i=0; i<tarr.count; i++) {
                NSDictionary  *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==200) {
                    //通讯录
                    code_two= code_two+[dic2[@"count"] integerValue];
                }else if ([dic2[@"code"] integerValue]==210 ||[dic2[@"code"] integerValue]==220)
                {
                    //发现
                    code_four = code_four +[dic2[@"count"] integerValue];
                }else if ([dic2[@"code"] integerValue]==211||[dic2[@"code"] integerValue]==100||[dic2[@"code"] integerValue]==102||[dic2[@"code"] integerValue]==110||[dic2[@"code"] integerValue]==112||[dic2[@"code"] integerValue]==140||[dic2[@"code"] integerValue]==141||[dic2[@"code"] integerValue]==142||[dic2[@"code"] integerValue]==143||[dic2[@"code"] integerValue]==120||[dic2[@"code"] integerValue]==122||[dic2[@"code"] integerValue]==250||[dic2[@"code"] integerValue]==252||[dic2[@"code"] integerValue]==240||[dic2[@"code"] integerValue]==242||[dic2[@"code"] integerValue]==260||[dic2[@"code"] integerValue]==280||[dic2[@"code"] integerValue]==262||[dic2[@"code"] integerValue]==282||[dic2[@"code"] integerValue]==231||[dic2[@"code"] integerValue]==230||[dic2[@"code"] integerValue]==232||[dic2[@"code"] integerValue]==160||[dic2[@"code"] integerValue]==162||[dic2[@"code"] integerValue]==150||[dic2[@"code"] integerValue]==300||[dic2[@"code"] integerValue]==300||[dic2[@"code"] integerValue]==302||[dic2[@"code"] integerValue]==221 ||[dic2[@"code"] integerValue]==211)
                {
                    //我的
                    code_five = code_five +[dic2[@"count"] integerValue];
                }else if ( [dic2[@"code"] integerValue]==101||[dic2[@"code"] integerValue]==111||[dic2[@"code"] integerValue]==121||[dic2[@"code"] integerValue]==251||[dic2[@"code"] integerValue]==241||[dic2[@"code"] integerValue]==261||[dic2[@"code"] integerValue]==281||[dic2[@"code"] integerValue]==161||[dic2[@"code"] integerValue]==151||[dic2[@"code"] integerValue]==301)
                {
                    //人事
                    code_three = code_three+[dic2[@"count"] integerValue];
                }else
                {
                }
            }
            
            //通讯录
            FBTwoViewController  *tvc =self.viewControllers[1];
            FBThreeViewController  *three = self.viewControllers[2];
            FBFourViewController  *fourvc =self.viewControllers[3];
            FBFiveViewController  *fivevc =self.viewControllers[4];
            dispatch_async(dispatch_get_main_queue(), ^{
                tvc.tabBarItem.badgeValue=[self changeWithnumber:code_two];
                three.tabBarItem.badgeValue = [self changeWithnumber:code_three];
                fourvc.tabBarItem.badgeValue = [self changeWithnumber:code_four];
                fivevc.tabBarItem.badgeValue = [self changeWithnumber:code_five];
            });
            
        }
           
    }];
   
  
}

-(NSString*)changeWithnumber:(NSInteger)number
{
    return number==0?nil:[NSString stringWithFormat:@"%ld",number];
}

-(void)getProductData
{
    
    [WebRequest  Extended_Get_adImageAnd:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            NSDictionary *dic = @{SDAdImageUrl:dic2[@"url"],SDAdDestUrl:dic2[@"toUrl"]};
            [SDLaunchImageTool saveAdInfo:dic];
        }
    }];
    

    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
     user =[WebRequest GetUserInfo];
  
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(FBmeesage_received) name:@"FB_message_received" object:nil];
   
    
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    NSString  *token1 = [USERDEFAULTS objectForKey:RC_TOKEN];
    if (token1) {
        [self connectRCWithToken:token1];
    }
    else
    {
        RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:user.Guid name:user.upname portrait:user.iphoto];
        [self loginRCWithuserifo:userinfo];
    
    }
    
   
    
    [self initViewControllers];
    [self  getProductData];
    
}

-(void)initViewControllers
{
    
   FBOneViewController *onevc =[[FBOneViewController alloc]init];
    nav1 =[[UINavigationController alloc]initWithRootViewController:onevc];
    UIImage  *image1 =[[UIImage imageNamed:@"xiaoxi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage1 =[[UIImage imageNamed:@"xiaoxi_focu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    onevc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:image1 selectedImage:selectedImage1];
    NSMutableArray *arr_type =[NSMutableArray arrayWithArray:[USERDEFAULTS objectForKey:Y_type]];
    
    FBTwoViewController  *twovc =[[FBTwoViewController alloc]init];
    UINavigationController *nav2 =[[UINavigationController alloc]initWithRootViewController:twovc];
    twovc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"通讯录" image:[[UIImage imageNamed:@"tongxunlu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tongxunlu_focu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    if ([arr_type containsObject:@"200"]) {
        twovc.tabBarItem.badgeValue=@"1";
    }else
    {
        twovc.tabBarItem.badgeValue=nil;
 
    }
    
    FBThreeViewController *threevc =[[FBThreeViewController alloc]init];
    UINavigationController *nav3 =[[UINavigationController alloc]initWithRootViewController:threevc];
    threevc.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"功能" image:[[UIImage imageNamed:@"add_focus"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    FBFourViewController *fourvc =[[FBFourViewController alloc]init];
    UINavigationController *nav4 =[[UINavigationController alloc]initWithRootViewController:fourvc];
    fourvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:[[UIImage imageNamed:@"faxian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"faxian_focu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    if ([arr_type containsObject:@"201"] || [arr_type containsObject:@"210"]) {
        fourvc.tabBarItem.badgeValue=@"1";
    }else
    {
        fourvc.tabBarItem.badgeValue=nil;
    }
    
    FBFiveViewController *fivevc =[[FBFiveViewController alloc]init];
    UINavigationController *nav5 =[[UINavigationController alloc]initWithRootViewController:fivevc];
    fivevc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"me_focu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
   self.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    self.selectedIndex=2;
}


-(void)loginRCWithuserifo:(RCUserInfo*)userinfo{
    
    [WebRequest User_RyHttpClientWithuserId:userinfo.userId name:userinfo.name portraitUri:userinfo.portraitUri And:^(NSDictionary *dic) {
        NSNumber *number = dic[@"code"];
        if ([number integerValue]==200) {
            NSString *token = dic[@"token"];
            [USERDEFAULTS setObject:token forKey:RC_TOKEN];
            [USERDEFAULTS synchronize];
            [self connectRCWithToken:token];
        }
        else
        {
            RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:user.Guid name:user.upname portrait:user.iphoto];
            [self loginRCWithuserifo:userinfo];
        }

    }];
    
  
}

-(void)connectRCWithToken:(NSString*)token2{

  UserModel *user = [WebRequest GetUserInfo];
    [[RCIM sharedRCIM] connectWithToken:token2 success:^(NSString *userId) {
        NSLog(@"登录的userid===%@",userId);
                RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:userId name:user.upname portrait:user.iphoto];
        [RCIM sharedRCIM].enableMessageAttachUserInfo=YES;
        [RCIM sharedRCIM].currentUserInfo=userinfo;
        [RCIM sharedRCIM].globalConversationAvatarStyle=RC_USER_AVATAR_CYCLE;
        [RCIM sharedRCIM].globalMessageAvatarStyle=RC_USER_AVATAR_CYCLE;
        [RCIM sharedRCIM].enableMessageAttachUserInfo=YES;
        
    } error:^(RCConnectErrorCode status) {
          RCUserInfo  *userinfo =[[RCUserInfo alloc]initWithUserId:user.Guid name:user.upname portrait:user.iphoto];
        [self loginRCWithuserifo:userinfo];
        
    } tokenIncorrect:^{
        
    }];
 
}


- (void)networkDidLogin:(NSNotification *)notification {
  
    
        
    [JPUSHService setAlias:user.Guid completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"iResCode==%ld=iAlias==%@seq==%ld",(long)iResCode,iAlias,(long)seq);
    } seq:2017];
    
    if([user.companyId integerValue]!=0)
    {
        [JPUSHService setTags:[NSSet setWithArray:@[[NSString stringWithFormat:@"%@_0",user.companyId],[NSString stringWithFormat:@"%@_%@",user.companyId,user.departId]]] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            NSLog(@"tag值的设定iResCode==%ld=iTags===%@",(long)iResCode,iTags);
        } seq:2017];
    }
}


@end
