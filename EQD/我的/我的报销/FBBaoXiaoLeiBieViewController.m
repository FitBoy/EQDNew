//
//  FBBaoXiaoLeiBieViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaoXiaoLeiBieViewController.h"
@interface FBBaoXiaoLeiBieViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
}

@end

@implementation FBBaoXiaoLeiBieViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
    [WebRequest Option_AreasAndWithtype:48 And:^(NSArray *arr) {
        [hud hideAnimated:NO];
        [arr_model removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            OptionModel *model = [OptionModel mj_objectWithKeyValues:arr[i]];
            [arr_model addObject:model];
        }
        [tableV reloadData];
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报销科目";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=40;
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    OptionModel *model =arr_model[indexPath.row];
    cell.textLabel.text =model.name;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionModel *model =arr_model[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(getBaoXiaoLeiBieModel:indexPath:)]) {
        [self.delegate getBaoXiaoLeiBieModel:model indexPath:self.indexPath];
    }
    [self.navigationController popViewControllerAnimated:NO];
}




@end
