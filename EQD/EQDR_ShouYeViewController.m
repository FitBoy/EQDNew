//
//  EQDR_ShouYeViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define height_img  ([UIScreen mainScreen].bounds.size.width-40)/3.0

#import "EQDR_ShouYeViewController.h"
#import "EQDR_HeadView.h"
#import "R_RichTextEditor_ViewController.h"
#import "EQDR_articleListModel.h"
#import "EQDR_ArticleTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "EQDR_Article_DetailViewController.h"
#import "EQDR_ArticleSearchViewController.h"
#import "EQDR_ArticleClassSearchViewController.h"
@interface EQDR_ShouYeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    EQDR_HeadView  *Hv ;
    NSArray *arr_btn;
    NSInteger  select_Btn;
    UITableView *tableV0;
    UITableView *tableV1;
    UITableView *tableV2;
    UITableView *tableV3;
    UIScrollView *ScrollV;
    NSString *page0;
    NSString *page1;
    NSString *page2;
    NSString *page3;
    NSMutableArray *arr_model0;
    NSMutableArray *arr_model1;
    NSMutableArray *arr_model2;
    NSMutableArray *arr_model3;
    NSArray *arr_model_big;
    NSArray *arr_table_big;
}

@end

@implementation EQDR_ShouYeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)loadRequestData{
    [WebRequest Articles_Get_ArticleWithpage:@"0" And:^(NSDictionary *dic) {
       
        if ([dic[Y_STATUS] integerValue]==200) {
             [arr_model0 removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            page0 = tdic[@"page"];
            NSArray *tarr = tdic[@"rows"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model0 addObject:model];
                
            }
            [tableV0.mj_header endRefreshing];
            [tableV0.mj_footer endRefreshing];
            [tableV0 reloadData];
        }
    }];
}
-(void)loadRequestData1
{
    [WebRequest  Articles_Get_Article_ByBoutiqueWithpage:@"0" And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model1 removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
                 page1 = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model1 addObject:model];
                
            }
            [tableV1.mj_header endRefreshing];
            [tableV1.mj_footer endRefreshing];
            [tableV1 reloadData];
            
        }
    }];
}
-(void)loadRequestData2
{
    [WebRequest  Articles_Get_ArticleByCompanyWithpage:@"0" And:^(NSDictionary *dic) {
        [tableV2.mj_header endRefreshing];
        [tableV2.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model2 removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            page2 = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model2 addObject:model];
            }
            [tableV2 reloadData];
            
        }
    }];
}
-(void)loadRequestData3
{
    
}
-(void)loadOtherData0
{
    [WebRequest Articles_Get_ArticleWithpage:page0 And:^(NSDictionary *dic) {
        [tableV0.mj_header endRefreshing];
        [tableV0.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
           
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV0.mj_footer endRefreshingWithNoMoreData];
                [tableV0.mj_header endRefreshing];
            }else
            {
                 page0 = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model0 addObject:model];
            }
         
            [tableV0 reloadData];
            }
        }
    }];
}
-(void)loadOtherData1
{
    [WebRequest  Articles_Get_Article_ByBoutiqueWithpage:page1 And:^(NSDictionary *dic) {
        [tableV1.mj_header endRefreshing];
        [tableV1.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
           
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV1.mj_footer endRefreshingWithNoMoreData];
                [tableV1.mj_header endRefreshing];
            }else
            {
             page1 = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model1 addObject:model];
                
            }
           
            [tableV1 reloadData];
            }
        }
    }];
}
-(void)loadOtherData2
{
    [WebRequest  Articles_Get_ArticleByCompanyWithpage:page2 And:^(NSDictionary *dic) {
        [tableV2.mj_header endRefreshing];
        [tableV2.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV2.mj_footer endRefreshingWithNoMoreData];
                [tableV2.mj_header endRefreshing];
            }else
            {
                page2 = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model2 addObject:model];
                
            }
          
            [tableV2 reloadData];
            }
        }
    }];
}
-(void)loadOtherData3
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"易企阅";
    arr_model0 = [NSMutableArray arrayWithCapacity:0];
    arr_model1 = [NSMutableArray arrayWithCapacity:0];
    arr_model2 = [NSMutableArray arrayWithCapacity:0];
    arr_model3 = [NSMutableArray arrayWithCapacity:0];
    arr_model_big = @[arr_model0,arr_model1,arr_model2,arr_model3];
    page0=@"0";
    page1=@"1";
    page2=@"2";
    page3 =@"3";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItems:@[right,right1]];
    
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    [self.navigationItem setLeftBarButtonItem:left];
     Hv =[[EQDR_HeadView alloc]initWithFrame:CGRectMake((DEVICE_WIDTH-320)/2.0, DEVICE_TABBAR_Height, 320, 40)];
    [Hv setTitleArr:@[@"热门文章",@"精品推荐",@"企业文章",@"易文章"]];
    [self.view addSubview:Hv];
    [Hv.B_title0 addTarget:self action:@selector(title0Click:) forControlEvents:UIControlEventTouchUpInside];
    [Hv.B_title1 addTarget:self action:@selector(title0Click:) forControlEvents:UIControlEventTouchUpInside];
    [Hv.B_title2 addTarget:self action:@selector(title0Click:) forControlEvents:UIControlEventTouchUpInside];
    [Hv.B_title3 addTarget:self action:@selector(title0Click:) forControlEvents:UIControlEventTouchUpInside];
    [Hv addSubview:Hv.V_red];
    arr_btn = @[Hv.B_title0 ,Hv.B_title1 ,Hv.B_title2 ,Hv.B_title3 ];
    select_Btn =0;
    [self initScrollV];
}

-(void)initScrollV
{
    float scroll_height =CGRectGetMinY(self.tabBarController.tabBar.frame)-DEVICE_TABBAR_Height-40;
    ScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, scroll_height)];
    [self.view addSubview:ScrollV];
    ScrollV.showsHorizontalScrollIndicator =NO;
    adjustsScrollViewInsets_NO(ScrollV, self);
    ScrollV.delegate =self;
    ScrollV.pagingEnabled = YES;
    ScrollV.contentSize = CGSizeMake(DEVICE_WIDTH*4, scroll_height);
    
    tableV0 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, scroll_height) style:UITableViewStylePlain];
    tableV0.delegate=self;
    tableV0.dataSource=self;
    [ScrollV addSubview:tableV0];
//    tableV0.rowHeight=60;
    tableV0.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV0.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData0)];
    
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, scroll_height) style:UITableViewStylePlain];
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [ScrollV addSubview:tableV1];
//    tableV1.rowHeight=60;
    tableV1.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData1)];
    tableV1.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData1)];
    
    
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*2, 0, DEVICE_WIDTH, scroll_height) style:UITableViewStylePlain];
    tableV2.delegate=self;
    tableV2.dataSource=self;
    [ScrollV addSubview:tableV2];
//    tableV2.rowHeight=60;
    tableV2.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData2)];
tableV2.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData2)];
    
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*3, 0, DEVICE_WIDTH, scroll_height) style:UITableViewStylePlain];
    tableV3.delegate=self;
    tableV3.dataSource=self;
    [ScrollV addSubview:tableV3];
//    tableV3.rowHeight=60;
    tableV3.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData3)];
    tableV3.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData3)];
    
    [tableV0.mj_header beginRefreshing];
//    [tableV1.mj_header beginRefreshing];
//    [tableV2.mj_header beginRefreshing];
//    [tableV3.mj_header beginRefreshing];
    arr_table_big = @[tableV0,tableV1,tableV2,tableV3];
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==ScrollV) {
        float  offset_x = scrollView.contentOffset.x *80.0/DEVICE_WIDTH;
        
        Hv.V_red.frame = CGRectMake(offset_x+5, 38, 70, 2);
        NSInteger temp = scrollView.contentOffset.x/DEVICE_WIDTH;
        
        NSArray  *tarr = arr_model_big[temp];
        if (tarr.count==0) {
            UITableView  *ttable= arr_table_big[temp];
            [ttable.mj_header beginRefreshing];
        }
        [Hv setBtn:arr_btn[temp]];
    }else
    {
    }
}

-(void)title0Click:(FBButton*)tbtn
{
//    [Hv setBtn:tbtn];
    select_Btn = tbtn.tag-9000;
    [ScrollV setContentOffset:CGPointMake(DEVICE_WIDTH*select_Btn, 0) animated:YES];
}


-(void)leftClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)tianjiaCLick
{
   //填写文章
    R_RichTextEditor_ViewController *Rvc =[[R_RichTextEditor_ViewController alloc]init];
    Rvc.title =@"写文章";
    /// 0 是创客空间 1 是企业空间
    Rvc.source = @"0";
    Rvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Rvc animated:NO];
    
}
-(void)searchClick
{
    //搜索
    EQDR_ArticleSearchViewController *Svc=[[EQDR_ArticleSearchViewController alloc]init];
    Svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:Svc animated:NO];
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tarr = arr_model_big[select_Btn];
    EQDR_articleListModel *model =tarr[indexPath.row];
    return model.cellHeight;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tarr = arr_model_big[select_Btn];
    return tarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    NSArray *tarr = arr_model_big[select_Btn];
    EQDR_articleListModel *model =tarr[indexPath.row];
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
            [tlabelStr yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor greenColor]] range:tlabelStr.yy_rangeOfAll];
            [tlabelStr yy_setTextHighlightRange:[tlabelStr yy_rangeOfAll] color:[UIColor greenColor] backgroundColor:[UIColor greenColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                
                //标签的点击事件
                
                EQDR_ArticleClassSearchViewController  *Cvc =[[EQDR_ArticleClassSearchViewController alloc]init];
                Cvc.searchKey = text.string;
                Cvc.hidesBottomBarWhenPushed =YES;
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
    [source_two yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:(YYTextLineStyleSingle) lineWidth:1 strokeColor:[UIColor greenColor]] range:source_two.yy_rangeOfAll];
    [source_two yy_setTextHighlightRange:[source_two yy_rangeOfAll] color:[UIColor greenColor] backgroundColor:[UIColor grayColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        ///点击来源跳转到相应的页面
       
        
    }];
    [soure appendAttributedString:source_two];
    cell.L_source.attributedText =soure;
    cell.L_RPL.text = [NSString stringWithFormat:@"%@ 阅读 * %@ 评论 * %@ 喜欢",model.browseCount,model.commentCount,model.zanCount];
    
    height_cell= height_cell+35;
    model.cellHeight =height_cell;
    
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tarr = arr_model_big[indexPath.section];
    EQDR_articleListModel  *model =tarr[indexPath.row];
    EQDR_Article_DetailViewController  *Dvc =[[EQDR_Article_DetailViewController alloc]init];
    Dvc.articleId =model.Id;
    Dvc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
