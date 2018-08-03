//
//  WS_comDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 空区给头的设计

#import "WS_comDetailViewController.h"
#import "FBHeadScrollTitleView.h"
#import "EQDR_ArticleTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "EQDR_ArticleClassSearchViewController.h"
#import "EQDR_Article_DetailViewController.h"
#import "WS_ComDetailModel.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "WS_LiuYanTableViewCell.h"
#import "FBindexTapGestureRecognizer.h"
#import "PPersonCardViewController.h"
#import "WS_ArticleComModel.h"
#import "FBImage_textFullTableViewCell.h"
#import "FBLabel_YYAddTableViewCell.h"
#import "SC_teamMiaoshuTableViewCell.h"
#import "SC_CenterViewController.h"
#import "SC_activeAndEventViewController.h"
#import "SC_TeamPersonViewController.h"
#import "ImgScrollTableViewCell.h"
#import "FBScrollView.h"
#import "SC_productTableViewCell.h"
#import "SC_productDetailViewController.h"
#import "SC_EqitmentShowViewController.h"
#import "FBWebUrlViewController.h"

@interface WS_comDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBHeadScrollTitleViewDelegate,FB_OnlyForLiuYanViewControllerDlegate,UIWebViewDelegate>
{
    UserModel  *user;
    //日志
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    FBHeadScrollTitleView  *headScrolltitle;
    
    
    
    UITableView *tableV4;
    NSMutableArray *arr_model4;
    NSString *page4;
    UILabel  *tlabel4;
    
    UITableView *tableV3;
    WS_ArticleComModel *model_culture;
    
    UITableView *tableV2;
    WS_ComDetailModel *model_info;
    float img_Height;
    float text_height;
    float contact_height;
    NSInteger temp;
    
    ///产品信息
    UITableView *tableV1;
    NSMutableArray *arr_model1;
    NSString *page1;
    
    
}

@end

@implementation WS_comDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WebRequest ComSpace_ComSpaceVisitor_Add_ComSpaceVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"企业空间" companyId:self.comId option:@"访问了企业空间"  And:^(NSDictionary *dic) {
            
        }];
    });
    
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    text_height = [htmlHeight floatValue]+10;
    webView.frame =CGRectMake(15, 0, DEVICE_WIDTH-30, text_height);
    temp =1;
    [tableV2 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma  mark -  点击的是标题的哪一个
//留言
-(void)loadRequestData4{
    [WebRequest ComSpace_ComSpaceLeaveMessage_Get_ComSpaceLeaveMessageWithcompanyId:self.comId page:@"0" And:^(NSDictionary *dic) {
        [tableV4.mj_header endRefreshing];
        [tableV4.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            page4 = dic[@"page"];
            [arr_model4 removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                WS_liuYanModel *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model4 addObject:model];
            }
            [tableV4 reloadData];
        }
    }];
}

-(void)loadMoreData4{
    [WebRequest ComSpace_ComSpaceLeaveMessage_Get_ComSpaceLeaveMessageWithcompanyId:self.comId page:page4 And:^(NSDictionary *dic) {
        [tableV4.mj_header endRefreshing];
        [tableV4.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV4.mj_footer  endRefreshingWithNoMoreData];
            }else
            {
                page4 = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                WS_liuYanModel *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model4 addObject:model];
            }
            [tableV4 reloadData];
            }
        }
    }];
}
-(void)getSelectedIndex:(NSInteger)index
{
    [self setHiddenView];
    switch (index) {
        case 0:
        {
            tableV.hidden =NO;
        }
            break;
        case 1:
        {
            tableV1.hidden = NO;
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [WebRequest ComSpace_ComSpaceVisitor_Add_ComSpaceVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"产品信息列表" companyId:self.comId option:@"访问了产品信息列表"  And:^(NSDictionary *dic) {
                    
                }];
            });
            
            if (arr_model1.count==0) {
                [self loadRequestData1];
            }
        }
            break;
        case 2:
        {
            tableV2.hidden =NO;
            if (model_info==nil) {
                [self loadRequestData2];
            }
           
        }
            break;
            case 3:
        {
            tableV3.hidden =NO;
            if (model_culture==nil) {
                [self loadReuquestData3];
            }else
            {
                
            }
        }
            break;
            case 4:
        {
            tableV4.hidden = NO;
            tlabel4.hidden =NO;
            if (arr_model4.count==0) {
                [self loadRequestData4];
            }
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [WebRequest ComSpace_ComSpaceVisitor_Add_ComSpaceVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"留言" companyId:self.comId option:@"访问了企业留言"  And:^(NSDictionary *dic) {
                    
                }];
            });
        }
            break;
            
        default:
            break;
    }
}
#pragma  mark - 企业信息
-(void)loadRequestData2{
    [WebRequest ComSpace_Get_ComSpaceInfoWithcompanyId:self.comId And:^(NSDictionary *dic) {
       if([dic[Y_STATUS] integerValue]==200)
       {
           model_info = [WS_ComDetailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
           dispatch_async(dispatch_get_main_queue(), ^{
             [tableV2 reloadData];
           });
          
           
       }
    }];
}
-(void)loadRequestData{
    [WebRequest ComSpace_Admin_ComSpaceDaily_Get_ComSpaceDailyWithcompanyId:self.comId page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            page = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)loadReuquestData3{
    [WebRequest ComSpace_Get_ComSpaceCultureWithcompanyId:self.comId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_culture = [WS_ArticleComModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [tableV3 reloadData];
        }
    }];
}
-(void)loadMoreData{
 
}

-(void)loadRequestData1{
    [WebRequest ComSpace_ComSpaceProduct_Get_ComSpaceProductWithcompanyId:self.comId page:@"0" And:^(NSDictionary *dic) {
        [tableV1.mj_header endRefreshing];
        [tableV1.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model1 removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            page1 = dic[@"page"];
            for(int i=0;i<tarr.count;i++)
            {
                SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height = 60;
                [arr_model1 addObject:model];
            }
            [tableV1 reloadData];
            
        }
    }];
}
-(void)loadMoreData1{
    [WebRequest ComSpace_ComSpaceProduct_Get_ComSpaceProductWithcompanyId:self.comId page:page1 And:^(NSDictionary *dic) {
        [tableV1.mj_header endRefreshing];
        [tableV1.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV1.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page1 = dic[@"page"];
            for(int i=0;i<tarr.count;i++)
            {
                SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height = 60;
                [arr_model1 addObject:model];
            }
            [tableV1 reloadData];
            }
            
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user= [WebRequest GetUserInfo];
    self.navigationItem.title = @"企业信息";
    headScrolltitle  = [[FBHeadScrollTitleView alloc]init];
    headScrolltitle.backgroundColor = [UIColor whiteColor];
    [headScrolltitle setArr_titles:@[@"日志",@"产品信息",@"企业信息",@"企业文化",@"留言",@"招聘需求",@"采购需求",@"设备需求",@"二手资源"]];
    headScrolltitle.delegate_head = self;
    headScrolltitle.frame = CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    [self.view addSubview:headScrolltitle];
    arr_model  =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //留言
    arr_model4  =[NSMutableArray arrayWithCapacity:0];
    page4 = @"0";
    tableV4 = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV4, self);
    tableV4.delegate=self;
    tableV4.dataSource=self;
    [self.view addSubview:tableV4];
    tableV4.rowHeight=60;
    tableV4.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData4)];
    tableV4.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData4)];
    
    tlabel4 = [[UILabel alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-40-kBottomSafeHeight, DEVICE_WIDTH, 40)];
    tlabel4.backgroundColor = EQDCOLOR;
    [self.view addSubview:tlabel4];
    tlabel4.userInteractionEnabled = YES;
    tlabel4.layer.masksToBounds =YES;
    tlabel4.layer.cornerRadius =6;
    tlabel4.font =[UIFont systemFontOfSize:17];
    tlabel4.textColor = [UIColor whiteColor];
    tlabel4.textAlignment = NSTextAlignmentCenter;
    tlabel4.text = @"给企业留言……";
    UITapGestureRecognizer  *tap_liuyan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_liuyanClick)];
    [tlabel4 addGestureRecognizer:tap_liuyan];
    
    ///企业文化
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV3, self);
    tableV3.delegate=self;
    tableV3.dataSource=self;
    [self.view addSubview:tableV3];
    tableV3.rowHeight=60;
    model_culture  = nil;
    ///企业信息
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV2, self);
    tableV2.delegate=self;
    tableV2.dataSource=self;
    [self.view addSubview:tableV2];
    tableV2.rowHeight=60;
    model_info  = nil;
    img_Height=60;
    text_height =60;
    contact_height =60;
    
    //产品信息
    arr_model1 = [NSMutableArray arrayWithCapacity:0];
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV1, self);
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [self.view addSubview:tableV1];
    tableV1.rowHeight=60;
    tableV1.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData1)];
    tableV1.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData1)];
    
    [self setHiddenView];
    tableV.hidden =NO;
    
    
}
-(void)getPresnetText:(NSString *)text
{
    //留言
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在留言";
    [WebRequest ComSpace_ComSpaceLeaveMessage_Add_ComSpaceLeaveMessageWithuserGuid:user.Guid userCompanyId:user.companyId message:text parentId:@"0" companyId:self.comId parentUserGuid:@" " firstCommentId:@"0" And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            
            if ([dic[Y_STATUS] integerValue]==200) {
                WS_liuYanModel  *model = [WS_liuYanModel  mj_objectWithKeyValues:dic[Y_ITEMS]];
                [arr_model4 insertObject:model atIndex:0];
                [tableV4  reloadData];
            }
        });
    }];
}
-(void)tap_liuyanClick
{
    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.btnName = @"留言";
    LYvc.placeHolder = @"给企业留言……";
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    LYvc.delegate =self;
    [self presentViewController:LYvc animated:NO completion:nil];
}
-(void)setHiddenView{
    tableV.hidden =YES;
    tableV4.hidden =YES;
    tlabel4.hidden = YES;
    tableV3.hidden =YES;
    tableV2.hidden =YES;
    tableV1.hidden =YES;
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableV3 ==tableView || tableV2 ==tableView) {
        return 40;
    }else
    {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV == tableView) {
        EQDR_articleListModel  *model = arr_model[indexPath.row];
        return model.cellHeight;
    }else if (tableV4 ==tableView)
    {
        WS_liuYanModel *Model = arr_model4[indexPath.row];
        return Model.cell_height;
    }else if (tableV3 == tableView)
    {
        if (indexPath.section ==0) {
            ///核心价值
            Image_textModel  *tmodel = model_culture.ComCoreValues[indexPath.row];
            return tmodel.cell_height==0?60:tmodel.cell_height;
        }else if (indexPath.section==1)
        {
            //领导活动
            Image_textModel  *tmodel = model_culture.ComActitivies[indexPath.row];
            return tmodel.cell_height==0?60:tmodel.cell_height;
            
        }else if (indexPath.section ==2)
        {
            Image_textModel  *tmodel = model_culture.ComEvent[indexPath.row];
            return tmodel.cell_height==0?60:tmodel.cell_height;
            //先进事迹
        }else if(indexPath.section ==3)
        {
            SC_TeamModel  *tmodel = model_culture.ComGoodStaff[indexPath.row];
             return tmodel.cell_height==0?60:tmodel.cell_height;
            ///荣誉墙
        }else
        {
            
            return 60;
        }
    }else if (tableView ==tableV2)
    {
        if (indexPath.section==0) {
            //企业图片+ 企业描述
            if (indexPath.row==0) {
                return img_Height;
            }else if (indexPath.row ==1)
            {
                return text_height;
            }else
            {
                return 60;
            }
           
        }else if(indexPath.section ==1)
        {
            //设备信息
            WS_equipmentModel *tmodel = model_info.ComEquipment[indexPath.row];
            return tmodel.cell_height;
        }else if (indexPath.section ==2)
        {
            //组织机构
            Image_textModel *tmodel = model_info.ComOrganization[indexPath.row];
            return tmodel.cell_height;
        }else if (indexPath.section ==3)
        {
            //团队成员
            SC_TeamModel *tmodel = model_info.ComTeam[indexPath.row];
            return tmodel.cell_height;
        }else if (indexPath.section == 4)
        {
            //联系方式
            return contact_height;
        }else
        {
            return 60;
        }
    }else if (tableV1 == tableView)
    {
        return 110;
    }
    else
    {
        return 60;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableV3 == tableView) {
        NSArray *tarr =@[@"核心价值",@"领导活动",@"先进事迹",@"荣誉墙"];
        UIView *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
        tview.userInteractionEnabled =YES;
        tview.backgroundColor = [UIColor whiteColor];
        UILabel *tlabel_center = [[UILabel alloc]init];
        tlabel_center.font = [UIFont systemFontOfSize:18 weight:3];
        tlabel_center.textAlignment = NSTextAlignmentCenter;
        tlabel_center.text = tarr[section];
        [tview addSubview:tlabel_center];
        [tlabel_center mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.mas_equalTo(tview.mas_centerX);
            make.centerY.mas_equalTo(tview.mas_centerY);
        }];
        
        UILabel *tlabel_right = [[UILabel alloc]init];
        tlabel_right.font = [UIFont systemFontOfSize:15];
        tlabel_right.textAlignment = NSTextAlignmentRight;
        tlabel_right.textColor = EQDCOLOR;
        tlabel_right.userInteractionEnabled =YES;
        FBindexTapGestureRecognizer  *tap_right = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_rightCLick:)];
        tap_right.index = section;
        [tlabel_right addGestureRecognizer:tap_right];
        
        tlabel_right.text = @"更多";
        [tview addSubview:tlabel_right];
        [tlabel_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.right.mas_equalTo(tview.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(tview.mas_centerY);
        }];
        return tview;
    }else if (tableView ==tableV2)
    {
        NSArray *tarr =@[@"企业简介",@"设备信息",@"组织机构",@"团队成员",@"联系方式"];
        UIView *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
        tview.userInteractionEnabled =YES;
        tview.backgroundColor = [UIColor whiteColor];
        UILabel *tlabel_center = [[UILabel alloc]init];
        tlabel_center.font = [UIFont systemFontOfSize:18 weight:3];
        tlabel_center.textAlignment = NSTextAlignmentCenter;
        tlabel_center.text = tarr[section];
        [tview addSubview:tlabel_center];
        [tlabel_center mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.mas_equalTo(tview.mas_centerX);
            make.centerY.mas_equalTo(tview.mas_centerY);
        }];
        if(section ==1 || section ==3){
        UILabel *tlabel_right = [[UILabel alloc]init];
        tlabel_right.font = [UIFont systemFontOfSize:15];
        tlabel_right.textAlignment = NSTextAlignmentRight;
        tlabel_right.textColor = EQDCOLOR;
        tlabel_right.userInteractionEnabled =YES;
        FBindexTapGestureRecognizer  *tap_right = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_rightCLick_info:)];
        tap_right.index = section;
        [tlabel_right addGestureRecognizer:tap_right];
        
        tlabel_right.text = @"更多";
        [tview addSubview:tlabel_right];
        [tlabel_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.right.mas_equalTo(tview.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(tview.mas_centerY);
        }];
        }
        return tview;
    }
    else
    {
    return nil;
    }
}

-(void)tap_rightCLick_info:(FBindexTapGestureRecognizer*)tap{
    if (tap.index ==1) {
        //设备信息
        SC_EqitmentShowViewController *Svc =[[SC_EqitmentShowViewController alloc]init];
        Svc.comId =self.comId;
        [self.navigationController pushViewController:Svc animated:NO];
        
    }else if(tap.index ==3)
    {
        //团队成员
        SC_TeamPersonViewController *TVc = [[SC_TeamPersonViewController alloc]init];
        TVc.comId =self.comId;
        TVc.temp =0;
        [self.navigationController pushViewController:TVc animated:NO];
    }else
    {
        
    }
        
}
-(void)tap_rightCLick:(FBindexTapGestureRecognizer*)tap{
    switch (tap.index) {
        case 0:
        {
            //核心价值观
            SC_CenterViewController  *Cvc = [[SC_CenterViewController alloc]init];
            Cvc.temp =1;
            Cvc.comId =self.comId;
            [self.navigationController pushViewController:Cvc animated:NO];
        }
            break;
        case 1:
        {
            SC_activeAndEventViewController *AEvc =[[SC_activeAndEventViewController alloc]init];
            AEvc.temp = 0;
            AEvc.comId =self.comId;
            [self.navigationController pushViewController:AEvc animated:NO];
        }
            break;
        case 2:
        {
            SC_activeAndEventViewController *AEvc =[[SC_activeAndEventViewController alloc]init];
            AEvc.temp = 1;
            AEvc.comId =self.comId;
            [self.navigationController pushViewController:AEvc animated:NO];
        }
            break;
        case 3:
        {
            SC_TeamPersonViewController  *Tvc =[[SC_TeamPersonViewController alloc]init];
            Tvc.temp=2;
            Tvc.comId =self.comId;
            [self.navigationController pushViewController:Tvc animated:NO];
        }
            break;
            
        default:
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == tableV) {
        return 1;
    }else if (tableView ==tableV4)
    {
        return 1;
    }else if (tableV3 ==tableView && model_culture!=nil)
    {
        return 4;
    }else if (tableV2 ==tableView && model_info !=nil)
    {
        return 5;
    }
    else
    {
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableV == tableView) {
        return arr_model.count;
    }else if (tableView ==tableV4)
    {
        return arr_model4.count;
    }else if (tableV3 ==tableView && model_culture!=nil)
    {
        if (section ==0) {
            return model_culture.ComCoreValues.count;
        }else if (section ==1)
        {
            return model_culture.ComActitivies.count;
        }else if (section==2)
        {
            return model_culture.ComEvent.count;
        }else if (section ==3)
        {
            return model_culture.ComGoodStaff.count;
        }else
        {
            return 0;
        }
    }else if (tableV2 ==tableView)
    {
        if (section==0 &&model_info!=nil) {
            if (model_info.ComImage.count!=0 && model_info.comDesc.length !=0) {
                return 2;
            }
            else
            {
                return 0;
            }
           
        }else if (section==1)
        {
            return model_info.ComEquipment.count;
        }else if (section ==2)
        {
            return model_info.ComOrganization.count;
        }else if (section==3)
        {
            return model_info.ComTeam.count;
        }else if(section==4 && model_info !=nil)
        {
            if (model_info.ComCotact!=nil) {
                return 1;
            }else
            {
                return 0;
            }
           
        }
        
        else
        {
            return 0;
        }
        
    }else if (tableView ==tableV1)
    {
        return arr_model1.count;
    }
    else
    {
    return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableV ==tableView) {
    static NSString *cellId=@"cellID";
    EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
        EQDR_articleListModel  *model = arr_model[indexPath.row];
        [cell.IV_head sd_setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        
        
        
        cell.YL_name.text = model.upname;
        cell.L_time.text = model.createTime;
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:3]}];
        name.yy_alignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"   %@",model.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [name appendAttributedString:contents];
        cell.YL_titleContent.attributedText = name;
        CGSize size1 = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model.cellHeight =50+size1.height+10;
        [cell.YL_titleContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size1.height+5);
            make.top.mas_equalTo(cell.V_top.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        }];
        
        [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"imageerro"]];
        [cell.IV_img mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH-30, (DEVICE_WIDTH-30)/2.0));
            make.top.mas_equalTo(cell.YL_titleContent.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        }];
        model.cellHeight = model.cellHeight +(DEVICE_WIDTH-30)/2.0+5;
        cell.V_bottomThree.hidden =NO;
        [cell.V_bottomThree setread:model.browseCount liuyan:model.commentCount zan:model.zanCount];
        model.cellHeight = model.cellHeight+45;
       
        
       
        
        
        NSArray *tarr = [model.lable componentsSeparatedByString:@","];
        NSMutableAttributedString *label = [[NSMutableAttributedString alloc]initWithString:@"  " attributes:nil];
        
        for (int i=0; i<tarr.count; i++) {
            NSMutableAttributedString  *tlabel = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@  ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
            
            [tlabel yy_setTextBorder:[YYTextBorder borderWithLineStyle:(YYTextLineStyleSingle) lineWidth:1 strokeColor:[UIColor orangeColor]] range:tlabel.yy_rangeOfAll];
            [tlabel yy_setTextHighlightRange:tlabel.yy_rangeOfAll color:nil backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                EQDR_ArticleClassSearchViewController  *Cvc =[[EQDR_ArticleClassSearchViewController alloc]init];
                Cvc.searchKey = tlabel.string;
                Cvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:Cvc animated:NO];
            }];
            
            
            [label appendAttributedString:tlabel];
            
            NSMutableAttributedString *kongge = [[NSMutableAttributedString alloc]initWithString:@"   " attributes:nil];
            [label appendAttributedString:kongge];
        }
        
        CGSize size2 = [label boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model.cellHeight = model.cellHeight+20;
        cell.YL_hangye.attributedText = label;
        [cell.YL_hangye mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size2.height+5);
            make.bottom.mas_equalTo(cell.V_bottomThree.mas_top).mas_offset(-5);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        }];
        
    return cell;
    }else if (tableView ==tableV4)
    {
        static NSString *cellId=@"cellID4";
        WS_LiuYanTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[WS_LiuYanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        WS_liuYanModel  *model = arr_model4[indexPath.row];
        [cell setModel_liuyan:model];
        
        FBindexTapGestureRecognizer *tap_head = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_headClick:)];
        tap_head.indexPath =indexPath;
        [cell.V_top.IV_head addGestureRecognizer:tap_head];
        return cell;
    }else if (tableV3 == tableView)
    {
        if(indexPath.section ==0)
        {
        static NSString *cellId=@"cellID30";
        FBImage_textFullTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBImage_textFullTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            Image_textModel  *model = model_culture.ComCoreValues[indexPath.row];
            [cell setModel_center:model];
        return cell;
        }else if (indexPath.section ==1 || indexPath.section ==2)
        {
            static NSString *cellId=@"cellID31";
            FBLabel_YYAddTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            Image_textModel  *model  =nil;
            if (indexPath.section ==1) {
                model =model_culture.ComActitivies[indexPath.row];
            }else if (indexPath.section ==2)
            {
                model = model_culture.ComEvent[indexPath.row];
            }
           
            NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.title]attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            NSMutableAttributedString  *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
            time.yy_alignment = NSTextAlignmentRight;
            [contents appendAttributedString:time];
            contents.yy_lineSpacing = 6;
            cell.YL_content.attributedText  =contents;
            CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            model.cell_height = size.height+20;
            [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+10);
                make.centerY.mas_equalTo(cell.mas_centerY);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            }];
            return cell;
        }else if (indexPath.section ==3)
        {
            static NSString *cellId=@"cellID33";
            SC_teamMiaoshuTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[SC_teamMiaoshuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            SC_TeamModel *model =model_culture.ComGoodStaff[indexPath.row];
            [cell setModel_team:model];
            return cell;
        }
        else
        {
            return nil;
        }
    }
    else if (tableV2 ==tableView)
    {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                static NSString *cellId=@"cellID20";
                UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.textLabel.font = [UIFont systemFontOfSize:18];
                }
                FBScrollView *ScrollV = [[FBScrollView alloc]initWithFrame:CGRectMake(15, 5, DEVICE_WIDTH-30, (DEVICE_WIDTH-30)/2.0)];
                NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
                for (int i=0; i<model_info.ComImage.count; i++) {
                    Image_textModel *model = model_info.ComImage[i];
                    [tarr addObject:model.imgUrl];
                }
                [ScrollV setArr_urls:tarr];
                [cell addSubview:ScrollV];
                
                img_Height =(DEVICE_WIDTH-30)/2.0+10;
                return cell;
            }else if (indexPath.row==1)
            {
                static NSString *cellId = @"cellid11";
                UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    NSString * htmlString =[NSString stringWithFormat:@"<html><body style = \"font-size:17px\">%@ </body></html>",model_info.comDesc] ;
                    
                    CGSize size = [htmlString boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, 60)];
                    webView.scrollView.scrollEnabled =NO;
                    [webView loadHTMLString:htmlString baseURL:nil];
                    webView.delegate =self;
                    [cell addSubview:webView];
                    text_height =size.height+10;
                }
              
                
                return cell;
            }else
            {
                return nil;
            }
        }else if (indexPath.section ==1)
        {
            ///设备信息
            static NSString *cellId=@"cellID21";
            SC_teamMiaoshuTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[SC_teamMiaoshuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            WS_equipmentModel  *tmodel = model_info.ComEquipment[indexPath.row];
            [cell setModel_equipment:tmodel];
            
            return cell;
        }else if (indexPath.section ==2)
        {
            //组织机构
            static NSString *cellId=@"cellID22";
            FBImage_textFullTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FBImage_textFullTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            Image_textModel  *tmodel = model_info.ComOrganization[indexPath.row];
            [cell setModel_imgText:tmodel];
            return cell;
        }else if (indexPath.section == 3)
        {
            ///团队成员
            static NSString *cellId=@"cellID23";
            SC_teamMiaoshuTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[SC_teamMiaoshuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            SC_TeamModel  *tmodel = model_info.ComTeam[indexPath.row];
            [cell setModel_team:tmodel];
            
            return cell;
        }else if (indexPath.section ==4)
        {
            //联系方式
            FBLabel_YYAddTableViewCell  *cell = [[FBLabel_YYAddTableViewCell alloc]init];
            NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"联系人：%@\n联系方式：",model_info.ComCotact.Contacts] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
            NSMutableAttributedString *phone =[[NSMutableAttributedString alloc]initWithString:model_info.ComCotact.ContactNumber attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            [phone yy_setTextHighlightRange:phone.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model_info.ComCotact.ContactNumber];
                UIWebView *callWebView = [[UIWebView alloc] init];
                [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebView];
            }];
            
            [contents appendAttributedString:phone];
            
            NSMutableAttributedString *ohter = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n固定电话：%@\n企业邮箱：%@\n通讯地址：%@",model_info.ComCotact.SeatMachine,model_info.ComCotact.Email,model_info.ComCotact.Address] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [contents appendAttributedString:ohter];
            contents.yy_lineSpacing =6;
            cell.YL_content.attributedText =contents;
            CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+10);
                make.centerY.mas_equalTo(cell.mas_centerY);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            }];
            contact_height = size.height+20;
            return cell;
            
            
        }
        else
        {
            return nil;
        }
    }else if (tableView ==tableV1)
    {
        static NSString  *cellId = @"cellid11";
        SC_productTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[SC_productTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        SC_productModel  *model = arr_model1[indexPath.row];
        [cell setModel_product:model];
        return cell;
    }
    else{
        return nil;
    }
}

-(void)tap_headClick:(FBindexTapGestureRecognizer*)tap{
    WS_liuYanModel  *model = arr_model4[tap.indexPath.row];
    PPersonCardViewController *Pvc = [[PPersonCardViewController alloc]init];
    Pvc.userGuid = model.creater;
    [self.navigationController pushViewController:Pvc animated:NO];
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableV == tableView)
    {
        EQDR_articleListModel  *model =arr_model[indexPath.row];
        EQDR_Article_DetailViewController  *Dvc =[[EQDR_Article_DetailViewController alloc]init];
        Dvc.articleId =model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
    }
     else  if(tableView == tableV1)
    {
        SC_productModel *model = arr_model1[indexPath.row];
        SC_productDetailViewController  *Dvc = [[SC_productDetailViewController alloc]init];
        Dvc.equipmentId = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (tableV3 == tableView)
    {
        if (indexPath.section ==1) {
            ///领导活动
            Image_textModel  *tmodel= model_culture.ComActitivies[indexPath.row];
            FBWebUrlViewController *Wvc = [[FBWebUrlViewController alloc]init];
            Wvc.url = [EQD_HtmlTool getActiveFromLingdaoWithId:tmodel.Id];
            Wvc.contentTitle = @"领导活动";
            [self.navigationController pushViewController:Wvc animated:NO];
            
        }else if (indexPath.section ==2)
        {
            ///先进事迹
            Image_textModel *tmodel =model_culture.ComEvent[indexPath.row];
            FBWebUrlViewController *Wvc= [[FBWebUrlViewController alloc]init];
            Wvc.url = [EQD_HtmlTool getEventDetailWithId:tmodel.Id];
            Wvc.contentTitle = @"先进事迹";
            [self.navigationController pushViewController:Wvc animated:NO];
        }else
        {
            
        }
    }
     else{
        
    }
}




@end
