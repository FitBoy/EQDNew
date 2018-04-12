//
//  Trumpt_ListViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Trumpt_ListViewController.h"
#import "TrumModel.h"
#import "FBFour_noimgTableViewCell.h"
#import "FBTextVViewController.h"
@interface Trumpt_ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UserModel *user;
    UITableView *tableV;
    NSMutableArray *arr_model;
}

@end

@implementation Trumpt_ListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest trumpet_Get_AlltrumpetWithuserGuid:user.Guid comid:user.companyId And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            TrumModel *model =[TrumModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        [tableV reloadData];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"发布的小喇叭";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    TrumModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrumModel *model =arr_model[indexPath.row];
    FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
    TVvc.content =model.content;
    TVvc.contentTitle =@"小喇叭的详细内容";
    [self.navigationController pushViewController:TVvc animated:NO];
    
}




@end
