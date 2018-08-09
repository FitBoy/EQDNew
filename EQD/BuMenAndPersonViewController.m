//
//  BuMenAndPersonViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "BuMenAndPersonViewController.h"
#import "FBTwo_img11TableViewCell.h"
@interface BuMenAndPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
}

@end

@implementation BuMenAndPersonViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_GetUserByDepartWithdepartId:user.departId companyId:user.companyId And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                Com_UserModel  *model = [Com_UserModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"请先选择一名员工";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
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
    FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    Com_UserModel  *model = arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Com_UserModel *model = arr_model[indexPath.row];
    if ([self.delegate_person respondsToSelector:@selector(getComModel:)]) {
        [self.delegate_person  getComModel:model];
    }
}



@end
