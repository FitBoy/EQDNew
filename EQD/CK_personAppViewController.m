//
//  CK_personAppViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/2.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define height_img  ([UIScreen mainScreen].bounds.size.width-40)/3.0


#import "CK_personAppViewController.h"
#import "R_RichTextEditor_ViewController.h"
#import "FBButton.h"
#import "FBTextVViewController.h"
#import "CK_hangyeViewController.h"
#import "CK_CKPersonZoneViewController.h"
#import "WS_LiuYanTableViewCell.h"
#import "FBindexTapGestureRecognizer.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "SC_fangKeTableViewCell.h"
#import "CK_picturesPersonViewController.h"
#import "CK_courseViewController.h"
#import "EQDR_ArticleTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "EQDR_ArticleClassSearchViewController.h"
#import "EQDR_Article_DetailViewController.h"
#import "CK_personInfoViewController.h"
#import "SC_ComShoucangViewController.h"
#import "CK_ShoucangProductViewController.h"
#import "CK_CourseShoucangViewController.h"
#import "CK_chuangkeShoucangViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "PXNeedDetailViewController.h"
#import "CK_huoDongListViewController.h"
@interface CK_personAppViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    UserModel *user;
    //主页
    UITableView *tableV1;
    NSMutableArray *arr_need;
    NSString *page_need;
    //日志
    UITableView *tableV2;
    FBButton *tbtn2 ;
    NSMutableArray *arr_rizhi2;
    NSString *page_rizhi2;
    ///产品
    UITableView *tableV3;
    NSArray *arr_names3;
    ///个人档
    UITableView *tableV4;
    NSArray *arr_names4;
    NSString *youshi_str;
    NSString *youshi_Id;
    //留言
    UITableView *tableV5;
    NSMutableArray *arr_model5;
    NSString *page5;
    NSIndexPath *indexpath5_selected;
    //访客
    UITableView *tableV6;
    NSString *page6;
    NSMutableArray *arr_model6;
    //收藏
    UITableView *tableV7;
    NSArray *arr_names7;
    
}

@end



@implementation CK_personAppViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    if (youshi_str.length == 0) {
        [WebRequest Makerspacey_Get_MakerAdvantageWithuserGuid:user.Guid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                dispatch_async(dispatch_get_main_queue(), ^{
                    youshi_str  = tdic[@"advantage"];
                    youshi_Id = tdic[@"Id"];
                });
               
            }
        }];
    }
}
-(void)loadRequestData{
    [WebRequest Training_TrainingMatch_Get_LectureTrainMatchWithlectureGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV1.mj_footer endRefreshing];
        [tableV1.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            page_need = dic[@"page"];
            [arr_need removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                [arr_need addObject:model];
            }
            [tableV1 reloadData];
        }
    }];
}
-(void)loadMoreData{
    [WebRequest Training_TrainingMatch_Get_LectureTrainMatchWithlectureGuid:user.Guid page:page_need And:^(NSDictionary *dic) {
        [tableV1.mj_footer endRefreshing];
        [tableV1.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV1.mj_footer endRefreshingWithNoMoreData];
            }
            page_need = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                [arr_need addObject:model];
            }
            [tableV1 reloadData];
        }
    }];
}

-(void)loadRequestData2{
    [WebRequest Articles_Get_MyArticleWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV2.mj_footer endRefreshing];
        [tableV2.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_rizhi2 removeAllObjects];
            NSDictionary *tdic =dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            page_rizhi2 = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel *model = [EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_rizhi2 addObject:model];
                
            }
            [tableV2 reloadData];
        }
    }];
}
-(void)loadMoreData2
{
    [WebRequest  Articles_Get_MyArticleWithuserGuid:user.Guid page:page_rizhi2 And:^(NSDictionary *dic) {
        [tableV2.mj_footer endRefreshing];
        [tableV2.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic =dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV2.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page_rizhi2 = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDR_articleListModel *model = [EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                    [arr_rizhi2 addObject:model];
                    
                }
                [tableV2 reloadData];
            }
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
#pragma  mark - 多行文本
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (youshi_str.length ==0) {
        //新增
        [WebRequest Makerspacey_Add_MakerSpaceWithuserGuid:user.Guid advantage:text And:^(NSDictionary *dic) {
            MBFadeAlertView *alert= [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"添加成功"];
                 youshi_str = text;
            }else
            {
                [alert showAlertWith:@"添加失败，请重试"];
            }
        }];
    }else if([youshi_Id integerValue]!=0 &&youshi_str.length!=0)
    {
        //修改
        [WebRequest Makerspacey_Update_MakerAdvantageWithuserGuid:user.Guid advantage:text atgId:youshi_Id And:^(NSDictionary *dic) {
            MBFadeAlertView *alert= [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"修改成功"];
                youshi_str = text;
            }else
            {
                [alert showAlertWith:@"修改失败，请重试"];
            }
        }];
    }else
    {
        
    }
}
-(void)loadRequestData5{
    [WebRequest Makerspacey_MakerLeaveMsg_Get_MakerLeaveMsgWithmakerGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV5.mj_header endRefreshing];
        [tableV5.mj_footer endRefreshing];
        [arr_model5 removeAllObjects];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            page5 = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                WS_liuYanModel *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                [arr_model5 addObject:model];
            }
            [tableV5 reloadData];
        }
    }];
}
-(void)loadMoreData5{
    [WebRequest Makerspacey_MakerLeaveMsg_Get_MakerLeaveMsgWithmakerGuid:user.Guid page:page5 And:^(NSDictionary *dic) {
        [tableV5.mj_header endRefreshing];
        [tableV5.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV5.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page5 = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                WS_liuYanModel *model = [WS_liuYanModel mj_objectWithKeyValues:tarr[i]];
                [arr_model5 addObject:model];
            }
            [tableV5 reloadData];
            }
        }
    }];
}
-(void)loadRequestData6{
    [WebRequest Makerspacey_MakerVisitor_Get_MakerVisitorWithmakerGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
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
    [WebRequest Makerspacey_MakerVisitor_Get_MakerVisitorWithmakerGuid:user.Guid page:page6 And:^(NSDictionary *dic) {
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
-(void)tableOtherinit{
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV1, self);
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [self.view addSubview:tableV1];
    tableV1.rowHeight=60;
//    tableV1.backgroundColor = [UIColor orangeColor];
    tableV1.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV1.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    arr_need = [NSMutableArray arrayWithCapacity:0];
    page_need = @"0";
    
    
    arr_rizhi2 = [NSMutableArray arrayWithCapacity:0];
    page_rizhi2 = @"0";
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV2, self);
    tableV2.delegate=self;
    tableV2.dataSource=self;
    [self.view addSubview:tableV2];
    tableV2.rowHeight=60;
    tbtn2 = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn2 setTitle:@"写日志 + " titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:19 weight:3]];
    [tbtn2 addTarget:self action:@selector(add_rizhiClick) forControlEvents:UIControlEventTouchUpInside];
   
    tableV2.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData2)];
    tableV2.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData2)];
    
    
    arr_names3 = @[@"讲师课程",@"活动"];
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV3, self);
    tableV3.delegate=self;
    tableV3.dataSource=self;
    [self.view addSubview:tableV3];
    tableV3.rowHeight=60;
    
    
    tableV4 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV4, self);
    tableV4.delegate=self;
    tableV4.dataSource=self;
    [self.view addSubview:tableV4];
    tableV4.rowHeight=60;
    youshi_str = nil;
    youshi_Id = nil;
    arr_names4 = @[@"个人信息",@"所属行业",@"个人优势",@"个人相册"];
    
    arr_model5 = [NSMutableArray arrayWithCapacity:0];
    page5= @"0";
    tableV5 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV5, self);
    tableV5.delegate=self;
    tableV5.dataSource=self;
    [self.view addSubview:tableV5];
    tableV5.rowHeight=60;
    tableV5.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData5)];
    tableV5.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData5)];
    
    tableV6 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV6, self);
    tableV6.delegate=self;
    tableV6.dataSource=self;
    [self.view addSubview:tableV6];
    tableV6.rowHeight=60;
    tableV6.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData6)];
    tableV6.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData6)];
    page6 =@"0";
    arr_model6 = [NSMutableArray arrayWithCapacity:0];

    tableV7 = [[UITableView alloc]initWithFrame:CGRectMake(100, DEVICE_TABBAR_Height, DEVICE_WIDTH-100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV7, self);
    tableV7.delegate=self;
    tableV7.dataSource=self;
    [self.view addSubview:tableV7];
    tableV7.rowHeight=60;
    [self tableviewHidden];
    arr_names7 = @[@"收藏的企业",@"收藏的产品",@"收藏的课程",@"收藏的创客"];
    
}

-(void)tableviewHidden
{
    tableV1.hidden = YES;
    tableV2.hidden = YES;
    tableV3.hidden = YES;
    tableV4.hidden = YES;
    tableV5.hidden = YES;
    tableV6.hidden = YES;
    tableV7.hidden = YES;
}
#pragma  mark - 增加日志
-(void)add_rizhiClick
{
      R_RichTextEditor_ViewController  *Rvc = [[R_RichTextEditor_ViewController alloc]init];
     Rvc.source =@"0";
     Rvc.articleName = @"创客空间";
     Rvc.menuid =@"0";
     [self.navigationController pushViewController:Rvc animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"创客空间";
    arr_names = @[@"需求推荐",@"个人日志",@"产品",@"个人档",@"留言",@"访客",@"收藏"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, 100, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    [self tableOtherinit];
    tableV1.hidden = NO;
    
  

}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV ==tableView) {
        return 60;
    }else if (tableView ==tableV5)
    {
        WS_liuYanModel *Model = arr_model5[indexPath.row];
        return Model.cell_height;
    }else if (tableV6 ==tableView)
    {
        SC_fangKeModel *model = arr_model6[indexPath.row];
        return model.cell_height;
    }else if (tableView ==tableV2)
    {
        EQDR_articleListModel  *model = arr_rizhi2[indexPath.row];
        return model.cellHeight;
    }else if (tableV1 ==tableView)
    {
        PXNeedModel  *model = arr_need[indexPath.row];
        return model.cellHeight >60? model.cellHeight:60;
    }
    else
    {
         return 60;
    }
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==tableV) {
         return arr_names.count;
    }else if (tableV4 == tableView)
    {
        return arr_names4.count;
    }else if (tableV5 ==tableView)
    {
        return arr_model5.count;
    }else if (tableView ==tableV6)
    {
        return arr_model6.count;
    }else if (tableV3 == tableView)
    {
        return arr_names3.count;
    }else if (tableV2 ==tableView)
    {
        return arr_rizhi2.count;
    }else if (tableV1 ==tableView)
    {
        return arr_need.count;
    }else if (tableV7 ==tableView)
    {
        return arr_names7.count;
    }
    else
    {
        return 0;
    }
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==tableV || tableV4 == tableView || tableView ==tableV3) {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        if (tableV4 ==tableView) {
            cell.textLabel.text = arr_names4[indexPath.row];
        }else if(tableView ==tableV)
        {
        cell.textLabel.text = arr_names[indexPath.row];
        }else if (tableView ==tableV3)
        {
            cell.textLabel.text =arr_names3[indexPath.row];
        }
        return cell;
    }else if (tableView ==tableV5)
    {
        static NSString *cellId=@"cellID5";
        WS_LiuYanTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[WS_LiuYanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        WS_liuYanModel *model = arr_model5[indexPath.row];
        [cell setModel_liuyan:model];
        FBindexTapGestureRecognizer  *tap_liuyan = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_liuyanClick:)];
        tap_liuyan.indexPath = indexPath;
        [cell.L_contets  addGestureRecognizer:tap_liuyan];
        
        return cell;
    }else if (tableView ==tableV6)
    {
        static NSString *cellId=@"cellID6";
        SC_fangKeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[SC_fangKeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        SC_fangKeModel *model =arr_model6[indexPath.row];
        [cell setModel_fangke:model];
        return cell;
    }else if (tableV2 ==tableView)
    {
        static NSString *cellId=@"cellID2";
        EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        EQDR_articleListModel *model =arr_rizhi2[indexPath.row];
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
    }else if (tableView ==tableV1)
    {
        static NSString *cellId=@"cellID1";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        PXNeedModel *model = arr_need[indexPath.row];
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.thetheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19 weight:3]}];
        NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"企业:%@\n培训地区：%@\n需求结束时间：%@",model.company,model.theplace,model.thedateEnd] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [name appendAttributedString:contents];
        
        name.yy_lineSpacing =6;
        CGSize  size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model.cellHeight =size.height+20;
        cell.YL_label.attributedText = name;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+15);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        return cell;
    }else if (tableView ==tableV7)
    {
        static NSString *cellId=@"cellID1";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell.textLabel.text = arr_names7[indexPath.row];
        return cell;
    }else if (tableView ==tableV1)
    {
        static NSString *cellId = @"cellid1";
        EQDR_labelTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
//        NSMutableAttributedString *name
        return cell;
    }
    
    else
    {
        return nil;
    }
   
}

#pragma  mark - 留言
-(void)getPresnetText:(NSString *)text
{
    WS_liuYanModel *model = arr_model5[indexpath5_selected.row];
    
    [WebRequest Makerspacey_MakerLeaveMsg_Add_MakerLeaveMsgWithuserGuid:user.Guid userCompanyId:user.companyId message:text parentId:model.Id makerGuid:model.creater parentUserGuid:model.creater firstCommentId:model.Id objectId:@"0" objectType:@"0" And:^(NSDictionary *dic) {
        MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"回复成功"];
            WS_liuYanModel *tmodel =   [WS_liuYanModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            NSMutableArray *tarr = [NSMutableArray arrayWithArray:model.childList];
            [tarr insertObject:tmodel atIndex:0];
            model.childList = tarr;
            [arr_model5 replaceObjectAtIndex:indexpath5_selected.row withObject:model];
            [tableV5 reloadData];
        }else
        {
            [alert showAlertWith:@"服务器错误，请重试！"];
        }
    }];
}

#pragma  mark -  对内容进行再留言
-(void)tap_liuyanClick:(FBindexTapGestureRecognizer*)tap
{
    WS_liuYanModel  *model = arr_model5[tap.indexPath.row];
    indexpath5_selected = tap.indexPath;
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"回复" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FB_OnlyForLiuYanViewController  *LYvc = [[FB_OnlyForLiuYanViewController alloc]init];
        LYvc.delegate =self;
        LYvc.providesPresentationContextTransitionStyle = YES;
        LYvc.definesPresentationContext = YES;
        LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        LYvc.btnName = @"留言";
        LYvc.placeHolder = @"说说您感兴趣的地方……";
        [self presentViewController:LYvc animated:NO completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
}

#pragma  mark - 表头的设计
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView ==tableV2 && section ==0) {
        return tbtn2;
    }else
    {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView ==tableV2 && section ==0) {
        return 40;
    }else
    {
        return 0;
    }
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==tableV) {
         [self tableviewHidden];
        
        switch (indexPath.row) {
            case 0:
            {
                //主页
                tableV1.hidden = NO;
            }
                break;
            case 1:
            {
                //个人日志
                tableV2.hidden = NO;
              if(arr_rizhi2.count ==0)
              {
                  [self loadRequestData2];
              }
                
            }
                break;
            case 2:
            {
                //产品
                tableV3.hidden = NO;
            }
                break;
            case 3:
            {
                //个人档
                tableV4.hidden = NO;
            }
                break;
            case 4:
            {
                //留言
                tableV5.hidden = NO;
                if (arr_model5.count ==0) {
                    [self loadRequestData5];
                }else
                {
                    
                }
            }
                break;
            case 5:
            {
                //访客
                tableV6.hidden = NO;
                if (arr_model6.count==0) {
                    [self loadRequestData6];
                }else
                {
                    
                }
            }
                break;
            case 6:
            {
                //收藏
                tableV7.hidden = NO;
            }
                break;
            default:
                break;
        }
      
    }else if (tableView == tableV1)
    {
       //主页
        PXNeedModel *model = arr_need[indexPath.row];
        PXNeedDetailViewController *Dvc = [[PXNeedDetailViewController alloc]init];
        Dvc.Id = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
        
    }else if (tableV2 == tableView)
    {
        //日志
        EQDR_articleListModel  *model =arr_rizhi2[indexPath.row];
        EQDR_Article_DetailViewController  *Dvc =[[EQDR_Article_DetailViewController alloc]init];
        Dvc.articleId =model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
        
    }else if (tableV3 ==tableView)
    {
        //产品
        if(indexPath.row ==0)
        {
          //讲师课程
            CK_courseViewController  *Cvc = [[CK_courseViewController alloc]init];
            Cvc.userGuid = user.Guid;
            Cvc.username = user.username;
            [self.navigationController pushViewController:Cvc animated:NO];
        }else if (indexPath.row ==1)
        {
            ///活动
            CK_huoDongListViewController  *HDvc = [[CK_huoDongListViewController alloc]init];
            [self.navigationController pushViewController:HDvc animated:NO];
        }
        else
        {
            
        }
        
    }else if (tableV4 ==tableView)
    {
        //个人档
        if(indexPath.row ==0 )
        {
            //个人信息
            CK_personInfoViewController  *PPvc = [[CK_personInfoViewController alloc]init];
            PPvc.userGuid = user.Guid;
            [self.navigationController pushViewController:PPvc animated:NO];
            
        }else if (indexPath.row ==1)
        {
            //所属行业
            CK_hangyeViewController *Hvc = [[CK_hangyeViewController alloc]init];
            Hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Hvc animated:NO];
        }else if (indexPath.row ==2)
        {
            //个人优势
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.indexpath =indexPath;
            TVvc.delegate =self;
            TVvc.S_maxnum = @"2000";
            TVvc.contentTitle=@"个人优势";
            TVvc.content =youshi_str;
            [self.navigationController pushViewController:TVvc animated:NO];
            
        }else if (indexPath.row ==3)
        {
            //个人相册
            CK_picturesPersonViewController  *PPvc = [[CK_picturesPersonViewController alloc]init];
            PPvc.userGuid = user.Guid;
            PPvc.userName =user.username;
            [self.navigationController pushViewController:PPvc animated:NO];
        }else
        {
            
        }
    }else if (tableV5 == tableView)
    {
        //留言
    }else if (tableV6 ==tableView)
    {
        //访客
    }else if (tableView == tableV7)
    {
        //收藏
        if (indexPath.row ==0) {
         //收藏的企业
            SC_ComShoucangViewController *SCvc = [[SC_ComShoucangViewController alloc]init];
            SCvc.temp =1;
            SCvc.userGuid = user.Guid;
            [self.navigationController pushViewController:SCvc animated:NO];
            
        }else if (indexPath.row ==1)
        {
           //收藏的产品
            CK_ShoucangProductViewController  *SPvc = [[CK_ShoucangProductViewController alloc]init];
            SPvc.userGuid = user.Guid;
            [self.navigationController pushViewController:SPvc animated:NO];
        }else if (indexPath.row ==2)
        {
            //收藏的课程
            CK_CourseShoucangViewController  *CSvc = [[CK_CourseShoucangViewController alloc]init];
            CSvc.userGuid = user.Guid;
            [self.navigationController pushViewController:CSvc animated:NO];
        }else if (indexPath.row ==3)
        {
            ///收藏的创客
            CK_chuangkeShoucangViewController  *CSvc = [[CK_chuangkeShoucangViewController alloc]init];
            CSvc.userGuid = user.Guid;
            [self.navigationController pushViewController:CSvc animated:NO];
        }
        else
        {
            
        }
        
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==tableV5) {
        return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleNone;
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WS_liuYanModel  *model = arr_model5[indexPath.row];
        [WebRequest Makerspacey_MakerLeaveMsg_Delete_MakerLeaveMsgWithmsgId:model.Id type:@"0" userGuid:user.Guid And:^(NSDictionary *dic) {
            MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"删除成功"];
                [arr_model5 removeObject:model];
                [tableV5 reloadData];
            }else
            {
                [alert showAlertWith:@"服务器错误，请重试！"];
            }
        }];
        
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}





@end
