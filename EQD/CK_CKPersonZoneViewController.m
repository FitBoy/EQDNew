//
//  CK_CKPersonZoneViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define height_img  ([UIScreen mainScreen].bounds.size.width-40)/3.0

#import "CK_CKPersonZoneViewController.h"
#import "FBHeadScrollTitleView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "FBButton.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "WS_liuYanModel.h"
#import "WS_LiuYanTableViewCell.h"
#import "PPersonCardViewController.h"
#import "EQDR_ArticleTableViewCell.h"
#import <Masonry.h>
#import "SC_fangKeTableViewCell.h"
#import "EQDR_ArticleClassSearchViewController.h"
#import "CK_picturesPersonViewController.h"
#import "EQDR_Article_DetailViewController.h"
#import "CK_courseViewController.h"
@interface CK_CKPersonZoneViewController ()<UITableViewDelegate,UITableViewDataSource,FBHeadScrollTitleViewDelegate,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    Com_UserModel *model_user;
    UIView *head_view;
    FBHeadScrollTitleView *titleV;
    UILabel *L_numShoucang;
    
    NSInteger  selected_index;
   // @"日志",@"产品",@"相册",@"留言",@"访客",@"收藏"
    NSMutableArray *arr_model_rizhi;
    NSString *page_rizhi;
    NSMutableArray *arr_products;
    NSMutableArray *arr_pictures;
    NSMutableArray *arr_liuyan;
    NSString *page_liuyan;
    NSMutableArray *arr_fangke;
    NSString *page_fangke;
    NSMutableArray *arr_shoucang;
    FBButton *tbtn_liuyan;
    NSArray *arr_big;
    float scrollY;
    UserModel *user;
}

@end

@implementation CK_CKPersonZoneViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [WebRequest Com_User_BusinessCardWithuserGuid:self.userGuid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue] == 200) {
            model_user = [Com_UserModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setHeadViewWithuserModel:model_user];
            });
            
        }
    }];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WebRequest Makerspacey_MakerVisitor_Add_MakerVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"创客空间" makerGuid:self.userGuid option:@"访问了您的创客空间" And:^(NSDictionary *dic) {
            
        }];
    });
}
-(void)loadRequestData{
     tbtn_liuyan.hidden =YES;
    if (selected_index ==3) {
        [WebRequest Makerspacey_MakerLeaveMsg_Get_MakerLeaveMsgWithmakerGuid:self.userGuid page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page_liuyan = dic[@"page"];
                [arr_liuyan removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    WS_liuYanModel  *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                    [arr_liuyan addObject:model];
                }
                [tableV reloadData];
                tbtn_liuyan.hidden =NO;
            }
        }];
    }else if (selected_index ==0)
    {
        //日志
        [WebRequest Articles_Get_MyArticleWithuserGuid:self.userGuid page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model_rizhi removeAllObjects];
                NSDictionary *tdic =dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                page_rizhi = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDR_articleListModel *model = [EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model_rizhi addObject:model];
                    
                }
                [tableV reloadData];
            }
        }];
    }else if (selected_index ==4)
    {
        //访客
        [WebRequest Makerspacey_MakerVisitor_Get_MakerVisitorWithmakerGuid:self.userGuid page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page_fangke = dic[@"page"];
                [arr_fangke removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    SC_fangKeModel  *model = [SC_fangKeModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height = 60;
                    [arr_fangke addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
    }
    else
    {
        
    }
}
-(void)loadMoreData{
    if (selected_index ==3) {
        [WebRequest Makerspacey_MakerLeaveMsg_Get_MakerLeaveMsgWithmakerGuid:self.userGuid page:page_liuyan And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page_liuyan = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    WS_liuYanModel  *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                    [arr_liuyan addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (selected_index ==0)
    {
        [WebRequest  Articles_Get_MyArticleWithuserGuid:self.userGuid page:page_rizhi And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic =dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page_rizhi = tdic[@"page"];
                    for (int i=0; i<tarr.count; i++) {
                        EQDR_articleListModel *model = [EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model_rizhi addObject:model];
                        
                    }
                    [tableV reloadData];
                }
            }
        }];
    }else if (selected_index ==4)
    {
        //访客
        [WebRequest Makerspacey_MakerVisitor_Get_MakerVisitorWithmakerGuid:self.userGuid page:page_fangke And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page_fangke = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    SC_fangKeModel  *model = [SC_fangKeModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height = 60;
                    [arr_fangke addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
        
    }
    
    else
    {
        
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)shoucangTbtnClick:(FBButton*)tbtn
{
    //收藏
    [WebRequest Makerspacey_MakerCollection_Add_MakerCollectionWithuserCompanyId:user.companyId objectId:@"0" objectType:@"3" objectGuid:self.userGuid objectCompanyId:@"0" userGuid:user.Guid  And:^(NSDictionary *dic) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"收藏成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tbtn setTitle:@"已收藏" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
            });
        }else
        {
            [alert showAlertWith:@"服务器错误，请重试！"];
        }
    }];
}
-(void)setHeadViewWithuserModel:(Com_UserModel*)tmodel{

    head_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 100)];
    head_view.userInteractionEnabled =YES;
    UIImageView *IV_image= [[UIImageView alloc]init];
    [IV_image sd_setImageWithURL:[NSURL URLWithString:tmodel.photo] placeholderImage:[UIImage imageNamed:@"eqd"]];
    [head_view addSubview:IV_image];
    [IV_image  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(head_view.mas_left).mas_offset(15);
        make.top.mas_equalTo(head_view.mas_top).mas_offset(5);
    }];
    
    
    FBButton  *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    [head_view addSubview:tbtn];
    [tbtn addTarget:self action:@selector(shoucangTbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [tbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.right.mas_equalTo(head_view.mas_right).mas_offset(-15);
        make.top.mas_equalTo(head_view.mas_top).mas_offset(10);
    }];
    [tbtn setTitle:@"收藏" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:15]];
    titleV   = [[FBHeadScrollTitleView alloc]init];
    [head_view addSubview:titleV];
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.right.mas_equalTo(head_view);
        make.bottom.mas_equalTo(head_view.mas_bottom).mas_offset(-5);
    }];
    titleV.delegate_head = self;
    [titleV setArr_titles:@[@"日志",@"产品",@"相册",@"留言",@"访客"]];
    //,@"收藏"
    [titleV setClickTapIndex:0];
    
    
    
    //名字
    UILabel *L_name = [[UILabel alloc]init];
    [head_view addSubview:L_name];
    [L_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.left.mas_equalTo(IV_image.mas_right).mas_offset(5);
        make.top.mas_equalTo(IV_image.mas_top);
        make.right.mas_equalTo(tbtn.mas_left).mas_offset(-5);
    }];
    L_name.text = tmodel.username;
    L_name.font = [UIFont systemFontOfSize:15];
    
    L_numShoucang = [[UILabel alloc]init];
    [head_view addSubview:L_numShoucang];
    L_numShoucang.font = [UIFont systemFontOfSize:12];
    L_numShoucang.textColor = [UIColor grayColor];
    L_numShoucang.text = @"0人收藏";
    [L_numShoucang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(IV_image.mas_right).mas_offset(5);
        make.right.mas_equalTo(tbtn.mas_left).mas_offset(-5);
        make.bottom.mas_equalTo(IV_image.mas_bottom);
    }];
    
    tableV.tableHeaderView = head_view;
    
    [WebRequest Lectures_LectureInfo_Get_CountWithuserGuid:self.userGuid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            dispatch_async(dispatch_get_main_queue(), ^{
             L_numShoucang.text = [NSString stringWithFormat:@"%@人收藏",tdic[@"collectionCount"]];
            });
            
        }
    }];
    
    [WebRequest Makerspacey_MakerCollection_Get_CollectionStatusWithuseGuid:user.Guid maker:self.userGuid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            if ([dic[Y_ITEMS] integerValue] ==0) {
                
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
               [tbtn setTitle:@"已收藏" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
                });
               
            }
        }
    }];
   
    if ([user.Guid isEqualToString:self.userGuid]) {
        tbtn.hidden = YES;
    }
    
}
-(void)getSelectedIndex:(NSInteger)index
{
    ///选中的是哪个模块
    selected_index = index;
    [tableV.mj_footer endRefreshing];
    switch (index) {
        case 0:
        {
            //日志
            if (arr_model_rizhi.count ==0) {
                [self loadRequestData];
            }else
            {
                [tableV reloadData];
            }
        }
            break;
        case 1:
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [WebRequest Makerspacey_MakerVisitor_Add_MakerVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"产品列表" makerGuid:self.userGuid option:@"访问了您的产品列表" And:^(NSDictionary *dic) {
                    
                }];
            });
            
            
            CK_courseViewController  *CCvc = [[CK_courseViewController alloc]init];
            CCvc.userGuid = self.userGuid;
            CCvc.username = model_user.username;
            [self.navigationController pushViewController:CCvc animated:NO];
            
     /* if (arr_products.count ==0) {
                [self loadRequestData];
            }else
            {
                [tableV reloadData];
            }*/
        }
            break;
        case 2:
        {
            //相册
            CK_picturesPersonViewController  *PPvc =[[CK_picturesPersonViewController alloc]init];
            PPvc.userGuid = self.userGuid;
            PPvc.userName = model_user.username;
            [self.navigationController pushViewController:PPvc animated:NO];
        }
            break;
        case 3:
        {
            //留言
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [WebRequest Makerspacey_MakerVisitor_Add_MakerVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"留言" makerGuid:self.userGuid option:@"访问了您的创客留言" And:^(NSDictionary *dic) {
                    
                }];
            });
            if(arr_liuyan.count ==0)
            {
                
                [self loadRequestData];
            }else
            {
                [tableV reloadData];
            }
        }
            break;
        case 4:
        {//访客
          if(arr_fangke.count ==0)
             {
                 [self loadRequestData];
             }else
             {
                 [tableV reloadData];
             }
        }
            break;
        case 5:
        {
            ///收藏
            if (arr_shoucang.count ==0) {
                [self loadRequestData];
            }else
            {
                [tableV reloadData];
            }
        }
            break;
        default:
            break;
    }
   
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page_fangke = @"0";
    scrollY =0;
    user = [WebRequest GetUserInfo];
  arr_model_rizhi = [NSMutableArray arrayWithCapacity:0];
   arr_products= [NSMutableArray arrayWithCapacity:0];
    arr_pictures= [NSMutableArray arrayWithCapacity:0];
    arr_liuyan= [NSMutableArray arrayWithCapacity:0];
    arr_fangke= [NSMutableArray arrayWithCapacity:0];
    arr_shoucang= [NSMutableArray arrayWithCapacity:0];
    arr_big = @[arr_model_rizhi,arr_products,arr_pictures,arr_liuyan,arr_fangke,arr_shoucang];
    self.navigationItem.title = @"个人的创客空间";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    tbtn_liuyan = [[FBButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-kBottomSafeHeight-40, DEVICE_WIDTH, 40)];
    [tbtn_liuyan setTitle:@"留言" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:21]];
    [tbtn_liuyan addTarget:self action:@selector(tbtnLiuyanCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tbtn_liuyan];
    tbtn_liuyan.hidden = YES;
     [self loadRequestData];
    
   
}
#pragma  mark - 留言
-(void)getPresnetText:(NSString *)text
{
    [WebRequest Makerspacey_MakerLeaveMsg_Add_MakerLeaveMsgWithuserGuid:user.Guid userCompanyId:user.companyId message:text parentId:@"0" makerGuid:self.userGuid parentUserGuid:@" " firstCommentId:@"0" objectId:@"0" objectType:@"0" And:^(NSDictionary *dic) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"留言成功"];
        }else
        {
            [alert showAlertWith:@"服务器错误，请重试！"];
        }
    }];
}
#pragma  mark - 弹出留言框
-(void)tbtnLiuyanCLick
{
    FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.delegate =self;
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    LYvc.btnName = @"发送";
    LYvc.placeHolder = @"想对他(她)说什么……";
    [self presentViewController:LYvc animated:NO completion:nil];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (selected_index) {
        case 0:
        {
           return  arr_model_rizhi.count;
        }
            break;
        case 1:
        {
            return arr_products.count;
        }
            break;
        case 2:
        {
            return arr_pictures.count;
        }
            break;
        case 3:
        {
            return arr_liuyan.count;
        }
            break;
        case 4:
        {
            return arr_fangke.count;
        }
            break;
        case 5:
        {
            return arr_shoucang.count;
        }
            break;
            
        default:
        {
            return 0;
        }
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selected_index ==3) {
        WS_liuYanModel  *model =arr_liuyan[indexPath.row];
        return model.cell_height;
    }else if (selected_index == 0)
    {
        EQDR_articleListModel  *model = arr_model_rizhi[indexPath.row];
        return model.cellHeight;
    }else if (selected_index ==4)
    {
        SC_fangKeModel  *model = arr_fangke[indexPath.row];
        return model.cell_height;
    }
    else
    {
        return 60;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selected_index ==3) {
        static NSString *cellId=@"cellID3";
        WS_LiuYanTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[WS_LiuYanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        WS_liuYanModel  *model =arr_liuyan[indexPath.row];
        [cell setModel_liuyan:model];
        return cell;
    }else if (selected_index ==0)
    {
        static NSString *cellId=@"cellID";
        EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        EQDR_articleListModel *model =arr_model_rizhi[indexPath.row];
        float height_cell = 50;
        [cell.IV_head sd_setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        cell.YL_name.text = model.upname,
        cell.L_time.text= model.createTime;
        cell.IV_fenXiang.image =[UIImage imageNamed:@"ic_arrow"];
        NSMutableAttributedString  *title = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        title.yy_alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:model.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [title appendAttributedString:content];
        title.yy_lineSpacing=6;
        
        if (model.image.length>1) {
            [cell.IV_img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(height_img, height_img));
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.top.mas_equalTo(cell.V_top.mas_bottom).mas_offset(3);
            }];
            
            [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [cell.YL_titleContent  mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height_img);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.left.mas_equalTo(cell.IV_img.mas_right).mas_offset(5);
                make.top.mas_equalTo(cell.V_top.mas_bottom).mas_offset(3);
            }];
            
            cell.YL_titleContent.attributedText = title;
            height_cell= height_cell+5+height_img;
        }else
        {
            [cell.IV_img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(0, 0));
            }];
            CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
            [cell.YL_titleContent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+5);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.top.mas_equalTo(cell.V_top.mas_bottom).mas_offset(3);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            }];
            height_cell = height_cell+size.height+5+5;
            cell.YL_titleContent.attributedText = title;
        }
        if (model.lable.length==0) {
            cell.YL_hangye.attributedText =nil;
            [cell.YL_hangye mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.bottom.mas_equalTo(cell.V_bottom.mas_top).mas_offset(-5);
            }];
        }else
        {
            //标签
            NSArray *tarrlabel = [model.lable componentsSeparatedByString:@","];
            NSMutableAttributedString  *label_str = [[NSMutableAttributedString alloc]initWithString:@" "];
            for (int i=0; i<tarrlabel.count; i++) {
                NSMutableAttributedString  *tlabelStr =[[NSMutableAttributedString alloc]initWithString:tarrlabel[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
                [tlabelStr yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:tlabelStr.yy_rangeOfAll];
                [tlabelStr yy_setTextHighlightRange:[tlabelStr yy_rangeOfAll] color:[UIColor grayColor] backgroundColor:[UIColor orangeColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    
                    //标签的点击事件
                    EQDR_ArticleClassSearchViewController  *Cvc =[[EQDR_ArticleClassSearchViewController alloc]init];
                    Cvc.searchKey = tlabelStr.string;
                    [self.navigationController pushViewController:Cvc animated:NO];
                }];
                [label_str appendAttributedString:tlabelStr];
                NSMutableAttributedString  *kongge = [[NSMutableAttributedString alloc]initWithString:@"  " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
                [label_str appendAttributedString:kongge];
            }
            
            cell.YL_hangye.attributedText =label_str;
            CGSize  size = [label_str boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            [cell.YL_hangye mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+5);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.bottom.mas_equalTo(cell.V_bottom.mas_top).mas_offset(-5);
            }];
            
            height_cell =height_cell+5+size.height+5;
        }
        //来源+评论
        NSMutableAttributedString  *soure = [[NSMutableAttributedString alloc]initWithString:@"来源:" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        NSMutableAttributedString *source_two = [[NSMutableAttributedString alloc]initWithString:model.source attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        [source_two yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:(YYTextLineStyleSingle) lineWidth:1 strokeColor:[UIColor orangeColor]] range:source_two.yy_rangeOfAll];
      
        [soure appendAttributedString:source_two];
        cell.L_source.attributedText =soure;
        cell.L_RPL.text = [NSString stringWithFormat:@"%@ 阅读 * %@ 评论 * %@ 喜欢",model.browseCount,model.commentCount,model.zanCount];
        
        height_cell= height_cell+35;
        model.cellHeight =height_cell;
        return cell;
    }else if (selected_index ==4)
    {
        //访客
        static NSString *cellId=@"cellID4";
        SC_fangKeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[SC_fangKeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        SC_fangKeModel  *model = arr_fangke[indexPath.row];
        [cell setModel_fangke:model];
        return cell;
    }
    else
    {
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selected_index ==0) {
        //日志
        EQDR_articleListModel  *model =arr_model_rizhi[indexPath.row];
        EQDR_Article_DetailViewController  *Dvc =[[EQDR_Article_DetailViewController alloc]init];
        Dvc.articleId =model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if ((scrollView.contentOffset.y < scrollY || scrollView.scrollsToTop==YES) && selected_index ==3) {
        //向上滑
        tbtn_liuyan.hidden = NO;
    }else
    {
        //向下
        tbtn_liuyan.hidden = YES;
    }
}






@end
