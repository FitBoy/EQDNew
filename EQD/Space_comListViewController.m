//
//  Space_comListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Space_comListViewController.h"
#import "EQDR_articleListModel.h"
#import <Masonry.h>
#import "FBindexTapGestureRecognizer.h"
#import <UIImageView+WebCache.h>
#import "EQDR_ArticleClassSearchViewController.h"
#import "EQDR_Article_DetailViewController.h"
#import "SC_zuZhiJiegouViewController.h"
#import "SC_TeamPersonViewController.h"
#import "SC_contactComViewController.h"
#import "SC_CenterViewController.h"
#import "SC_activeAndEventViewController.h"
#import "SC_ComDetailViewController.h"
#import "SC_fangKeModel.h"
#import "SC_fangKeTableViewCell.h"
#import "PPersonCardViewController.h"
#import "SC_productModel.h"
#import "SC_ComShoucangViewController.h"
#import "SC_teamMiaoshuTableViewCell.h"
#import "SC_productTableViewCell.h"
#import "SC_productDetailViewController.h"
#import "WS_LiuYanTableViewCell.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "SC_EqitmentShowViewController.h"
#import "SC_OtherComDetailViewController.h"
#import "FBLabel_YYAddTableViewCell.h"
#import "SC_tradeModel.h"
#import "FBHeadScrollTitleView.h"
#import "SC_needPiPeiViewController.h"
#import "SC_needCaiGouViewController.h"
#import "EQDB_appViewController.h"
@interface Space_comListViewController ()<UITableViewDelegate,UITableViewDataSource,FB_OnlyForLiuYanViewControllerDlegate,FBHeadScrollTitleViewDelegate,SC_needCaiGouViewControllerdelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSArray *arr_model;
    
    UITableView *tableV1;
    NSString *page1;
    NSMutableArray *arr_model1;
    
    UITableView *tableV2;
    NSMutableArray *arr_model2;
    NSString *page2;
    
    UITableView *tableV3;
    NSArray *arr_model3;
    
    UITableView  *tableV4;
    NSArray *arr_model4;
    
    // 留言
    UITableView *tableV5;
    NSMutableArray *arr_model5;
    NSString *page5;
    NSIndexPath *indexPath_selected5;
    
    UITableView *tableV6;
    NSMutableArray *arr_model6;
    NSString *page6;
    
    ///交易记录
    UITableView *tableV7;
    NSMutableArray *arr_model7;
    NSString *page7;
    NSString *orderType;
    FBHeadScrollTitleView *titleV_7;
    
    ///采购需求
    UITableView *tableV8;
    NSArray *arr_names;
    
    ///企业收藏
    UITableView *tableV9;
    NSArray *arr_names9;
    
    
}

@end

@implementation Space_comListViewController
#pragma  mark - 回复留言
-(void)getPresnetText:(NSString *)text
{
    WS_liuYanModel  *model = arr_model5[indexPath_selected5.row];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在回复";
    [WebRequest ComSpace_ComSpaceLeaveMessage_Add_ComSpaceLeaveMessageWithuserGuid:user.Guid userCompanyId:user.companyId message:text parentId:model.Id companyId:model.companyId parentUserGuid:model.creater firstCommentId:model.Id And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                WS_liuYanModel *tmodel =   [WS_liuYanModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.childList];
                [tarr insertObject:tmodel atIndex:0];
                model.childList = tarr;
                [arr_model5 replaceObjectAtIndex:indexPath_selected5.row withObject:model];
                [tableV5 reloadData];
            }
        });
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData1];
}

-(void)loadRequestData5
{
    //留言
    [WebRequest ComSpace_ComSpaceLeaveMessage_Get_ComSpaceLeaveMessageWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV5.mj_header endRefreshing];
        [tableV5.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model5 removeAllObjects];
            page5 = dic[@"page"];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                WS_liuYanModel  *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model5 addObject:model];
            }
            [tableV5 reloadData];
        }
    }];
    
    
}
-(void)loadOtherData5{
    //留言
    
    [WebRequest ComSpace_ComSpaceLeaveMessage_Get_ComSpaceLeaveMessageWithcompanyId:user.companyId page:page5 And:^(NSDictionary *dic) {
        [tableV5.mj_header endRefreshing];
        [tableV5.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
          
          
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV5.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                  page5 = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                WS_liuYanModel  *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model5 addObject:model];
            }
            [tableV5 reloadData];
                
            }
        }
    }];
}
-(void)loadrequestData6{
    //访客
    [WebRequest ComSpace_ComSpaceVisitor_Get_ComSpaceVisitorWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV6.mj_header endRefreshing];
        [tableV6.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model6 removeAllObjects];
            page6 = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                SC_fangKeModel *model = [SC_fangKeModel mj_objectWithKeyValues:tarr[i]];
                [arr_model6 addObject:model];
            }
            [tableV6 reloadData];
        }
    }];
}
-(void)loadMoreData6{
    //访客
    
    [WebRequest ComSpace_ComSpaceVisitor_Get_ComSpaceVisitorWithcompanyId:user.companyId page:page6 And:^(NSDictionary *dic) {
        [tableV6.mj_header endRefreshing];
        [tableV6.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV6.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page6 = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                SC_fangKeModel *model = [SC_fangKeModel mj_objectWithKeyValues:tarr[i]];
                [arr_model6 addObject:model];
            }
            [tableV6 reloadData];
        }
        }
    }];
}
-(void)loadRequestData1{
    
    [WebRequest ComSpace_Admin_ComSpaceDaily_Get_ComSpaceDailyWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV1.mj_header endRefreshing];
        [tableV1.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model1 removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            page1 = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model1 addObject:model];
            }
            [tableV1 reloadData];
            
        }
    }];
}
-(void)loadOtherData1
{
    [WebRequest ComSpace_Admin_ComSpaceDaily_Get_ComSpaceDailyWithcompanyId:user.companyId page:page1 And:^(NSDictionary *dic) {
        [tableV1.mj_header endRefreshing];
        [tableV1.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count ==0) {
                [tableV1.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page1 = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model1 addObject:model];
            }
            [tableV1 reloadData];
            }
            
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
#pragma  mark - 产品信息
-(void)loadrequestData2{
    [WebRequest ComSpace_ComSpaceProduct_Get_ComSpaceProductWithcompanyId:user.companyId page:@"0" And:^(NSDictionary *dic) {
        [tableV2.mj_header endRefreshing];
        [tableV2.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page2 = dic[@"page"];
            [arr_model2 removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model2 addObject:model];
            }
            [tableV2 reloadData];
        }
    }];
}
-(void)loadMoreData2{
    [WebRequest ComSpace_ComSpaceProduct_Get_ComSpaceProductWithcompanyId:user.companyId page:page2 And:^(NSDictionary *dic) {
        [tableV2.mj_header endRefreshing];
        [tableV2.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if(tarr.count ==0)
            {
                [tableV2.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page2 = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model2 addObject:model];
            }
            [tableV2 reloadData];
            }
        }
    }];
}
#pragma  mark - 交易记录
-(void)loadRequeestData7{
    [WebRequest ComSpace_ComSpacePayRecord_Get_ComSpacePayRecordWithcompanyId:user.companyId page:@"0" orderType:orderType And:^(NSDictionary *dic) {
        [tableV7.mj_header endRefreshing];
        [tableV7.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page7 = dic[@"page"];
            [arr_model7 removeAllObjects];
            for(int i=0;i<tarr.count;i++)
            {
                SC_tradeModel *model = [SC_tradeModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model7 addObject:model];
            }
            [tableV7 reloadData];
        }
    }];
}
-(void)loadMoreData7{
    [WebRequest ComSpace_ComSpacePayRecord_Get_ComSpacePayRecordWithcompanyId:user.companyId page:@"0" orderType:orderType And:^(NSDictionary *dic) {
        [tableV7.mj_header endRefreshing];
        [tableV7.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV7.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page7 = dic[@"page"];
            for(int i=0;i<tarr.count;i++)
            {
                SC_tradeModel *model = [SC_tradeModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model7 addObject:model];
            }
            [tableV7 reloadData];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model1 = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"企业空间中心";
    arr_model = @[@"日志",@"产品信息",@"企业信息",@"企业文化",@"留言",@"访客",@"交易记录",@"采购需求",@"企业收藏"];
    
    user = [WebRequest GetUserInfo];
    //侧边栏
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, 100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    [self tableView:tableV didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV1, self);
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [self.view addSubview:tableV1];
    tableV1.rowHeight=60;
    tableV1.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData1)];
    tableV1.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData1)];

    ///企业信息
    arr_model3 = @[@"企业简介",@"设备展示",@"组织机构",@"团队介绍",@"联系我们"];
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV3, self);
    tableV3.delegate=self;
    tableV3.dataSource=self;
    [self.view addSubview:tableV3];
    tableV3.rowHeight=60;
    
///企业文化
    arr_model4 = @[@"核心价值观",@"领导活动",@"先进事迹",@"荣誉墙"];
    tableV4 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV4, self);
    tableV4.delegate=self;
    tableV4.dataSource=self;
    [self.view addSubview:tableV4];
    tableV4.rowHeight=60;
    
    page5 =@"0";
    page6 =@"0";
    arr_model5 = [NSMutableArray arrayWithCapacity:0];
    arr_model6 = [NSMutableArray arrayWithCapacity:0];
    tableV5 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV5, self);
    tableV5.delegate=self;
    tableV5.dataSource=self;
    [self.view addSubview:tableV5];
    tableV5.rowHeight=60;
    tableV5.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData5)];
    tableV5.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData5)];
    
    
    tableV6 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV6, self);
    tableV6.delegate=self;
    tableV6.dataSource=self;
    [self.view addSubview:tableV6];
    tableV6.rowHeight=60;
    tableV6.mj_header  =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadrequestData6)];
    tableV6.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData6)];
   
  
   
    
    
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV2, self);
    tableV2.delegate=self;
    tableV2.dataSource=self;
    [self.view addSubview:tableV2];
    tableV2.rowHeight=60;
    tableV2.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadrequestData2)];
    tableV2.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData2)];
    arr_model2 = [NSMutableArray arrayWithCapacity:0];
    
    // 交易记录
    orderType =@"0";
    page7 =@"0";
    arr_model7 = [NSMutableArray arrayWithCapacity:0];
    tableV7 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV7, self);
    tableV7.delegate=self;
    tableV7.dataSource=self;
    [self.view addSubview:tableV7];
    tableV7.rowHeight=60;
    tableV7.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequeestData7)];
    tableV7.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData7)];
    titleV_7 = [[FBHeadScrollTitleView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
    [titleV_7 setArr_titles:@[@"全部订单",@"已付款",@"未付款"]];
    titleV_7.delegate_head =self;
  
    //采购需求
    arr_names = @[@"发布的需求",@"需求匹配的产品",@"易企购"];
    tableV8 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV8, self);
    tableV8.delegate=self;
    tableV8.dataSource=self;
    [self.view addSubview:tableV8];
    tableV8.rowHeight=60;
    
    //企业收藏
    arr_names9 = @[@"收藏的产品",@"收藏的企业"];
    tableV9 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV9, self);
    tableV9.delegate=self;
    tableV9.dataSource=self;
    [self.view addSubview:tableV9];
    tableV9.rowHeight=60;
    

    
    [self sethiddenView];
    tableV1.hidden =NO;
}
-(void)getSelectedIndex:(NSInteger)index
{
    if (index ==0) {
        orderType = @"0";
       
    }else if (index ==1)
    {
        orderType =@"1";
        
    }else if(index ==2)
    {
        orderType = @"-2";
    }else
    {
        
    }
     [tableV7.mj_header beginRefreshing];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView ==tableV7) {
        return 40 ;
    }else
    {
        return 1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableV7 == tableView) {
        
        return titleV_7;
    }else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableV) {
        return 50;
    }else if (tableV1 == tableView)
    {
        EQDR_articleListModel  *model = arr_model1[indexPath.row];
        return model.cellHeight;
    }else if (tableV6 == tableView)
    {
        return 85;
    }else if (tableV2 == tableView)
    {
        return 110;
    }else if (tableV5 == tableView)
    {
        WS_liuYanModel *model = arr_model5[indexPath.row];
        return model.cell_height;
    }else if (tableV7 == tableView)
    {
        SC_tradeModel *model = arr_model7[indexPath.row];
        return model.cell_height;
    }
    else
    {
    return 60;
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableV == tableView)
    {
        return arr_model.count;
    }else if (tableV1 == tableView)
    {
        return arr_model1.count;
    }else if (tableView == tableV3)
    {
        return arr_model3.count;
    }else if (tableView == tableV4)
    {
        return arr_model4.count;
    }else if (tableV5 == tableView)
    {
        return arr_model5.count;
    }else if (tableV6 ==tableView)
    {
        return arr_model6.count;
    }else if (tableV2 ==tableView)
    {
        return arr_model2.count;
    }else if (tableView == tableV7)
    {
        return arr_model7.count;
    }else if (tableView == tableV8)
    {
        return arr_names.count;
    }else if (tableV9 == tableView)
    {
        return arr_names9.count;
    }
    else
    {
    return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == tableV) {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        cell.textLabel.text = arr_model[indexPath.row];
        return cell;
    }else if (tableView == tableV1)
    {
        static NSString *cellId=@"cellID1";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.numberOfLines =0;
        }
        EQDR_articleListModel *mdoel =arr_model1[indexPath.row];
        cell.textLabel.text = mdoel.title;
        return cell;
    }else if (tableV3 ==tableView)
    {
        static NSString *cellId=@"cellID3";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = arr_model3[indexPath.row];
        return cell;
    }else if (tableV4 ==tableView)
    {
        static NSString *cellId=@"cellID4";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = arr_model4[indexPath.row];
        return cell;
    }else if (tableV6 == tableView)
    {
        static NSString *cellId=@"cellID6";
        SC_fangKeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[SC_fangKeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        SC_fangKeModel  *model = arr_model6[indexPath.row];
        [cell setModel_fangke:model];
        
        return cell;
    }else if (tableView == tableV2)
    {
        static NSString *cellId=@"cellID6";
        SC_productTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[SC_productTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        SC_productModel *model = arr_model2[indexPath.row];
        [cell setModel_product:model];
        return cell;
    }else if (tableView ==tableV5)
    {
        static NSString *cellid=@"cellid5";
        WS_LiuYanTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[WS_LiuYanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        WS_liuYanModel  *model = arr_model5[indexPath.row];
        [cell setModel_liuyan:model];
        FBindexTapGestureRecognizer *tap_head = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_headCLick:)];
        tap_head.indexPath =indexPath;
        [cell.V_top.IV_head addGestureRecognizer:tap_head];
        
        FBindexTapGestureRecognizer *tap_huifu = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_huifuCLick:)];
        tap_huifu.indexPath =indexPath;
        [cell.L_contets addGestureRecognizer:tap_huifu];
        return cell;
    }else if (tableView ==tableV7)
    {
        static NSString *cellId=@"cellID7";
        FBLabel_YYAddTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        }
        SC_tradeModel  *model = arr_model7[indexPath.row];
        NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单号：%@\n支付金额：%@元（%@）\n开通功能：%@\n开通时间:%@\n开通年限：%@年\n支付状态：%@\n",model.OrderCode,model.amountMondy,model.type,model.funcType,model.createTime,model.years,model.status] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        contents.yy_lineSpacing =6;
        CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model.cell_height = size.height+15;
        cell.YL_content.attributedText = contents;
        [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        
        return cell;
    }else if (tableV8 ==tableView)
    {
        static NSString *cellId=@"cellID8";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell.textLabel.text = arr_names[indexPath.row];
        return cell;
    }else if (tableView ==tableV9)
    {
        static NSString *cellId=@"cellID9";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell.textLabel.text = arr_names9[indexPath.row];
        return cell;
    }
    else
    {
        return  nil;
    }
    
}
#pragma  mark - 点击留言的头像
-(void)tap_headCLick:(FBindexTapGestureRecognizer*)tap{
    WS_liuYanModel *model = arr_model5[tap.indexPath.row];
    PPersonCardViewController  *Pvc = [[PPersonCardViewController alloc]init];
    Pvc.userGuid =model.creater;
    [self.navigationController pushViewController:Pvc animated:NO];
}
#pragma  mark - 点击留言的回复
-(void)tap_huifuCLick:(FBindexTapGestureRecognizer*)tap{
    WS_liuYanModel  *model = arr_model5[tap.indexPath.row];
    indexPath_selected5 = tap.indexPath;
    FB_OnlyForLiuYanViewController *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.delegate =self;
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    LYvc.btnName = @"回复";
    LYvc.placeHolder =[NSString stringWithFormat:@"回复%@:",model.staffName];
    [self presentViewController:LYvc animated:NO completion:nil];
}
-(void)sethiddenView{
    tableV1.hidden =YES;
    tableV2.hidden =YES;
    tableV3.hidden =YES;
    tableV4.hidden =YES;
    tableV5.hidden = YES;
    tableV6.hidden = YES;
    tableV7.hidden =YES;
    titleV_7.hidden =YES;
    tableV8.hidden =YES;
    tableV9.hidden =YES;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableV1 ==tableView)
    {
        EQDR_articleListModel  *model =arr_model1[indexPath.row];
        EQDR_Article_DetailViewController  *Dvc =[[EQDR_Article_DetailViewController alloc]init];
        Dvc.articleId =model.Id;
        Dvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (tableV == tableView)
    {
        [self sethiddenView];
        if (indexPath.row ==0) {
            tableV1.hidden =NO;
        }else if (indexPath.row ==1)
        {
            //产品信息
            tableV2.hidden=NO;
            if (arr_model2.count ==0) {
                [self loadrequestData2];
            }
           
        }else if (indexPath.row == 2)
        {
            //企业信息
            tableV3.hidden=NO;
            
        }else if (indexPath.row == 3)
        {
            //企业文化
            tableV4.hidden =NO;
            
            
        }else if (indexPath.row ==4)
        {
            //留言
           
            if (arr_model5.count==0) {
                [tableV5.mj_header beginRefreshing];
            }
             tableV5.hidden = NO;
        }else if (indexPath.row ==5)
        {
            //访客
            tableV6.hidden =NO;
            if (arr_model6.count ==0) {
                [tableV6.mj_header beginRefreshing];
            }
        }else if (indexPath.row ==6)
        {
            //交易记录
            tableV7.hidden =NO;
            titleV_7.hidden =NO;
            if (arr_model7.count ==0) {
                [self loadRequeestData7];
            }
        }else if (indexPath.row ==7)
        {
            //采购需求
            tableV8.hidden =NO;
            [tableV8 reloadData];
        }else if (indexPath.row ==8)
        {
            tableV9.hidden =NO;
            [tableV9 reloadData];
        }
    }else if (tableView ==tableV3)
    {
        if (indexPath.row ==0) {
            //基本信息
            SC_OtherComDetailViewController  *Dvc = [[SC_OtherComDetailViewController alloc]init];
            Dvc.comId =user.companyId;
            [self.navigationController pushViewController:Dvc animated:NO];
        }else if (indexPath.row ==1)
        {
            //设备展示
            SC_EqitmentShowViewController  *Svc = [[SC_EqitmentShowViewController alloc]init];
            Svc.comId = user.companyId;
            [self.navigationController pushViewController:Svc animated:NO];
        }else if (indexPath.row ==2)
        {
            //组织机构
            SC_zuZhiJiegouViewController  *Svc = [[SC_zuZhiJiegouViewController alloc]init];
            [self.navigationController pushViewController:Svc animated:NO];
        }else if (indexPath.row==3)
        {
           //团队介绍
            SC_TeamPersonViewController  *Tvc = [[SC_TeamPersonViewController alloc]init];
            Tvc.temp =0;
            Tvc.comId =user.companyId;
            [self.navigationController pushViewController:Tvc animated:NO];
        }else if (indexPath.row == 4)
        {
            //联系我们
            SC_contactComViewController *CCvc =[[SC_contactComViewController alloc]init];
            [self.navigationController pushViewController:CCvc animated:NO];
        }
    }else if (tableV4 ==tableView)
    {
        if (indexPath.row ==0) {
          //核心价值观
            SC_CenterViewController *Cvc = [[SC_CenterViewController alloc]init];
            Cvc.comId = user.companyId;
            [self.navigationController pushViewController:Cvc animated:NO];
        }else if (indexPath.row == 1)
        {
          //领导活动
            SC_activeAndEventViewController *AEvc =[[SC_activeAndEventViewController alloc]init];
            AEvc.temp =0;
            AEvc.comId = user.companyId;
            [self.navigationController pushViewController:AEvc animated:NO];
        }else if (indexPath.row == 2)
        {
            //先进事迹
            SC_activeAndEventViewController *AEvc =[[SC_activeAndEventViewController alloc]init];
            AEvc.temp =1;
            AEvc.comId = user.companyId;
            [self.navigationController pushViewController:AEvc animated:NO];
        }else if (indexPath.row ==3)
        {
            // 荣誉墙
            SC_TeamPersonViewController  *Tvc = [[SC_TeamPersonViewController alloc]init];
            Tvc.temp =1;
            Tvc.comId =user.companyId;
            [self.navigationController pushViewController:Tvc animated:NO];
        }
    }else if (tableV6 == tableView)
    {
        SC_fangKeModel  *model = arr_model6[indexPath.row];
        PPersonCardViewController  *Pvc  = [[PPersonCardViewController alloc]init];
        Pvc.userGuid = model.creater;
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if (tableV2 == tableView)
    {
        SC_productModel *model = arr_model2[indexPath.row];
        SC_productDetailViewController  *Dvc = [[SC_productDetailViewController alloc]init];
        Dvc.equipmentId = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (tableV8 == tableView)
    {
        if (indexPath.row ==0) {
            //需求
            SC_needCaiGouViewController  *CGvc =[[SC_needCaiGouViewController alloc]init];
            [self.navigationController pushViewController:CGvc animated:NO];
        }else if (indexPath.row ==1)
        {
            //匹配的需求
            SC_needCaiGouViewController  *CGvc =[[SC_needCaiGouViewController alloc]init];
            CGvc.delegate_choose =self;
            [self.navigationController pushViewController:CGvc animated:NO];
           
        }else if (indexPath.row ==2)
        {
            //易企购
            EQDB_appViewController  *appVc =[[EQDB_appViewController alloc]init];
            [self.navigationController pushViewController:appVc animated:NO];
        }
    }else if (tableView ==tableV9)
    {
        if (indexPath.row ==0) {
            //收藏的产品
            SC_needPiPeiViewController  *PPvc = [[SC_needPiPeiViewController alloc]init];
            PPvc.temp =2;
            PPvc.Id = user.companyId;
            [self.navigationController pushViewController:PPvc animated:NO];
        }else if (indexPath.row ==1)
        {
          //收藏的企业
            SC_ComShoucangViewController *SCvc = [[SC_ComShoucangViewController alloc]init];
            SCvc.comId = user.companyId;
            [self.navigationController pushViewController:SCvc animated:NO];
        }else
        {
            
        }
    }
    else
    {
        
    }
}
-(void)getNeedModel:(SC_needModel *)tmodel
{
    SC_needPiPeiViewController *PPvc =[[SC_needPiPeiViewController alloc]init];
    PPvc.Id = tmodel.Id;
    [self.navigationController pushViewController:PPvc animated:NO];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV == tableV1) {
        return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleNone;
    }
    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除企业日志
        UIAlertController *alertt = [[UIAlertController alloc]init];
        [alertt addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            EQDR_articleListModel  *model = arr_model1[indexPath.row];
            [WebRequest ComSpace_Admin_ComSpaceDaily_Delete_ComSpaceDailyWithuserGuid:user.Guid dailyId:model.Id companyId:user.companyId And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model1 removeObject:model];
                        [tableV1 reloadData];
                    }
                });
            }];
            
            
        }]];
        [alertt addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertt animated:NO completion:nil];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableV1 == tableView)
    {
    return @"删除";
    }else
    {
        return nil;
    }
}




@end
