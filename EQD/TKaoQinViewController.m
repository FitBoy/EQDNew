//
//  TKaoQinViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TKaoQinViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>
#import "FBWifiManager.h"
#import "MyUUIDManager.h"
#import "FBButton.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "KQDaKaView.h"

#import "FBDaKa_TableViewCell.h"
#import "DaKaJiLu.h"
#import "FBDaKa_RecordViewController.h"
#import "DLAddToDesktopHandler.h"
#import "UIImage+DLDataURIImage.h"
@interface TKaoQinViewController ()<UITableViewDelegate,UITableViewDataSource,FBDaKa_TableViewCellDelegate>
{
    UITableView *tableV;
    
    UserModel *user;
    KQDaKaView *DKV;
    NSMutableArray *arr_dakaJiLu;
    
    //手机别名
    NSString *phone_name;
    NSString *wifiname;
    NSString *macadress ;
    NSString *UUID;
    NSString *address;
    NSString *coodinate;
}

@end

@implementation TKaoQinViewController
#pragma  mark - delegate
-(void)clocktime:(NSString *)clocktime indexpath:(NSIndexPath *)indexPath clockid:(NSString *)clockID
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在更新打卡";
    if (address.length==0) {
        address =@"地址未知";
        coodinate=@"0.000000,0.000000";
    }
    [WebRequest Clocks_Update_ClockWithuserGuid:user.Guid clockTime:clocktime place:address MAC:macadress WIFIName:wifiname phoneUUID:UUID phoneType:phone_name coordinate:coodinate clockId:clockID And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
            [self loadRequestData];
        }
       
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
  
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    [WebRequest Clocks_Get_ClockWithuserGuid:user.Guid companyId:user.companyId  date:date  And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            if([dic[Y_ITEMS] isEqual:[NSNull null]])
            {
                
            }else
            {
                NSArray *tarr =dic[Y_ITEMS];
                [arr_dakaJiLu removeAllObjects];
                if (tarr.count) {
                    for (int i=0; i<tarr.count; i++) {
                        DaKaJiLu *model =[DaKaJiLu mj_objectWithKeyValues:tarr[i]];
                        [arr_dakaJiLu addObject:model];
                    }
                    
                }
                [tableV.mj_header endRefreshing];
                [tableV reloadData];
            }
        }
       
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_dakaJiLu =[NSMutableArray arrayWithCapacity:0];
    
    self.navigationItem.title = @"打卡";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"打卡记录" style:UIBarButtonItemStylePlain target:self action:@selector(jiluClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    DKV = [[KQDaKaView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 75)];
    [self.view addSubview:DKV];
    [WebRequest Get_User_ShiftWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *dic2 =dic[Y_ITEMS];
            NSString *weeks =dic2[@"weeks"];
            CalendarModel *model =[[CalendarModel alloc]initWithDate:[NSDate date]];
            [DKV setModel:model Withweeks:weeks];
        }
       
    }];
    
  
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 140-64+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-140+64-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=70;
//    tableV.contentInset =UIEdgeInsetsMake(15, 0, 0, 0);
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    
    //手机别名
    phone_name =[[UIDevice currentDevice] name];
   NSArray *tarr =[FBWifiManager getWifiName];
    if (tarr.count==2) {
        wifiname =tarr[0];
        macadress =tarr[1];
    }else
    {
        wifiname =@"未知";
        macadress =@"未知";
    }
    
   UUID=[MyUUIDManager getUUID];
    address =[USERDEFAULTS objectForKey:Y_AMAP_address];
    coodinate =[USERDEFAULTS objectForKey:Y_AMAP_coordation];
    
    BOOL  isShowBtn =[USERDEFAULTS boolForKey:@"eqdcomein"];
    if (isShowBtn==NO) {
       
        FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn setTitle:@"将本页面添加到主屏幕" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:24]];
        
        [self.view addSubview:tbtn];
        tbtn.frame =CGRectMake(0, DEVICE_HEIGHT-40, DEVICE_WIDTH, 40);
        [tbtn addTarget:self action:@selector(tiajianMainClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else
    {
        
    }
    if(self.ismain==1)
    {
    }else
    {
    UIBarButtonItem *left =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(mainJiemian)];
    [self.navigationItem setLeftBarButtonItem:left];
    }
    
}


-(void)tiajianMainClick
{
//    NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES};
    DLAddToDesktopHandler *handler = [DLAddToDesktopHandler sharedInsance];
    NSString *imageString = [[UIImage imageNamed:@"eqddaka2"] dataURISchemeImage];
    [handler addToDesktopWithDataURISchemeImage:imageString
                                          title:@"考勤打卡"
                                      urlScheme:@"EQDComeIn://"
                                 appDownloadUrl:@"https://www.eqidd.com"];
    [USERDEFAULTS setBool:YES forKey:@"eqdcomein"];
    [USERDEFAULTS synchronize];
}

-(void)jiluClick
{
    //打卡记录
    FBDaKa_RecordViewController *Rvc =[[FBDaKa_RecordViewController alloc]init];
    [self.navigationController pushViewController:Rvc animated:NO];
    
}

#pragma  mark - 表的数据源


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_dakaJiLu.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBDaKa_TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBDaKa_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    cell.indexPath =indexPath;
    cell.delegate =self;
    cell.B_right.indexpath =indexPath;
    [cell.B_right addTarget:self action:@selector(dakaCLick_cell:) forControlEvents:UIControlEventTouchUpInside];
    DaKaJiLu *model =arr_dakaJiLu[indexPath.row];
    [cell setModel:model];
    
    return cell;
}
-(void)dakaCLick_cell:(FBButton*)tbtn
{
    
    DaKaJiLu *model =arr_dakaJiLu[tbtn.indexpath.row];
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"禁止打卡" message:@"您拒绝了手机定位，请前往设置->隐私->定位修改权限" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES};
                [[UIApplication sharedApplication] openURL:url options:options completionHandler:nil];
            }
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
    }
    else
    {
        //打卡
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在打卡";
        
            [WebRequest Clocks_Add_ClockWithuserGuid:user.Guid companyId:user.companyId clockTime:model.clockTime place:address MAC:macadress WIFIName:wifiname phoneUUID:UUID phoneType:phone_name coordinate:coodinate type:model.type And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self loadRequestData];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
            }];
        
        
        
        
        

    }
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
}




@end
