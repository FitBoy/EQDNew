//
//  FBSearchMapViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBSearchMapViewController.h"
#import <MapKit/MapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
@interface FBSearchMapViewController ()<MAMapViewDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>
{
    MAMapView *mapView1;
    UITableView *tableV;
    AMapSearchAPI *search;
    NSMutableArray *arr_tips;
    UILabel *L_address;
    AMapLocationManager *locationManager;
    CLLocationCoordinate2D coor2d_jilu;
    
    
}

@end

@implementation FBSearchMapViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 开启定位
    mapView1.showsUserLocation = YES;
    mapView1.userTrackingMode = MAUserTrackingModeFollow;
    if (self.coor2d.latitude) {
        [self mapView:mapView1 didSingleTappedAtCoordinate:self.coor2d];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_tips =[NSMutableArray arrayWithCapacity:0];
    mapView1 = [[MAMapView alloc] initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40)];
    mapView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView1.zoomLevel=16;
    mapView1.scrollEnabled=YES;
    mapView1.zoomEnabled=YES;
    mapView1.delegate = self;
    mapView1.allowsBackgroundLocationUpdates=NO;
    mapView1.showsLabels =YES;
    [self.view addSubview:mapView1];
    self.navigationItem.title =@"位置";
    L_address = [[UILabel alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-40, DEVICE_WIDTH, 40)];
    L_address.numberOfLines=2;
    L_address.font =[UIFont systemFontOfSize:15];
    L_address.textAlignment= NSTextAlignmentCenter;
    [self.view addSubview:L_address];
    L_address.backgroundColor =[UIColor whiteColor];
    L_address.text = [USERDEFAULTS objectForKey:Y_AMAP_address];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"选定" style:UIBarButtonItemStylePlain target:self action:@selector(xuandingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.showsCancelButton =NO;
    searchBar.placeholder=@"搜索地址";
    search =[[AMapSearchAPI alloc]init];
    search.delegate =self;
     [self getOriginLocation];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.hidden=YES;
    NSString *str_jinwei =[USERDEFAULTS objectForKey:Y_AMAP_coordation];
    NSArray *tarr = [str_jinwei componentsSeparatedByString:@","];
    if (tarr.count==2) {
        coor2d_jilu =CLLocationCoordinate2DMake([tarr[0] floatValue], [tarr[1] floatValue]);
    }
    


}

-(void)getOriginLocation
{
    UIButton *tbn =[UIButton buttonWithType:UIButtonTypeSystem];
    tbn.frame =CGRectMake(DEVICE_WIDTH-45, 50, 40, 40);
    [tbn setBackgroundImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
    [tbn addTarget:self action:@selector(originClick) forControlEvents:UIControlEventTouchUpInside];
    [mapView1 addSubview:tbn];
}
-(void)originClick
{
    mapView1.showsUserLocation =YES;
    NSString *str_jinwei =[USERDEFAULTS objectForKey:Y_AMAP_coordation];
    NSArray *tarr = [str_jinwei componentsSeparatedByString:@","];
      [mapView1 setCenterCoordinate:CLLocationCoordinate2DMake([tarr[0] floatValue], [tarr[1] floatValue])];
   
}


-(void)xuandingClick
{
    //选定
    if ([self.delegate respondsToSelector:@selector(mapAddress:location:)]) {
        [self.delegate mapAddress:L_address.text location:coor2d_jilu];
    }
    [self.navigationController popViewControllerAnimated:NO];
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    tableV.hidden=YES;
    searchBar.showsCancelButton=NO;
    [self.view endEditing:YES];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length==0) {
        tableV.hidden=YES;
        searchBar.showsCancelButton=NO;
        return;
    }
    searchBar.showsCancelButton=YES;
    tableV.hidden = NO;
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = searchText;
    tips.city     = @"北京";
    //    tips.cityLimit = YES; 是否限制城市
    
    [search AMapInputTipsSearch:tips];

}
#pragma  mark - tip搜索结果
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [arr_tips removeAllObjects];
    if (response.count == 0)
    {
        [tableV reloadData];
        return;
    }
    
    for (int i=0; i<response.tips.count; i++) {
        AMapTip *tip = response.tips[i];
        if (tip.location!=nil) {
            [arr_tips addObject:tip];
        }
    }
    [tableV reloadData];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_tips.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image =[UIImage imageNamed:@"eqd_locate"];
    }
    AMapTip *tip = arr_tips[indexPath.row];
    
   

//        cell.imageView.image = [UIImage imageNamed:@"eqd_search"];
        cell.textLabel.text = tip.name;
        cell.detailTextLabel.text = tip.address;

    
   
    return cell;
}

#pragma  mark - 表的协议代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapTip *tip = arr_tips[indexPath.row];
    [self.view endEditing:YES];
    tableV.hidden=YES;
    [mapView1 removeAnnotations:mapView1.annotations];
    
//    AMapTipAnnotation *annotation = [[AMapTipAnnotation alloc] initWithMapTip:tip];
    MAPointAnnotation  *annotation = [[MAPointAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake(tip.location.latitude, tip.location.longitude);
    coor2d_jilu =CLLocationCoordinate2DMake(tip.location.latitude, tip.location.longitude);
    annotation.subtitle = tip.address;
    [mapView1 addAnnotation:annotation];
    [mapView1 setCenterCoordinate:annotation.coordinate];
    [mapView1 selectAnnotation:annotation animated:YES];
    L_address.text =[NSString stringWithFormat:@"%@%@-%@",tip.district,tip.address,tip.name];
//    AMapGeocodeSearchResponse

    
    
}

#pragma  mark - 地图的协议代理
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc]init];
        request.requireExtension=YES;
        request.location=[AMapGeoPoint locationWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
        coor2d_jilu =userLocation.location.coordinate;
        [search AMapReGoecodeSearch:request];
    });
}
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{
        mapView.showsUserLocation = NO;
  
}
///逆地理返回结果
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    
  L_address.text =response.regeocode.formattedAddress;
}
///长按操作
- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    coor2d_jilu =coordinate;
    [mapView1 removeAnnotations:mapView1.annotations];
    MAPointAnnotation  *annotation = [[MAPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    [mapView1 addAnnotation:annotation];
    [mapView1 selectAnnotation:annotation animated:YES];
    
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc]init];
    request.requireExtension=YES;
    request.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [search AMapReGoecodeSearch:request];
}
///单击回调
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    coor2d_jilu =coordinate;
    [mapView1 removeAnnotations:mapView1.annotations];
    MAPointAnnotation  *annotation = [[MAPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    [mapView1 addAnnotation:annotation];
    [mapView1 selectAnnotation:annotation animated:YES];
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc]init];
    request.requireExtension=YES;
    request.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [search AMapReGoecodeSearch:request];
}

@end
