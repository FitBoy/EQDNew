//
//  BB_PeopleViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "BB_PeopleViewController.h"
#import "FBTwo_img11TableViewCell.h"
#import "BanBiePreopleModel.h"
#import "FBMutableChoose_TongShiViewController.h"
@interface BB_PeopleViewController ()<UITableViewDelegate,UITableViewDataSource,FBMutableChoose_TongShiViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user ;
}

@end

@implementation BB_PeopleViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest  Get_Rule_UserWithruleShiftId:self.ruleId And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if (tarr.count) {
            for (int i=0; i<tarr.count; i++) {
                BanBiePreopleModel *model =[BanBiePreopleModel mj_objectWithKeyValues:tarr[i]];
                model.ischoose=YES;
                [arr_model addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"班别人员";
    arr_model =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"修改人员" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
   
}
-(void)quedingClick
{
    NSMutableArray *tarr=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_model.count; i++) {
        BanBiePreopleModel *model =arr_model[i];
        [tarr addObject:model.userGuid];
    }
    FBMutableChoose_TongShiViewController *TSvc =[[FBMutableChoose_TongShiViewController alloc]init];
    TSvc.delegate =self;
    TSvc.indePath =[NSIndexPath indexPathForRow:0 inSection:0];
    TSvc.arr_Guid =tarr;
    [self.navigationController pushViewController:TSvc animated:NO];
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
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    BanBiePreopleModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   BanBiePreopleModel *model =arr_model[indexPath.row];
    model.ischoose =!model.ischoose;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma  mark - 自定义的协议代理
-(void)mutableChooseArr:(NSArray *)chooses tarr:(NSArray *)tarr indexPath:(NSIndexPath *)indexPath
{
    NSMutableString *tstr =[NSMutableString string];
    for (int i=0; i<chooses.count; i++) {
        Com_UserModel *model2 =chooses[i];
        [tstr appendFormat:@"%@;",model2.userGuid];
    }
    for (int i=0; i<tarr.count; i++) {
        [tstr appendFormat:@"%@;",tarr[i]];
    }
    [WebRequest Update_RuleShift_UserWithuserGuid:user.Guid companyId:user.companyId ruleShiftId:self.ruleId objecter:tstr And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [self loadRequestData];
        }
    }];
}



@end
