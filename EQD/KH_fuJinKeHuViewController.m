//
//  KH_fuJinKeHuViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "KH_fuJinKeHuViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "NearbyModel.h"
#import "FByylabel_btnOnerightTableViewCell.h"
#import <Masonry.h>
#import <MapKit/MapKit.h>

@interface KH_fuJinKeHuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    AMapLocationManager *locationManager;
    NSString *address;
    NSString* jinwei;
    UserModel *user;
    MBProgressHUD *hud ;
}

@end

@implementation KH_fuJinKeHuViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
  
}
-(void)loadRequestData{
    
    [WebRequest crmModule_customer_Get_NearbyCustomerWithuserGuid:user.Guid address:address coordinate:jinwei page:@"0" And:^(NSDictionary *dic) {
        [hud hideAnimated:NO];
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model  removeAllObjects];
            page =dic[@"page"];
            for(int i=0;i<tarr.count;i++)
            {
                NearbyModel *model = [NearbyModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData{
    [WebRequest crmModule_customer_Get_NearbyCustomerWithuserGuid:user.Guid address:address coordinate:jinwei page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page =dic[@"page"];
            for(int i=0;i<tarr.count;i++)
            {
                NearbyModel *model = [NearbyModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"附近的客户";
    page = @"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
//    tableV.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    //    高德地图定位
    locationManager =[[AMapLocationManager alloc]init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    locationManager.reGeocodeTimeout = 10;
    [self dingwei];

}

//高德地图定位
-(void)dingwei{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在定位 需等5秒左右";
    [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        //地址   regeocode.formattedAddress  经纬度 location.coordinate
        jinwei =[NSString stringWithFormat:@"%f,%f",location.coordinate.longitude,location.coordinate.latitude];
      address =regeocode.formattedAddress;
        
        if(address.length==0 )
        {
            [hud hideAnimated:NO];
            UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"您拒绝了位置访问权限" message:@"请到 设置-隐私-定位服务-易企点 修改位置权限" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:NO];
            }]];
            
            [self presentViewController:alert animated:NO completion:nil];
            
        }else
        {
            NSArray  *tarr = @[regeocode.province,regeocode.city,regeocode.district];
            [USERDEFAULTS setObject:jinwei forKey:Y_AMAP_coordation];
            [USERDEFAULTS setObject:address forKey:Y_AMAP_address];
            [USERDEFAULTS setObject:tarr forKey:Y_AMAP_cityProvince];
            [USERDEFAULTS synchronize];
            dispatch_async(dispatch_get_main_queue(), ^{
               [self loadRequestData];
            });
          
        }
        
    }];
}

#pragma  mark - 表的数据源

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearbyModel  *model = arr_model[indexPath.row];
    return model.cell_height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FByylabel_btnOnerightTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FByylabel_btnOnerightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NearbyModel  *model = arr_model[indexPath.row];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.customer] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:3]}];
    
    NSMutableAttributedString  *address = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.address] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:address];
    name.yy_lineSpacing =6;
    cell.yy_label.attributedText = name;
    
    [cell.btn_right setTitle:[NSString stringWithFormat:@"%@km",model.distance] titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
    [cell.btn_right mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 30));
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(cell.mas_centerY);
    }];
    cell.btn_right.layer.borderWidth=0;
    cell.btn_right.layer.borderColor = [UIColor whiteColor].CGColor;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30-105, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cell_height = size.height+20;
    
    [cell.yy_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+15);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.btn_right.mas_left).mas_offset(-5);
    }];
    
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearbyModel  *model = arr_model[indexPath.row];
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"联系客户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.cusCall];
        UIWebView *callWebView = [[UIWebView alloc] init];
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebView];
    }]];
    
    NSArray *tarr = [model.latAndLong componentsSeparatedByString:@","];
    if (tarr.count==2) {
    [alert addAction:[UIAlertAction actionWithTitle:@"到客户那去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
      
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([tarr[0] floatValue],[tarr[1] floatValue]);
        UIAlertController *alert1 = [[UIAlertController alloc]init];
        NSURL * apple_App = [NSURL URLWithString:@"http://maps.apple.com/"];
        
        if ([[UIApplication sharedApplication] canOpenURL:apple_App]) {
            [alert1 addAction:[UIAlertAction actionWithTitle:@"使用苹果自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //当前位置
                MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
                //传入目的地，会显示在苹果自带地图上面目的地一栏
                toLocation.name = model.address;
                //导航方式选择walking
                [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                               launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
                
            }]];
        }
        
        NSURL * gaode_App = [NSURL URLWithString:@"iosamap://"];
        if ([[UIApplication sharedApplication] canOpenURL:gaode_App]) {
            
            [alert1 addAction:[UIAlertAction actionWithTitle:@"使用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",@"易企点",coordinate.latitude,coordinate.longitude,model.address] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                NSLog(@"%@",urlString);
                
                //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
                    if(!success)
                    {
                        MBFadeAlertView *alertB =[[MBFadeAlertView alloc]init];
                        [alertB showAlertWith:@"未知错误"];
                    }
                }];
                
                
            }]];
        }
        
        NSURL * baidu_App = [NSURL URLWithString:@"baidumap://"];
        if ([[UIApplication sharedApplication] canOpenURL:baidu_App]) {
            
            [alert1 addAction:[UIAlertAction actionWithTitle:@"使用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                
                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name:%@&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude,model.address] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                NSLog(@"%@",urlString);
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
                    if(!success)
                    {
                        MBFadeAlertView *alertB =[[MBFadeAlertView alloc]init];
                        [alertB showAlertWith:@"未知错误"];
                    }
                }];
                
                
            }]];
        }
        
        [alert1 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert1 animated:NO completion:nil];
        });
        
    }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
   
   
}




@end
