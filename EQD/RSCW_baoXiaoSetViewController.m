//
//  RSCW_baoXiaoSetViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RSCW_baoXiaoSetViewController.h"
#import "RSCW_baoXiaoAddViewController.h"
#import "RSCW_baoXiaoModel.h"
#import "FBTwo_noImg11TableViewCell.h"
@interface RSCW_baoXiaoSetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UserModel *user;
    UITableView *tableV;
    NSMutableArray *arr_model;
    BOOL  isNew;
}

@end

@implementation RSCW_baoXiaoSetViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest SetUp_Reimburse_Get_ReimburseCheckerWithcompanyId:user.companyId userGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            isNew = tarr.count;
            NSString *tstr = isNew ==NO? @"设置":@"重新设置";
            UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:tstr style:UIBarButtonItemStylePlain target:self action:@selector(shezhiClick)];
            [self.navigationItem setRightBarButtonItem:right];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                RSCW_baoXiaoModel *model = [RSCW_baoXiaoModel mj_objectWithKeyValues:tarr[i]];
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
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"报销的设置";
  
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
  

    
}
-(void)shezhiClick
{
    RSCW_baoXiaoAddViewController *Avc = [[RSCW_baoXiaoAddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noImg11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noImg11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    RSCW_baoXiaoModel *model = arr_model[indexPath.row];
    cell.L_left0.text = [NSString stringWithFormat:@"报销金额范围（元）：%@ ~ %@",model.minMoney,model.maxMoney];
    cell.L_left1.text = [NSString stringWithFormat:@"最终报销审核人:%@ - %@",model.postName,model.checkName];

    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
