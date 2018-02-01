//
//  EQDS_SearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_SearchViewController.h"
#import "UISearchBar+ToolDone.h"
#import "FBImg_YYlabelTableViewCell.h"
#import "FBTwo_img11TableViewCell.h"
@interface EQDS_SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_models;
    NSString *searchKey;
    NSString *page;
}

@end

@implementation EQDS_SearchViewController
-(void)loadOtherData{
    [WebRequest Lectures_Get_Lecture_BySearchWithpara:searchKey page:page type:@"app" ResearchField:@" " And:^(NSDictionary *dic) {
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
                EQDS_teacherInfoModel *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                [arr_models addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_models = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+15, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-15) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 100, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索讲师";
    [searchBar setTextFieldInputAccessoryView];
    self.navigationItem.titleView = searchBar;
    searchKey =@" ";
    page = @"0";
}
#pragma  mark - 点击搜索按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchKey = searchBar.text;
    [WebRequest Lectures_Get_Lecture_BySearchWithpara:searchBar.text page:@"0" type:@"app" ResearchField:@"" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            page = tdic[@"page"];
            [arr_models removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                EQDS_teacherInfoModel *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                [arr_models addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDS_teacherInfoModel *model =arr_models[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_models.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBImg_YYlabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBImg_YYlabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
     
    }
    EQDS_teacherInfoModel *model =arr_models[indexPath.row];
    [cell setModel_teacherInfo:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDS_teacherInfoModel *model =arr_models[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(getTeacherInfo:)]) {
        [self.delegate getTeacherInfo:model];
    }
    [self.navigationController popViewControllerAnimated:NO];
}




@end
