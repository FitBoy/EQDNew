//
//  LookPersonViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/1.
//  Copyright © 2018 FitBoy. All rights reserved.
//
/*
 {
 "phone": "15286837836",
 "userGuid": "4f47e8c7e40541d4a2f03c3c72304252",
 "creatTime": "2018-10-31 09:31:47",
 "iphoto": "http://47.94.173.253:8008/image/20180420/15286837836/20180420035517headimage.png",
 "upname": "梁新帅",
 "authen": 1
 }
 */
#import "LookPersonViewController.h"
#import "FBOne_img1TableViewCell.h"
#import <UIButton+WebCache.h>
#import "PPersonCardViewController.h"
@interface LookPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
}
@end

@implementation LookPersonViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if (self.temp ==0) {
        //已邀请的人
        [WebRequest BP_bind_tele_getUserWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
            [tableV.mj_footer endRefreshing];
            [tableV.mj_header endRefreshing];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeAllObjects];
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    NSDictionary *tdic = tarr[i];
                    [arr_model addObject:tdic];
                }
                page = dic[@"page"];
                [tableV reloadData];
            }
        }];
        
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)loadMoreData
{
    [WebRequest BP_bind_tele_getUserWithuserGuid:user.Guid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_footer endRefreshing];
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            
            if(tarr.count==0)
            {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *tdic = tarr[i];
                [arr_model addObject:tdic];
            }
            page = dic[@"page"];
            [tableV reloadData];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page = @"0";
    user = [WebRequest GetUserInfo];
    if (self.temp ==0) {
        self.navigationItem .title = @"已邀请的人";
    }else
    {
        self.navigationItem.title =@"暂无标题";
    }
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    arr_model = [NSMutableArray arrayWithCapacity:0];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOne_img1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOne_img1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    NSDictionary *tdic = arr_model[indexPath.row];
    [cell.B_img sd_setImageWithURL:[NSURL URLWithString:tdic[@"iphoto"]] forState:UIControlStateNormal];
    cell.L_name.text = tdic[@"upname"];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tdic =arr_model[indexPath.row];
    PPersonCardViewController *Pvc = [[PPersonCardViewController alloc]init];
    Pvc.userGuid = tdic[@"userGuid"];
    [self.navigationController pushViewController:Pvc animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
