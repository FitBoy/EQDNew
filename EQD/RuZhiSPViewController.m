//
//  RuZhiSPViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RuZhiSPViewController.h"
#import "SPDetailViewController.h"
#import "FBTwo_img11TableViewCell.h"
@interface RuZhiSPViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arr_ruzhi;
    UITableView *tableV;
    UserModel *user;
}

@end

@implementation RuZhiSPViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"151" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    [WebRequest User_GetBeInviterWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        NSArray *tarr= dic[Y_ITEMS];
        if (tarr.count) {
            [arr_ruzhi removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                RuZhiSPModel *model = [RuZhiSPModel mj_objectWithKeyValues:tarr[i]];
                [arr_ruzhi addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"入职审批";
    user =[WebRequest GetUserInfo];
    arr_ruzhi =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_ruzhi.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_img11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    RuZhiSPModel *model = arr_ruzhi[indexPath.row];
    [cell setModel:model];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RuZhiSPModel *model = arr_ruzhi[indexPath.row];
    SPDetailViewController *Dvc =[[SPDetailViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}




@end
