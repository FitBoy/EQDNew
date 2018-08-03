//
//  FB_twoTongShiChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_twoTongShiChooseViewController.h"
#import "TongShiModel.h"
#import "ZUZhi_ExpandTableViewCell.h"
#import "FBTwoChoose_img11TableViewCell.h"
@interface FB_twoTongShiChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView  *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
}

@end

@implementation FB_twoTongShiChooseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)loadRequestData{
    
    [WebRequest Com_Get_Com_UserWithcompanyId:user.companyId ParentId:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                TongShiModel  *model = [TongShiModel mj_objectWithKeyValues:tarr[i]];
                model.isZheDie = YES;
                model.cengJi =0;
                model.isQuanXuan =NO;
                [self addDataWithModel:model];
                [arr_model addObject:model];
            }
            [tableV reloadData];
            
        }
    }];
}
-(void)addDataWithModel:(TongShiModel*)model_tongshi{
    if (model_tongshi.isZheDie == NO) {
        
        for (int i=0; i<model_tongshi.childs.count; i++) {
            TongShiModel *model = model_tongshi.childs[i];
            model.cengJi = model_tongshi.cengJi+1;
            model.isZheDie = YES;
            [arr_model insertObject:model atIndex:[arr_model indexOfObject:model_tongshi]+1];
            [self addDataWithModel:model];
        }
        for (int i=0; i<model_tongshi.UserInfo.count; i++) {
            Com_UserModel *model = model_tongshi.UserInfo[i];
            if ([self.arr_guid containsObject:model.userGuid]) {
                model.isSelected = YES;
            }
            [arr_model insertObject:model atIndex:[arr_model indexOfObject:model_tongshi]+1];
        }
        
        
        
    }else
    {
        for (int i=0; i<model_tongshi.UserInfo.count; i++) {
            Com_UserModel *model = model_tongshi.UserInfo[i];
            [arr_model removeObject:model];
        }
        
        for (int i=0; i<model_tongshi.childs.count; i++) {
            TongShiModel *model = model_tongshi.childs[i];
            model.cengJi = model_tongshi.cengJi+1;
            [arr_model removeObject:model];
            [self addDataWithModel:model];
        }
    }
    
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"同事";
    user = [WebRequest GetUserInfo];
    arr_model  =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    [self loadRequestData];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingClick{
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_model.count; i++) {
        id model = arr_model[i];
        if ([model isKindOfClass:[Com_UserModel class]]) {
            Com_UserModel *model2 = (Com_UserModel*)model;
            if (model2.isSelected ==YES) {
                [tarr addObject:model2];
            }
        }else
        {
            
        }
    }
    
    if([self.delegate_tongshi respondsToSelector:@selector(getChooseArr_model:indexpath:)])
    {
        [self.delegate_tongshi getChooseArr_model:tarr indexpath:self.indexPath];
        [self.navigationController popViewControllerAnimated:NO];
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id  model = arr_model[indexPath.row];
    if ([model isKindOfClass:[Com_UserModel class]]) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if ([cell isKindOfClass:[FBTwoChoose_img11TableViewCell class]]) {
            
        }else{
            
            cell = [[FBTwoChoose_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        FBTwoChoose_img11TableViewCell *cell1 = (FBTwoChoose_img11TableViewCell*)cell;
        [cell1 setModel:model];
        return cell1;
    }else if ([model isKindOfClass:[TongShiModel class]])
    {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (![cell isKindOfClass:[ZUZhi_ExpandTableViewCell class]]) {
            cell = [[ZUZhi_ExpandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        ZUZhi_ExpandTableViewCell *cell2 = (ZUZhi_ExpandTableViewCell*)cell;
        [cell2 setModel_tongshi:model];
        TongShiModel *tmodel = model;
       
        cell2.btn_all.hidden = tmodel.isZheDie;
        cell2.btn_all.indexpath =indexPath;
        [cell2.btn_all addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *btnName = tmodel.isQuanXuan ==NO?@"全选":@"取消";
        [cell2.btn_all setTitle:btnName forState:UIControlStateNormal];
        return cell2;
    }else
    {
        return nil;
    }
    
    
}

-(void)btnClick:(FBButton*)btn
{
    TongShiModel  *model = arr_model[btn.indexpath.row];
    if (model.isQuanXuan == NO) {
        model.isQuanXuan =YES;
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        NSMutableArray *tarr = [NSMutableArray arrayWithArray:self.arr_guid];
        NSMutableArray *tarr2 = [NSMutableArray arrayWithArray:model.UserInfo];
        for (int i=0; i<model.UserInfo.count; i++) {
            Com_UserModel *tmodel = model.UserInfo[i];
            tmodel.isSelected = YES;
            [tarr addObject:tmodel.userGuid];
            [tarr2 replaceObjectAtIndex:i withObject:tmodel];
        }
        model.UserInfo = tarr2;
        self.arr_guid = tarr;
    }else
    {
        model.isQuanXuan =NO;
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        NSMutableArray *tarr = [NSMutableArray arrayWithArray:self.arr_guid];
        NSMutableArray *tarr2 = [NSMutableArray arrayWithArray:model.UserInfo];
        for (int i=0; i<model.UserInfo.count; i++) {
            Com_UserModel *tmodel = model.UserInfo[i];
            tmodel.isSelected = NO;
//            tmodel.ischoose = YES;
            [tarr removeObject: tmodel.userGuid];
            [tarr2 replaceObjectAtIndex:i withObject:tmodel];
        }
        model.UserInfo = tarr2;
        self.arr_guid = tarr;
    }
   
    [arr_model replaceObjectAtIndex:btn.indexpath.row withObject:model];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:btn.indexpath.section] withRowAnimation:UITableViewRowAnimationNone];

}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model =arr_model[indexPath.row];
    if ([model isKindOfClass:[Com_UserModel class]]) {
        Com_UserModel *model2 = (Com_UserModel*)model;
        model2.isSelected = !model2.isSelected;
        if (model2.isSelected == NO) {
            NSMutableArray *tarr = [NSMutableArray arrayWithArray:self.arr_guid];
            [tarr removeObject:model2.userGuid];
            self.arr_guid = tarr;
        }
        
    }else if ([model isKindOfClass:[TongShiModel class]])
    {
        TongShiModel  *model2 = (TongShiModel*)model;
        model2.isZheDie = !model2.isZheDie;
        [self addDataWithModel:model2];
       
    }else
    {
        
    }
     [tableV reloadData];
}

@end
