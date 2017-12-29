//
//  EQDR_myAttentionViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_myAttentionViewController.h"
#import "FBOneImg_LabelButtonTableViewCell.h"
#import "PPersonCardViewController.h"
#import "EQDR_MyArticleTwoViewController.h"
@interface EQDR_myAttentionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation EQDR_myAttentionViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Articles_Get_Article_AttentionWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *tdic =dic[Y_ITEMS];
            NSArray *tarr =tdic[@"rows"];
            page =tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_MyAttentionModel *model =[EQDR_MyAttentionModel mj_objectWithKeyValues:tarr[i]];
                model.isguanzhu =@"1";
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    
}
-(void)loadOtherData
{
    [WebRequest Articles_Get_Article_AttentionWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic =dic[Y_ITEMS];
            NSArray *tarr =tdic[@"rows"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            page =tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_MyAttentionModel *model =[EQDR_MyAttentionModel mj_objectWithKeyValues:tarr[i]];
                model.isguanzhu =@"1";
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"我的关注";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOneImg_LabelButtonTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOneImg_LabelButtonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    EQDR_MyAttentionModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    cell.B_btn.indexpath =indexPath;
    [cell.B_btn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)cellBtnClick:(FBButton*)btn
{
    EQDR_MyAttentionModel *model = arr_model[btn.indexpath.row];
    if ([model.isguanzhu integerValue]==1) {
        //取消关注
        [WebRequest Articles_Cancle_ArticleAttentionWithuserGuid:user.Guid author:model.attention And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model.isguanzhu=@"0";
                [tableV reloadRowsAtIndexPaths:@[btn.indexpath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }else
    {
        //关注
        [WebRequest Articles_Add_Article_AttentionWithuserGuid:user.Guid attention:model.attention And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model.isguanzhu =@"1";
                [tableV reloadRowsAtIndexPaths:@[btn.indexpath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
        
    }
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDR_MyAttentionModel  *model =arr_model[indexPath.row];
    
    PPersonCardViewController  *Pvc = [[PPersonCardViewController alloc]init];
    Pvc.userGuid =model.attention;
    [self.navigationController pushViewController:Pvc animated:NO];
}




@end
