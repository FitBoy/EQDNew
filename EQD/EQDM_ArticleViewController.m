//
//  EQDM_ArticleViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDM_ArticleViewController.h"
#import "EQDM_Article_AddViewController.h"
#import "EQDM_ArticleModel.h"
#import "EQDR_ArticleTableViewCell.h"
#import <Masonry.h>
//#import "EQDM_ArticleDetailViewController.h"
#import "EQDR_Article_DetailViewController.h"
@interface EQDM_ArticleViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation EQDM_ArticleViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self settabbarViewShow];
}

-(void)loadRequestData{
    [WebRequest Makerspace_Get_MakerArticleListWithuserGuid:user.Guid ishomepage:@"1" categoryId:@"0" page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            page = dic[@"nextpage"];
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                EQDM_ArticleModel *model = [EQDM_ArticleModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData{
    [WebRequest Makerspace_Get_MakerArticleListWithuserGuid:user.Guid ishomepage:@"1" categoryId:@"0" page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page = dic[@"nextpage"];
            for (int i=0; i<tarr.count; i++) {
                EQDM_ArticleModel *model = [EQDM_ArticleModel mj_objectWithKeyValues:tarr[i]];
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
    arr_model = [NSMutableArray arrayWithCapacity:0];
    page =@"0";
    self.navigationItem.title = @"创文圈";
    UIBarButtonItem *Left =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClcik)];
    [self.navigationItem setLeftBarButtonItem:Left];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItems:@[right,right1]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    [tableV.mj_header beginRefreshing];
//     [self loadRequestData];
}
-(void)leftClcik
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma  mark - 添加创文
-(void)tianjiaCLick
{
    EQDM_Article_AddViewController *Avc = [[EQDM_Article_AddViewController alloc]init];
    [self settabbarViewHidden];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 搜索创文
-(void)searchClick
{
    
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDM_ArticleModel *model =arr_model[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    EQDM_ArticleModel *model =arr_model[indexPath.row];
    [cell setModel_M:model];
    NSMutableAttributedString  *source = [[NSMutableAttributedString alloc]initWithString:@"来源:  " attributes:@{}];
    NSArray *tarr = @[@"创客空间",@"企业空间",@"易企点平台"];
    NSMutableAttributedString  *source2 =[[NSMutableAttributedString alloc]initWithString:tarr[[model.source integerValue]] attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    [source2 yy_setTextBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:source2.yy_rangeOfAll];
    [source2 yy_setTextHighlightRange:source2.yy_rangeOfAll color:[UIColor orangeColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //来源的点击事件
    }];
    [source appendAttributedString:source2];
    cell.L_source.attributedText = source;
    NSArray *arr_leibie = [model.matchedTrade componentsSeparatedByString:@";"];
    NSMutableAttributedString *leibie = [[NSMutableAttributedString alloc]initWithString:@""];
    for (int i=0; i<arr_leibie.count; i++) {
        NSMutableAttributedString  *leibie2 =[[NSMutableAttributedString alloc]initWithString:arr_leibie[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}] ;
         [leibie2 yy_setTextBackgroundBorder:[YYTextBorder borderWithFillColor:[UIColor orangeColor] cornerRadius:6] range:leibie2.yy_rangeOfAll];
//        [leibie2 yy_setTextBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:leibie2.yy_rangeOfAll];
        [leibie2 yy_setTextHighlightRange:leibie2.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
           //创文分类的选中事件
        }];
       
        [leibie appendAttributedString:leibie2];
        NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
        [leibie appendAttributedString:kong];
    }
    CGSize size = [leibie boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, 50) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [cell.YL_hangye mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.height.mas_equalTo(size.height+5);
        make.bottom.mas_equalTo(cell.V_bottom.mas_top).mas_offset(-2);
    }];
    model.cellHeight = model.cellHeight+size.height+10;
    cell.YL_hangye.attributedText =leibie;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDM_ArticleModel *model =arr_model[indexPath.row];
    EQDR_Article_DetailViewController  *Dvc =[[EQDR_Article_DetailViewController alloc]init];
    Dvc.articleId = model.Id;
    Dvc.temp =EQDArticle_typeMade;
    [self settabbarViewHidden];
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
