//
//  keHuManagerViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/14.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "keHuManagerViewController.h"
#import "FBHeadScrollTitleView.h"
#import "KeHu_ListModel.h"
#import <YYText.h>
#import "FBWebUrlViewController.h"
#import <Masonry.h>
#import "ChanceSaleModel.h"
#import "GLRecodeModel.h"
#import "FanKuiRecordModel.h"
#import "GLLianXiModel.h"
#import "FBButton.h"
#import "CAddViewController.h"
#import "LXRAddViewController.h"
#import "RAddViewController.h"
#import "FKAddViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "FBThree_noimg112TableViewCell.h"
#import "FBindexTapGestureRecognizer.h"
#import "GLChance_DetailViewController.h"
#import "GLRecord_detailViewController.h"
#import "FKDetailViewController.h"
#import "GLLianXI_DetailViewController.h"
#import "KHDetailViewController.h"
#import <MapKit/MapKit.h>
@interface keHuManagerViewController ()<UITableViewDelegate,UITableViewDataSource,FBHeadScrollTitleViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model0;
    NSMutableArray *arr_model1;
    NSMutableArray *arr_model2;
    NSMutableArray *arr_model3;
    
    NSString *page0;
    NSString *page1;
    NSString *page2;
    NSString *page3;
    
    NSInteger temp;
    UserModel *user;
    KeHu_ListModel  *model_detail;
    YYLabel *yy_label_head;
    UIView *V_head;
    FBHeadScrollTitleView  *titleV ;
    UIView *V_secion;
    FBButton *btn_title;
    NSArray *arr_titles;
    
    
    ///选择框
    UITableView *tableV_selecte;
    NSArray *arr_names;
}

@end

@implementation keHuManagerViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
  
    if (temp ==0) {
        ///销售机会
        [WebRequest crmModule_Get_saleschancelistWithowner:user.Guid cusid:self.KehuId page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model0 removeAllObjects];
                NSArray *tarr = dic[Y_ITEMS];
                if ([tarr isEqual:[NSNull null]]) {
                    
                }else
                {
                    for (int i=0; i<tarr.count; i++) {
                        ChanceSaleModel *model =[ChanceSaleModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model0 addObject:model];
                    }
                    page0 = dic[@"nextpage"];
                }
            }
            
            [tableV reloadData];
        }];
    }else if (temp ==1)
    {
        ///回访记录
        [WebRequest crmModule_Get_revisitRecordWithowner:user.Guid cusid:self.KehuId page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model1 removeAllObjects];
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    GLRecodeModel *model =[GLRecodeModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model1 addObject:model];
                }
                page1 = dic[@"nextpage"];
            }
           
            [tableV reloadData];
        }];
    }else if (temp ==2)
    {
        //反馈记录
        [WebRequest crmModule_Get_cusfbRecordWithowner:user.Guid cusid:self.KehuId page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model2 removeAllObjects];
                NSArray *tarr =dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    FanKuiRecordModel *model = [FanKuiRecordModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model2 addObject:model];
                }
                page2 = dic[@"nextpage"];
            }
           
            [tableV reloadData];
        }];
    }else if (temp ==3)
    {
        //联系人
        
        [WebRequest crmModule_Get_cuscontactslistWithgetpeople:@"0" owner:user.Guid comid:user.companyId cusid:self.KehuId page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model3 removeAllObjects];
                NSArray *tarr =dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    GLLianXiModel *model =[GLLianXiModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model3 addObject:model];
                }
                page3 =dic[@"nextpage"];
            }
            
           
            [tableV reloadData];
        }];
    }else
    {
        
    }
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)loadOtherData{
    if (temp ==0) {
        ///销售机会
        [WebRequest crmModule_Get_saleschancelistWithowner:user.Guid cusid:self.KehuId page:page0 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    for (int i=0; i<tarr.count; i++) {
                        ChanceSaleModel *model =[ChanceSaleModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model0 addObject:model];
                    }
                    page0 = dic[@"nextpage"];
                    [tableV reloadData];
                }
            }
            
            
        }];
    }else if (temp ==1)
    {
        ///回访记录
        [WebRequest crmModule_Get_revisitRecordWithowner:user.Guid cusid:self.KehuId page:page1 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    for (int i=0; i<tarr.count; i++) {
                        GLRecodeModel *model =[GLRecodeModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model1 addObject:model];
                    }
                    page1 = dic[@"nextpage"];
                    [tableV reloadData];
                }
            }
            
            
        }];
    }else if (temp ==2)
    {
        //反馈记录
        [WebRequest crmModule_Get_cusfbRecordWithowner:user.Guid cusid:self.KehuId page:page2 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr =dic[Y_ITEMS];
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    for (int i=0; i<tarr.count; i++) {
                        FanKuiRecordModel *model = [FanKuiRecordModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model2 addObject:model];
                    }
                    page2 = dic[@"nextpage"];
                    [tableV reloadData];
                }
            }
            
            
        }];
        
    }else if (temp ==3)
    {
        //联系人
        
        [WebRequest crmModule_Get_cuscontactslistWithgetpeople:@"0" owner:user.Guid comid:user.companyId cusid:self.KehuId page:page3 And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr =dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    for (int i=0; i<tarr.count; i++) {
                        GLLianXiModel *model =[GLLianXiModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model3 addObject:model];
                    }
                    page3 =dic[@"nextpage"];
                    [tableV reloadData];
                }
                
            }
            
            
        }];
    }else
    {
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"客户管理";
    user = [WebRequest GetUserInfo];
    arr_model0 = [NSMutableArray arrayWithCapacity:0];
    arr_model1 = [NSMutableArray arrayWithCapacity:0];
    arr_model2 = [NSMutableArray arrayWithCapacity:0];
    arr_model3 = [NSMutableArray arrayWithCapacity:0];
    page0 = @"0";
    page1 = @"0";
    page2 = @"0";
    page3=@"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    temp =0;
    V_head = [[UIView alloc]init];
    V_head.userInteractionEnabled = YES;
  
    V_head.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    yy_label_head = [[YYLabel alloc]init];
    yy_label_head.numberOfLines = 0;
    [V_head addSubview:yy_label_head];
    
    ///区头
  
    titleV = [[FBHeadScrollTitleView alloc]init];
    titleV.delegate_head = self;
    arr_titles =@[@"销售机会",@"回访记录",@"反馈记录",@"联系人"];
    [titleV setArr_titles:arr_titles];
    titleV.frame = CGRectMake(0, 0, DEVICE_WIDTH, 50);
   [titleV setClickTapIndex:0];
    titleV.backgroundColor = [UIColor whiteColor];
    titleV.layer.borderColor = [UIColor grayColor].CGColor;
    titleV.layer.borderWidth =0.5;
  
    [WebRequest crmModule_Owner_getcusWithowner:user.Guid cusid:self.KehuId And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            model_detail = [KeHu_ListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            NSMutableAttributedString  *cusName = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_detail.cusName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21 weight:3]}];
            cusName.yy_alignment = NSTextAlignmentCenter;
            [cusName yy_setTextHighlightRange:cusName.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                FBWebUrlViewController  *Uvc =[[FBWebUrlViewController alloc]init];
                Uvc.url = model_detail.url;
                Uvc.contentTitle = @"客户网址";
                [self.navigationController pushViewController:Uvc animated:NO];
            }];
          
            NSMutableAttributedString *address = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"地址：%@\n",model_detail.address] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            [address yy_setTextHighlightRange:address.yy_rangeOfAll color:[UIColor grayColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                //地图
            }];
            address.yy_alignment = NSTextAlignmentCenter;
            [cusName appendAttributedString:address];
            NSMutableAttributedString *cusCall = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"电话：%@\n",model_detail.cusCall] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            [cusCall yy_setTextHighlightRange:cusCall.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
              //打电话
                NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model_detail.cusCall];
                UIWebView *callWebView = [[UIWebView alloc] init];
                [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebView];
            }];
            cusCall.yy_alignment =NSTextAlignmentCenter;
            [cusName appendAttributedString:cusCall];
            cusName.yy_lineSpacing = 6;
            CGSize size = [cusName boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            V_head.frame = CGRectMake(0, 0, DEVICE_WIDTH, size.height+5);
            [yy_label_head mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height);
                make.centerY.mas_equalTo(V_head.mas_centerY);
                make.left.mas_equalTo(V_head.mas_left).mas_offset(15);
                make.right.mas_equalTo(V_head.mas_right).mas_offset(-15);
            }];
            yy_label_head.attributedText =  cusName;
            dispatch_async(dispatch_get_main_queue(), ^{
                tableV.tableHeaderView = V_head;
            });
        }
    }];
    
    btn_title = [FBButton buttonWithType:UIButtonTypeSystem];
    btn_title.frame =CGRectMake(0, DEVICE_HEIGHT-kBottomSafeHeight-40, DEVICE_WIDTH, 40);
    [btn_title setTitle:@"添加销售机会" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:17]];
    [self.view addSubview:btn_title];
    [btn_title addTarget:self action:@selector(btnTitleClick) forControlEvents:UIControlEventTouchUpInside];
    

    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"EQD_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightMoreCLick)];
    [self.navigationItem setRightBarButtonItem:right];
   
    
    arr_names = @[@"客户详情",@"到客户那去"];
    //@"认证易企点客户"
    tableV_selecte = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-160-15, DEVICE_TABBAR_Height+5, 160, 120) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV_selecte, self);
    tableV_selecte.delegate=self;
    tableV_selecte.dataSource=self;
    [self.view addSubview:tableV_selecte];
    tableV_selecte.rowHeight=60;
    tableV_selecte.hidden = YES;
    tableV_selecte.layer.masksToBounds = YES;
    tableV_selecte.layer.cornerRadius =6;
}

-(void)rightMoreCLick
{
    //更多
    tableV_selecte.hidden =NO;
    [tableV_selecte bringSubviewToFront:self.view];
    
}
-(void)daohangClick
{
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([model_detail.addrlong floatValue],[model_detail.addrlat floatValue]);
    UIAlertController *alert = [[UIAlertController alloc]init];
    NSURL * apple_App = [NSURL URLWithString:@"http://maps.apple.com/"];
    
    if ([[UIApplication sharedApplication] canOpenURL:apple_App]) {
        [alert addAction:[UIAlertAction actionWithTitle:@"使用苹果自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //当前位置
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
            //传入目的地，会显示在苹果自带地图上面目的地一栏
            toLocation.name = model_detail.address;
            //导航方式选择walking
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        
        }]];
    }
    
    NSURL * gaode_App = [NSURL URLWithString:@"iosamap://"];
    if ([[UIApplication sharedApplication] canOpenURL:gaode_App]) {
        
        [alert addAction:[UIAlertAction actionWithTitle:@"使用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
           
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",@"易企点",coordinate.latitude,coordinate.longitude,model_detail.address] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
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
        
        [alert addAction:[UIAlertAction actionWithTitle:@"使用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
         
            
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name:%@&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude,model_detail.address] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
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
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)kehuDetailClick
{
    KHDetailViewController  *Dvc = [[KHDetailViewController alloc]init];
    Dvc.model = model_detail;
    [self.navigationController pushViewController:Dvc animated:NO];
}
#pragma  mark - 添加相应的客户信息
-(void)btnTitleClick
{
    if(temp==0)
    {
        //添加销售机会
        CAddViewController *CAvc =[[CAddViewController alloc]init];
        CAvc.kehuId = self.KehuId;
        CAvc.kehuName = model_detail.cusName;
        [self.navigationController pushViewController:CAvc animated:NO];
    }else if (temp ==1)
    {
        //添加回访记录
        RAddViewController *RAvc =[[RAddViewController alloc]init];
        RAvc.kehuName = model_detail.cusName;
        RAvc.kehuId = model_detail.ID;
        [self.navigationController pushViewController:RAvc animated:NO];
        
    }else if (temp ==2)
    {
        //添加反馈记录
        FKAddViewController  *FKvc = [[FKAddViewController alloc]init];
        FKvc.kehuId = model_detail.ID;
        [self.navigationController pushViewController:FKvc animated:NO];
    }else if (temp==3)
    {
        //添加联系人
        LXRAddViewController *LXvc =[[LXRAddViewController alloc]init];
        LXvc.model = model_detail;
        [self.navigationController pushViewController:LXvc animated:NO];
    }
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0 && tableView ==tableV) {
        return 50;
    }else
    {
        return 0;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    if (section==0 && tableView ==tableV) {
        return titleV;
    }else
    {
        return nil;
    }
}
#pragma  mark - 分隔栏的选择
-(void)getSelectedIndex:(NSInteger)index
{
    temp =index;
    [self loadRequestData];
    [btn_title  setTitle:[NSString stringWithFormat:@"添加%@",arr_titles[temp]] forState:UIControlStateNormal];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==tableV) {
        NSArray *tarr =@[arr_model0,arr_model1,arr_model2,arr_model3];
        NSArray *tarr2 = tarr[temp];
        return  tarr2.count;
    }else if (tableView ==tableV_selecte)
    {
        return arr_names.count;
    }else
    {
        return 0;
    }
  
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView ==tableV) {
        
        switch (temp) {
            case 0:
            {
                //销售机会
                
                static NSString *cellId=@"cellID0";
                FBThree_noimg112TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[FBThree_noimg112TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                ChanceSaleModel  *model = arr_model0[indexPath.row];
                [cell setModel:model];
                cell.L_right.textColor = EQDCOLOR;
                FBindexTapGestureRecognizer *tap_phone = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPhoneClick:)];
                tap_phone.indexPath = indexPath;
                [cell.L_right addGestureRecognizer:tap_phone];
                cell.backgroundColor =[[UIColor grayColor] colorWithAlphaComponent:0.1];
                return cell;
            }
                break;
               case 1:
            {
                //回访记录
                
                static NSString *cellId=@"cellID1";
                FBThree_noimg112TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[FBThree_noimg112TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                GLRecodeModel *model =arr_model1[indexPath.row];
                [cell setModel:model];
                cell.L_right.textColor =EQDCOLOR;
                FBindexTapGestureRecognizer *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
                tap.indexPath =indexPath;
                [cell.L_right addGestureRecognizer:tap];
                cell.backgroundColor =[[UIColor grayColor] colorWithAlphaComponent:0.1];
                return cell;
            }
                break;
                case 2:
            {
                //反馈记录
                
                static NSString *cellId=@"cellID2";
                FBThree_noimg112TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[FBThree_noimg112TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }
                FanKuiRecordModel *model =arr_model2[indexPath.row];
                [cell setModel:model];
                cell.L_right.textColor = EQDCOLOR;
                FBindexTapGestureRecognizer *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick2:)];
                tap.indexPath =indexPath;
                [cell.L_right addGestureRecognizer:tap];
                cell.backgroundColor =[[UIColor grayColor] colorWithAlphaComponent:0.1];
                return cell;
            }
                break;
                case 3:
            {
                //联系人
                
                static NSString *cellId=@"cellID3";
                FBThree_noimg112TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[FBThree_noimg112TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                GLLianXiModel *model =arr_model3[indexPath.row];
                [cell setModel:model];
                FBindexTapGestureRecognizer *tap_phone = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_phoneClick:)];
                tap_phone.indexPath = indexPath;
                cell.L_right.textColor = EQDCOLOR;
                [cell.L_right addGestureRecognizer:tap_phone];
                cell.backgroundColor =[[UIColor grayColor] colorWithAlphaComponent:0.1];
                
                return cell;
            }
                break;
            default:
                return nil;
                break;
        }
    }else if(tableView ==tableV_selecte)
    {
        static NSString *cellid=@"cellid22";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        }
        cell.textLabel.text = arr_names[indexPath.row];
        return cell;
    }else
    {
        return nil;
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    tableV_selecte.hidden = YES;
}
-(void)tapClick2:(FBindexTapGestureRecognizer*)tap
{
    FanKuiRecordModel *model =arr_model2[tap.indexPath.row];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.fberPhone];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebView];
}
-(void)tapClick:(FBindexTapGestureRecognizer*)tap
{
    GLRecodeModel *model =arr_model1[tap.indexPath.row];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.contactsPhone];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebView];
}
-(void)tapPhoneClick:(FBindexTapGestureRecognizer*)tap_
{
    ChanceSaleModel *model =arr_model0[tap_.indexPath.row];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.contactsPhone];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebView];
}

-(void)tap_phoneClick:(FBindexTapGestureRecognizer*)tap
{
    GLLianXiModel *model = arr_model3[tap.indexPath.row];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.cellphone];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebView];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableV_selecte.hidden = YES;
    if (tableView ==tableV) {
    if (temp==0) {
        //销售机会
        ChanceSaleModel  *model =arr_model0[indexPath.row];
        GLChance_DetailViewController *dvc = [[GLChance_DetailViewController alloc]init];
        dvc.model =model;
        dvc.kehuName = model_detail.cusName;
        [self.navigationController pushViewController:dvc animated:NO];
    }else if (temp ==1)
    {
        //回访记录
        GLRecodeModel  *model =arr_model1[indexPath.row];
        GLRecord_detailViewController  *Dvc = [[GLRecord_detailViewController alloc]init];
        Dvc.model =model;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (temp ==2)
    {
        //反馈记录
        FanKuiRecordModel  *model =arr_model2[indexPath.row];
        FKDetailViewController  *Dvc = [[FKDetailViewController alloc]init];
        Dvc.model = model;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (temp ==3)
    {
        //联系人
        GLLianXiModel  *model =arr_model3[indexPath.row];
        GLLianXI_DetailViewController *dvc = [[GLLianXI_DetailViewController alloc]init];
        dvc.model = model;
        [self.navigationController pushViewController:dvc animated:NO];
    }else
    {
        
    }
    }else if (tableView ==tableV_selecte)
    {
        switch (indexPath.row) {
            case 0:
            {
                ///客户详情
                [self kehuDetailClick];
            }
                break;
                case 1:
            {
                //导航
                [self daohangClick];
            }
                break;
                case 2:
            {
               //绑定易企点
            }
                break;
            default:
                break;
        }
    }
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableV ==tableView)
    {
    return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleNone;
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        if (temp==0) {
            //销售机会
            ChanceSaleModel *model =arr_model0[indexPath.row];
            [WebRequest crmModule_Del_saleschanceWithowner:user.Guid saleschanceid:model.ID And:^(NSDictionary *dic) {
                
                if ([dic[Y_STATUS] integerValue] ==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_model0 removeObjectAtIndex:indexPath.row];
                    [tableV reloadData];
                }else
                {
                    [alert showAlertWith:@"您无此权限"];
                }
            }];
            
            
        }else if (temp ==1)
        {
            //回访记录
            GLRecodeModel *model =arr_model1[indexPath.row];
            [WebRequest crmModule_Del_revisitRecordWithowner:user.Guid revisitRecordid:model.ID And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue] ==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_model1 removeObjectAtIndex:indexPath.row];
                    [tableV reloadData];
                }else
                {
                    [alert showAlertWith:@"您无此权限"];
                }
            }];
        }else if (temp ==2)
        {
            //反馈记录
            FanKuiRecordModel *model =arr_model2[indexPath.row];
            [WebRequest crmModule_Del_cusfbRecordWithowner:user.Guid cusfbRecordid:model.ID And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue] ==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_model2 removeObjectAtIndex:indexPath.row];
                    [tableV reloadData];
                }else
                {
                    [alert showAlertWith:@"您无此权限"];
                }
            }];
        }else if (temp ==3)
        {
            //联系人
            GLLianXiModel *model =arr_model3[indexPath.row];
            [WebRequest crmModule_Del_cuscontactsWithowner:user.Guid contactsid:model.ID And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue] ==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_model3 removeObjectAtIndex:indexPath.row];
                    [tableV reloadData];
                }else
                {
                    [alert showAlertWith:@"您无此权限"];
                }
            }];
        }
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}



@end
