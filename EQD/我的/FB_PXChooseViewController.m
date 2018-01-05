//
//  FB_PXChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
// User_getcompostWithcomid   Com_SelectPostWithdepartId

#import "FB_PXChooseViewController.h"
#import "GangweiModel.h"
#import "FBTwoChoose_noimg_TableViewCell.h"
@interface FB_PXChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    NSMutableArray *arr_modelChoose;
}

@end

@implementation FB_PXChooseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    if (user.isAdmin >0) {
        [WebRequest User_getcompostWithcomid:user.companyId userGuid:user.Guid And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray  *tarr = dic[Y_ITEMS];
                for(int i=0;i<tarr.count;i++)
                {
                    GangweiModel  *model = [GangweiModel mj_objectWithKeyValues:tarr[i]];
                    for (int i=0; i<self.arr_choseModel.count; i++) {
                        GangweiModel  *model2 =self.arr_choseModel[i];
                        if ([model2.ID integerValue]==[model.ID integerValue]) {
                            model.isChoose = YES;
                            break;
                        }else
                        {
                            model.isChoose =NO;
                        }
                    }
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }else
    {
        [WebRequest Com_SelectPostWithdepartId:user.departId companyId:user.companyId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    GangweiModel  *model = [GangweiModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"培训对象";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    arr_modelChoose = [NSMutableArray arrayWithArray:self.arr_choseModel];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;

    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingClick
{
    if ([self.delegate respondsToSelector:@selector(getGangweiModel:)]) {
        [self.delegate getGangweiModel:arr_modelChoose];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwoChoose_noimg_TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwoChoose_noimg_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    GangweiModel  *model =arr_model[indexPath.row];
    cell.L_left0.text = model.name;
    cell.L_left1.text = [NSString stringWithFormat:@"属于:%@",model.dename==nil? user.department:model.dename];
    if (model.isChoose==NO) {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_tluntan"];
    }
    else
    {
        cell.IV_choose.image=[UIImage imageNamed:@"shequ_landui"];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GangweiModel  *model  =arr_model[indexPath.row];
    model.isChoose =!model.isChoose;
    if(model.isChoose==NO)
    {
        [arr_modelChoose removeObject:model];
    }else
    {
        [arr_modelChoose addObject:model];
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}




@end
