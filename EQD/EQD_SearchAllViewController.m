//
//  EQD_SearchAllViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQD_SearchAllViewController.h"
#import "EQDS_teacherInfoModel.h"
#import "EQDS_TeacherTableViewCell.h"
#import "PX_courseManageModel.h"
#import "EQDR_labelTableViewCell.h"
#import "EQDS_VideoModel.h"
#import "EQDS_VideoTableViewCell.h"
#import "UISearchBar+ToolDone.h"
#import "EQDR_ArticleTableViewCell.h"
#import "EQDS_searchHighViewController.h"
#import "EQDS_ArticleDetailViewController.h"
#import <Masonry.h>
#import "PXNeedDetailViewController.h"
#import "EQDR_Article_DetailViewController.h"
@interface EQD_SearchAllViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,EQDS_TeacherTableViewCellDelegate,EQDR_labelTableViewCellDelegate,EQDS_VideoTableViewCellDelegate,EQDR_ArticleTableViewCellDelegate>
{
    UISearchBar *searchBar;
    NSInteger temp; // 0 ,1,2,3 "讲师",@"课程",@"需求",@"文章
    UILabel *tlabel ;
    UITableView *tableV;
    NSString *page;
    NSMutableArray *arr_model;
}

@end

@implementation EQD_SearchAllViewController
#pragma  mark - 点击文章的类别
-(void)getLabel:(NSString*)label model:(id)model
{
    EQDS_searchHighViewController *Hvc =[[EQDS_searchHighViewController alloc]init];
    Hvc.temp=3;
    Hvc.searchKey =label;
    [self.navigationController pushViewController:Hvc animated:NO];
}
#pragma  mark - 点击视频的类别
-(void)getlabel:(NSString*)label WithModel:(id)model
{
    EQDS_searchHighViewController *Hvc =[[EQDS_searchHighViewController alloc]init];
    Hvc.temp=2;
    Hvc.searchKey =label;
    [self.navigationController pushViewController:Hvc animated:NO];
}
#pragma  mark - 点击课程的类别
-(void)getTapTypeWithtype:(NSString*)type model:(id)model
{
    EQDS_searchHighViewController *Hvc =[[EQDS_searchHighViewController alloc]init];
    Hvc.temp=1;
    Hvc.searchKey =type;
    [self.navigationController pushViewController:Hvc animated:NO];
}
#pragma  mark - 点击视频类的类别
-(void)getlable:(NSString*)label Withmodel:(id)model
{
    EQDS_searchHighViewController *Hvc =[[EQDS_searchHighViewController alloc]init];
    Hvc.temp=0;
    Hvc.searchKey =label;
    [self.navigationController pushViewController:Hvc animated:NO];
}
-(void)loadOtherData{
    if(searchBar.text.length==0)
    {
        searchBar.text = @" ";
    }
    if(temp==0)
    {
        //讲师
        
        [WebRequest Lectures_Get_Lecture_BySearchWithpara:searchBar.text page:page type:@"app" ResearchField:@" " And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if(tarr.count==0)
                {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    page = tdic[@"page"];
                for(int i=0;i<tarr.count;i++)
                {
                    EQDS_teacherInfoModel *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (temp==1)
    {
        //课程
        [WebRequest Lectures_course_Get_LectureCourse_BySearchWithpara:searchBar.text page:page And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page =tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PX_courseManageModel *model = [PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
    }else if (temp==2)
    {
        
        [WebRequest Training_Trains_Get_TrainBySearchWithpage:page type:@" " minBudget:@"0" maxBudget:@"200000" para:searchBar.text And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                if (tarr.count ==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = dic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PXNeedModel *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                    [tableV reloadData];
                }
            }
        }];
        /*
        [WebRequest Lectures_Get_LectrueVideo_BySearchWithpara:searchBar.text page:page And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_VideoModel *model = [EQDS_VideoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                    
                }
                [tableV reloadData];
                }
            }
        }];*/
    }else if (temp ==3)
    {
        [WebRequest Articles_Get_Article_BySearchWithpara:searchBar.text page:page type:@"app" And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel *model = [EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];
        
        
        /*
        [WebRequest Lectures_article_Get_LectureArticle_BySearchWithpara:searchBar.text page:page type:@"app" And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic =dic[Y_ITEMS];
                NSArray *tarr= tdic[@"rows"];
                if (tarr.count==0) {
                    [tableV.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                page =tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel  *model =[EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
                }
            }
        }];*/
    }
    
    else
    {
        [tableV.mj_footer endRefreshing];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [searchBar endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    UIView   *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH-70, 40)];
    tview.userInteractionEnabled =YES;
   tlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.font = [UIFont systemFontOfSize:17];
    UITapGestureRecognizer *tapClcik = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [tlabel addGestureRecognizer:tapClcik];
    
    tlabel.userInteractionEnabled =YES;
    tlabel.text =@"讲师";
    tlabel.textColor =EQDCOLOR;
    [tview addSubview:tlabel];
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 20, 20)];
    imageV.userInteractionEnabled =YES;
    imageV.image = [UIImage imageNamed:@"eqd_arrow_right"];
    imageV.transform = CGAffineTransformMakeRotation(M_PI_2);
    UITapGestureRecognizer *tapClick2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [imageV addGestureRecognizer:tapClick2];
    [tview addSubview:imageV];
    
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(55, 0, DEVICE_WIDTH-120, 44)];
    searchBar.delegate=self;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.placeholder=@"搜索";
    [searchBar setTextFieldInputAccessoryView];
    [tview addSubview:searchBar];
    self.navigationItem.titleView = tview;

    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    temp =self.temp0;
     NSArray *tarr = @[@"讲师",@"讲师课程",@"培训需求",@"文章"];
    tlabel.text = tarr[temp];
    page =@"0";
    [self settableV];
}
-(void)settableV{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];

}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma  mark - 点击讲师的事件
-(void)tapClick
{
    UIAlertController *alert = [[UIAlertController alloc]init];
    NSArray *tarr = @[@"讲师",@"课程",@"需求",@"文章"];
    for (int i=0; i<tarr.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            temp = i;
            tlabel.text = tarr[i];
        }]];
        
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
    if(temp==0)
    {
        //讲师
        
        [WebRequest Lectures_Get_Lecture_BySearchWithpara:searchBar.text page:@"0" type:@"app" ResearchField:@" " And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeAllObjects];
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                page = tdic[@"page"];
                for(int i=0;i<tarr.count;i++)
                {
                    EQDS_teacherInfoModel *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (temp==1)
    {
        //课程
        [WebRequest Lectures_course_Get_LectureCourse_BySearchWithpara:searchBar.text page:@"0" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                [arr_model removeAllObjects];
                NSArray *tarr = tdic[@"rows"];
                page =tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PX_courseManageModel *model = [PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else if (temp==2)
    {
        [WebRequest Training_Trains_Get_TrainBySearchWithpage:@"0" type:@" " minBudget:@"0" maxBudget:@"200000" para:searchBar.text And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                page =dic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    PXNeedModel  *model = [PXNeedModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
        /*
        [WebRequest Lectures_Get_LectrueVideo_BySearchWithpara:searchBar.text page:@"0" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                page = tdic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_VideoModel *model = [EQDS_VideoModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                    
                }
                [tableV reloadData];
            }
        }];*/
    }else if (temp ==3)
    {
        
        [WebRequest Articles_Get_Article_BySearchWithpara:searchBar.text page:@"0" type:@"app" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            [tableV.mj_footer endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic = dic[Y_ITEMS];
                NSArray *tarr = tdic[@"rows"];
                page = tdic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel *model = [EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
        
        /*
        [WebRequest Lectures_article_Get_LectureArticle_BySearchWithpara:searchBar.text page:@"0" type:@"app" And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                NSDictionary *tdic =dic[Y_ITEMS];
                NSArray *tarr= tdic[@"rows"];
                page =tdic[@"page"];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    EQDS_articleModel  *model =[EQDS_articleModel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];*/
    }else
    {
        [hud hideAnimated:NO];
    }
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (temp==0) {
        return 120;
    }else if (temp==1)
    {
        PX_courseManageModel  *model = arr_model[indexPath.row];
        return model.cell_height;
    }else if (temp==2)
    {
        PXNeedModel  *model = arr_model[indexPath.row];
        return model.cellHeight;
    }else if (temp==3)
    {
        EQDS_articleModel *model =arr_model[indexPath.row];
        return model.cellHeight;
    }
    else
    {
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (temp==0) {
        static NSString *cellId=@"cellID0";
        EQDS_TeacherTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDS_TeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        EQDS_teacherInfoModel *model =arr_model[indexPath.row];
        cell.delegate =self;
        [cell setModel2:model];
        return cell;
    }else if (temp==1)
    {
        static NSString *cellId=@"cellID1";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        PX_courseManageModel *model =arr_model[indexPath.row];
        cell.delegate =self;
        [cell setModel_courseMin:model];
        return cell;
    }else if (temp==2)
    {
        ///培训需求
        static NSString *cellId=@"cellID2";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        PXNeedModel *model =arr_model[indexPath.row];
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.thetheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:3]}];
        NSMutableAttributedString *company = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  [%@]\n",model.company] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        [name appendAttributedString:company];
        
        NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"培训预算：%@元\n预计培训时间：%@ ~ %@\n培训地区：%@",model.budgetedExpense,model.thedateStart,model.thedateEnd,model.theplace] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [name appendAttributedString:contents];
        name.yy_lineSpacing =6;
        
        CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model.cellHeight = size.height+20;
        cell.YL_label.attributedText = name;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+15);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        return cell;
    }else if (temp==3)
    {
        static NSString *cellId=@"cellID3";
        EQDR_ArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        EQDS_articleModel *model =arr_model[indexPath.row];
        cell.delegate =self;
        [cell setModel_S:model];
        return cell;
    }
    else
    {
        return nil;
    }
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (temp==3) {
        //文章详情
        EQDS_articleModel *model =arr_model[indexPath.row];
        EQDR_Article_DetailViewController *Dvc = [[EQDR_Article_DetailViewController alloc]init];
        Dvc.articleId = model.Id;
        Dvc.temp = 0;
        [self.navigationController pushViewController:Dvc animated:NO];
    }else if (temp ==2)
    {
        //需求详情
        PXNeedModel  *model = arr_model[indexPath.row];
        PXNeedDetailViewController *Dvc = [[PXNeedDetailViewController alloc]init];
        Dvc.Id = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
    }
}



@end
