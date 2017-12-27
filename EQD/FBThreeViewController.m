//
//  FBThreeViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define Image_height  150
#import "FBThreeViewController.h"
#import "FBScrollView.h"
#import "TFAQViewController.h"
#import "GNBLCollectionViewCell.h"
#import "ThreeRenShiViewController.h"
#import "TKeHuGuanLiViewController.h"
#import "TKaoQinViewController.h"
#import "NSString+FBString.h"
#import "Com_ImgModel.h"
#import "FBindexTapGestureRecognizer.h"
#import "FBWebUrlViewController.h"
#import <UIImageView+WebCache.h>
#import "CarManagerViewController.h"
#import "RePairRecord_ViewController.h"
#import <StoreKit/StoreKit.h>
#import "EQDR_AppVicontroller.h"

@interface FBThreeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SKStoreProductViewControllerDelegate>
{
     
    FBScrollView *scrollView;
    UICollectionView *CollectionV;
    NSMutableArray *arr_img_name;
    NSMutableArray *arr_model;
    NSMutableArray *arr_url;
    dispatch_source_t  timer1;
    UserModel *user;
    NSArray *arr_title;
}

@end

@implementation FBThreeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [self loadRequestData];
      [self message_recieved];
    [self getLastedVersion];
}
-(void)getLastedVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //检测版本
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [WebRequest Extended_Get_VersionInfoWithtype:@"iOS" version:appCurVersion And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==300)
        {
         
        }else if ([dic[Y_STATUS] integerValue]==200)
        {
            NSDictionary *dic2 =dic[Y_ITEMS];
            UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"新版本" message:dic2[@"remark"] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
                //设置代理请求为当前控制器本身
                storeProductViewContorller.delegate = self;
                //加载一个新的视图展示
                [storeProductViewContorller loadProductWithParameters:
                 //appId唯一的
                 @{SKStoreProductParameterITunesItemIdentifier : @"1313172913"} completionBlock:^(BOOL result, NSError *error) {
                     //block回调
                     if(error){
                         NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
                     }else{
                         //模态弹出appstore
                         [self presentViewController:storeProductViewContorller animated:YES completion:^{
                             
                         }
                          ];
                     }
                 }];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self.navigationController presentViewController:alert animated:NO completion:nil];
            
        }else
        {
           
        }
        
    }];

}

//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)loadRequestData{
    
    [WebRequest EQDimages_Get_EQDimageAnd:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        [arr_url removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            Com_ImgModel *model =[Com_ImgModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
            [arr_url addObject:model.imageUrl];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [scrollView setArr_urls:arr_url];
            //定时循环执行事件
            __block int total =0;
            timer1 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
            dispatch_source_set_timer(timer1, DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
            dispatch_source_set_event_handler(timer1, ^{
                if (timer1) {
                    [scrollView.scrollV setContentOffset:CGPointMake(scrollView.frame.size.width*total, 0) animated:YES];
                    scrollView.pageControl.currentPage=total;
                    total++;
                    if (total==arr_url.count) {
                        total=0;
                    }
                }else
                {
                    dispatch_source_cancel(timer1);
                }
            });
            dispatch_source_set_cancel_handler(timer1, ^{
                NSLog(@"Cancel Handler");
                dispatch_source_cancel(timer1);
            });
            dispatch_resume(timer1);
            
            for (int i=0; i<scrollView.arr_imageView.count; i++) {
                FBindexTapGestureRecognizer *tap =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
                FBIndexpathImageView  *tview =scrollView.arr_imageView[i];
                tap.index =tview.index;
                [tview addGestureRecognizer:tap];
            }
        });
    }];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (timer1) {
         dispatch_source_cancel(timer1);
    }
  
  
}

-(void)message_recieved
{
    [WebRequest userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            NSInteger  code_three=0;
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 =tarr[i];
                
                if ([dic2[@"code"] integerValue]==151||[dic2[@"code"] integerValue]==301||[dic2[@"code"] integerValue]==101||[dic2[@"code"] integerValue]==111||[dic2[@"code"] integerValue]==121||[dic2[@"code"] integerValue]==251||[dic2[@"code"] integerValue]==241||[dic2[@"code"] integerValue]==261||[dic2[@"code"] integerValue]==281||[dic2[@"code"] integerValue]==161) {
                    code_three = code_three+[dic2[@"count"] integerValue];
                }else
                {
                  
                }
            }
            
            GNmodel  *model= arr_img_name[0];
            if (model.biaoji==0) {
                model.number_red =[NSString stringWithFormat:@"%ld",code_three];
                self.tabBarItem.badgeValue=[self changeWithnumber:[model.number_red integerValue]];
            }else
            {
                self.tabBarItem.badgeValue=nil;
            }
            [CollectionV reloadData];
        }
    }];
}

-(void)tapClick:(FBindexTapGestureRecognizer*)tap
{
    Com_ImgModel *model =arr_model[tap.index];
    FBWebUrlViewController *Wvc =[[FBWebUrlViewController alloc]init];
    Wvc.url =model.Url;
    Wvc.contentTitle =model.title;
    Wvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:Wvc animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_title =@[@"基本功能"];
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    arr_url =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"易企点工业互联网平台";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(kuaijiefangshi)];
    [self.navigationItem setRightBarButtonItem:right];
   
    //滚动图
    scrollView =[[FBScrollView alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30, (DEVICE_WIDTH-30)/2.0)];
    scrollView.scrollV.pagingEnabled=YES;
    [self.view addSubview:scrollView];
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake(75, 75);
    flowL.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    flowL.minimumLineSpacing=10;
    flowL.minimumInteritemSpacing=10;
    flowL.headerReferenceSize = CGSizeMake(DEVICE_WIDTH, 20);
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, (DEVICE_WIDTH-30)/2.0+DEVICE_TABBAR_Height, DEVICE_WIDTH, CGRectGetMinY(self.tabBarController.tabBar.frame)-DEVICE_TABBAR_Height-(DEVICE_WIDTH-30)/2.0) collectionViewLayout:flowL];
    adjustsScrollViewInsets_NO(CollectionV, self);
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    CollectionV.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:CollectionV];
    
    [CollectionV registerClass:[GNBLCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [CollectionV registerClass:[GNBLCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewCell"];
     arr_img_name =[NSMutableArray arrayWithCapacity:0];
    NSMutableArray *tarr =[NSMutableArray arrayWithArray:@[@"人事",@"客户管理",@"打卡",@"车辆管理",@"车辆维修",@"易企阅"]];//
    NSArray  *timgArr =@[@"renShi",@"kehuguanli",@"dak",@"renShi",@"renShi",@"renShi"];
    
    for (int i=0; i<tarr.count; i++) {
        GNmodel *model = [[GNmodel alloc]init];
        model.biaoji =i;
        model.name = tarr[i];
        model.img=timgArr[i];
         [arr_img_name addObject:model];
    }
    
    if([user.isAdmin integerValue]==0)
    {
        [arr_img_name  removeObjectAtIndex:0];
    }else
    {
    }
    
   //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recieved) name:Z_FB_message_received object:nil];
    
   
    
    
}
#pragma mark - collection 数据源与代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return arr_title.count;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
        
        headerView.backgroundColor = [UIColor whiteColor];
        
        //把想添加的控件放在session区头重用的cell里,并且回来赋值,防止重用(重点!!!!!)
        
        UILabel *ttLabel = (UILabel *)[headerView viewWithTag:111];
        if(!ttLabel)
        {
            ttLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, 20)];
            ttLabel.tag =111;
            ttLabel.font =[UIFont systemFontOfSize:13];
            [headerView addSubview:ttLabel];
            ttLabel.textColor = [UIColor grayColor];
        }
        
        
        ttLabel.text =arr_title[indexPath.section];
        
        reusableview = headerView;
        
    }
    return reusableview;
    
   
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return arr_img_name.count;
    }else
    {
        return 0;
    }
    
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GNBLCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    GNmodel *model =arr_img_name[indexPath.row];
    [cell setModel:model];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GNmodel *model =arr_img_name[indexPath.row];
    if(model.biaoji ==0)
    {
        //人事
        ThreeRenShiViewController *RSvc =[[ThreeRenShiViewController alloc]init];
        RSvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:RSvc animated:NO];
    }else if (model.biaoji==1)
    {
        //客户管理
        TKeHuGuanLiViewController *KHGvc =[[TKeHuGuanLiViewController alloc]init];
        KHGvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:KHGvc animated:NO];
    }else if (model.biaoji==2)
    {
        if(user.companyId==0)
        {
            
        }else
        {
        //打卡
            if([user.companyId integerValue]>0)
            {
        TKaoQinViewController *KQvc =[[TKaoQinViewController alloc]init];
                KQvc.ismain=1;
        KQvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:KQvc animated:NO];
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"未加入企业不能打卡";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
        }
    }else if (model.biaoji==3)
    {
        //车辆管理
        CarManagerViewController  *Mvc =[[CarManagerViewController alloc]init];
        Mvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Mvc animated:NO];
    }else if (model.biaoji==4)
    {
        //车辆保养/维修
        RePairRecord_ViewController  *Pvc =[[RePairRecord_ViewController alloc]init];
        CarManagerModel  *model = [[CarManagerModel alloc]init];
        model.Id =@"0";
        model.plateNumber=@"请选择";
        Pvc.model =model;
        Pvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if (model.biaoji==5)
    {
      
        EQDR_AppVicontroller  *Rvc =[[EQDR_AppVicontroller alloc]init];
        [self.navigationController presentViewController:Rvc animated:NO completion:nil];
    }
   else
    {
        
    }
    
}


@end
