//
//  EQDR_LoveViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define height_img  ([UIScreen mainScreen].bounds.size.width-40)/3.0

#import "EQDR_LoveViewController.h"
#import "EQDR_articleListModel.h"
#import "EQDR_ArticleTableViewCell.h"
#import "EQDR_Article_DetailViewController.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@interface EQDR_LoveViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
}

@end

@implementation EQDR_LoveViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Articles_Get_Article_ByZanWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            page =tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
-(void)loadOtherData{
    [WebRequest Articles_Get_Article_ByZanWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page =tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleListModel *model =[EQDR_articleListModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"喜欢的文章";
    user = [WebRequest GetUserInfo];
    page =@"0";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDR_articleListModel  *model =arr_model[indexPath.row];
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
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    EQDR_articleListModel  *model =arr_model[indexPath.row];
    [cell setModel:model];
    float height_cell = 50;
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
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   EQDR_articleListModel  *model =arr_model[indexPath.row];
    EQDR_Article_DetailViewController *Dvc = [[EQDR_Article_DetailViewController alloc]init];
    Dvc.articleId = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
