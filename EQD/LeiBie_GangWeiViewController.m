//
//  LeiBie_GangWeiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LeiBie_GangWeiViewController.h"
#import "FBOneChooseTableViewCell.h"
@interface LeiBie_GangWeiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
}

@end

@implementation LeiBie_GangWeiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest  Option_AreasAndWithtype:1 And:^(NSArray *arr) {
        if (arr.count) {
            [arr_model removeAllObjects];
            for (int i=0; i<arr.count; i++) {
                OptionModel *model =[OptionModel mj_objectWithKeyValues:arr[i]];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"岗位类别选择";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingCLick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingCLick
{
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_model.count; i++) {
        OptionModel  *model =arr_model[i];
        if (model.isChoose==YES) {
            [tarr addObject:model];
        }
       
    }
    
    if ([self.delegate respondsToSelector:@selector(leibieModel:indexPath:)]) {
        [self.delegate leibieModel:tarr indexPath:self.indexPath];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOneChooseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOneChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    OptionModel *model =arr_model[indexPath.row];
    cell.L_left0.text =model.name;
    cell.IV_choose.image = model.isChoose==NO?[UIImage imageNamed:@"shequ_tluntan"]:[UIImage imageNamed:@"shequ_landui"];
    
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionModel *model =arr_model[indexPath.row];
    model.isChoose =!model.isChoose;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}




@end
