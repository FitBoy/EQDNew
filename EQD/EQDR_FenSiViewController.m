//
//  EQDR_FenSiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_FenSiViewController.h"
#import "FBOneImg_LabelButtonTableViewCell.h"
#import "PPersonCardViewController.h"
@interface EQDR_FenSiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation EQDR_FenSiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest  Articles_Get_Article_MyFansWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSDictionary *tdic =dic[Y_ITEMS];
            NSArray *tarr =tdic[@"rows"];
            for (int i=0; i<tarr.count; i++) {
                EQDR_MyAttentionModel  *model =[EQDR_MyAttentionModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =@"我的粉丝";
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
    [cell setModel2:model];
    cell.B_btn.indexpath =indexPath;
    [cell.B_btn addTarget:self action:@selector(btnCLIck:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)btnCLIck:(FBButton*)btn
{
    EQDR_MyAttentionModel *model = arr_model[btn.indexpath.row];
    if ([model.isAttention integerValue]==1) {
        //取消关注
        [WebRequest Articles_Cancle_ArticleAttentionWithuserGuid:user.Guid author:model.attention And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model.isAttention=@"0";
                [tableV reloadRowsAtIndexPaths:@[btn.indexpath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }else
    {
        //关注
        [WebRequest Articles_Add_Article_AttentionWithuserGuid:user.Guid attention:model.attention And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model.isAttention =@"1";
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
