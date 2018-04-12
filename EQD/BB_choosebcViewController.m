//
//  BB_choosebcViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BB_choosebcViewController.h"
#import "FBTwoChoose_noimg_TableViewCell.h"
@interface BB_choosebcViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_banci;
    UserModel *user;
    BanCiModel *selected_model;
    
}

@end

@implementation BB_choosebcViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Get_Shift_ByCompanyWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            [arr_banci removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                BanCiModel *model =[BanCiModel mj_objectWithKeyValues:tarr[i]];
                [arr_banci addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"班次选择";
    user =[WebRequest GetUserInfo];
    arr_banci =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    
}
-(void)quedingCLick
{
    
    //确定
    if (selected_model) {
        if ([self.delegate respondsToSelector:@selector(banciModel:indexPath:)]) {
            [self.delegate banciModel:selected_model indexPath:self.indexPath];
        }
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_banci.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwoChoose_noimg_TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwoChoose_noimg_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BanCiModel *model =arr_banci[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BanCiModel *model =arr_banci[indexPath.row];
    model.ischoose =!model.ischoose;
    if (model.ischoose==NO) {
        selected_model=nil;
    }
    else
    {
        selected_model.ischoose=NO;
        selected_model=model;
    }
    [tableV reloadData];
}



@end
