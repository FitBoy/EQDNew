//
//  WorkSpace_detailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 

#import "WorkSpace_detailViewController.h"
#import "FBHeadScrollTitleView.h"
#import "EQDR_ArticleTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "EQDR_Article_DetailViewController.h"
#import "EQDR_ArticleClassSearchViewController.h"
#import "FBindexTapGestureRecognizer.h"
#import "EQDR_LiuYanViewController.h"
#import "WS_comDetailViewController.h"
@interface WorkSpace_detailViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    NSMutableArray *arr_table;
    UserModel *user;
    NSString *page;
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSArray *arr_choose;
    UITableView *tableV2;
}

@end

@implementation WorkSpace_detailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)loadRequestData{
    
    if(self.temp ==1 )
    {
    
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
    }else
    {
    
    [WebRequest Articles_Get_ArticleByCompanyWithpage:@"0" And:^(NSDictionary *dic) {
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
}
-(void)loadOtherData{
    
    if (self.temp ==1) {
        [WebRequest ComSpace_Admin_ComSpaceDaily_Get_ComSpaceDailyWithcompanyId:self.comId page:page And:^(NSDictionary *dic) {
            [tableV.mj_header endRefreshing];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                page = tdic[@"page"];
                
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    for (int i=0; i<tarr.count; i++) {
                        EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }
        }];
    }else
    {
    
    
    [WebRequest Articles_Get_ArticleByCompanyWithpage:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            page = tdic[@"page"];
           
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel  *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"企业空间";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
  [self loadRequestData];
    
  
    ///选择框
    
    
    
    [WebRequest Admin_ComSpaceModularPower_Power_Get_UserModularPowerWithuserGuid:user.Guid companyId:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            arr_choose = dic[Y_ITEMS];
            
        }
    }];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"EQD_more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    
}
-(void)moreClick
{
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDR_articleListModel  *model  = arr_model[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(void)tap_headClick:(FBindexTapGestureRecognizer*)tap{
    EQDR_articleListModel  *model = arr_model[tap.indexPath.row];
    WS_comDetailViewController  *Dvc = [[WS_comDetailViewController alloc]init];
    Dvc.comId= model.companyId;
    [self.navigationController pushViewController:Dvc animated:NO];
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    EQDR_articleListModel  *model = arr_model[indexPath.row];
    [cell.IV_head sd_setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    
    FBindexTapGestureRecognizer  *tap_head = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_headClick:)];
    tap_head.indexPath = indexPath;
    [cell.IV_head addGestureRecognizer:tap_head];
    
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
    FBindexTapGestureRecognizer  *tap_liuyan = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(liuyanClick:)];
    tap_liuyan.indexPath =indexPath;
    [cell.V_bottomThree.IV_liuyan addGestureRecognizer:tap_liuyan];
    
    FBindexTapGestureRecognizer  *tap_liuyan2 = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(liuyanClick:)];
    tap_liuyan2.indexPath = indexPath;
    [cell.V_bottomThree.L_liuyan addGestureRecognizer:tap_liuyan2];
    
    
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
}

-(void)liuyanClick:(FBindexTapGestureRecognizer*)tap
{
    EQDR_articleListModel *model = arr_model[tap.indexPath.row];
    EQDR_LiuYanViewController  *Lvc =[[EQDR_LiuYanViewController alloc]init];
    Lvc.articleId =model.Id;
    Lvc.commentCount = model.commentCount;
    Lvc.temp = 0;
    [self.navigationController pushViewController:Lvc animated:NO];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDR_articleListModel  *model =arr_model[indexPath.row];
    EQDR_Article_DetailViewController  *Dvc =[[EQDR_Article_DetailViewController alloc]init];
    Dvc.articleId =model.Id;
    Dvc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
