//
//  LianLuoBook_OtherViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LianLuoBook_OtherViewController.h"
#import "LLBook_OtherDetailViewController.h"
@interface LianLuoBook_OtherViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSString *page;
}

@end

@implementation LianLuoBook_OtherViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    
    [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"230" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    [WebRequest LiaisonBooks_Get_LiaisonBook_ByObjecterWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSDictionary *dic2 =dic[Y_ITEMS];
        page =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
        for (int i=0; i<tarr.count; i++) {
            LianLuoBook_ListModel *model =[LianLuoBook_ListModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        [tableV reloadData];
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
    }];
}
-(void)loadOtherData
{
    [WebRequest LiaisonBooks_Get_LiaisonBook_ByObjecterWithuserGuid:user.Guid page:page And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            
        NSDictionary *dic2 =dic[Y_ITEMS];
        page =dic2[@"page"];
        NSArray *tarr =dic2[@"list"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
        for (int i=0; i<tarr.count; i++) {
            LianLuoBook_ListModel *model =[LianLuoBook_ListModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        [tableV reloadData];
            }
     
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"联络书列表";
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    page=@"0";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    LianLuoBook_ListModel *model =arr_model[indexPath.row];
    cell.textLabel.text =model.liasionBookTheme;
    cell.detailTextLabel.text=model.createTime;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LianLuoBook_ListModel *model =arr_model[indexPath.row];
    LLBook_OtherDetailViewController  *Dvc =[[LLBook_OtherDetailViewController alloc]init];
    Dvc.model =model;
    Dvc.isLianLuoBook =0;
    [self.navigationController pushViewController:Dvc animated:NO];
    
}




@end
