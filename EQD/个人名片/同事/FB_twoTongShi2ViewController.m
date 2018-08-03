//
//  FB_twoTongShi2ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_twoTongShi2ViewController.h"
#import "TongShiModel.h"
#import "ZUZhi_ExpandTableViewCell.h"
#import "FBTwo_img11TableViewCell.h"
#import "PPersonCardViewController.h"
#import "FBTwo_tongShiSearchViewController.h"
@interface FB_twoTongShi2ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView  *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
}

@end

@implementation FB_twoTongShi2ViewController
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
    UIBarButtonItem *right1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"eqd_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    [self.navigationItem setRightBarButtonItem:right1];
    
}

-(void)searchClick{
    // 搜索
    FBTwo_tongShiSearchViewController  *SSvc = [[FBTwo_tongShiSearchViewController alloc]init];
    [self.navigationController pushViewController:SSvc animated:NO];
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
        if ([cell isKindOfClass:[FBTwo_img11TableViewCell class]]) {
            
        }else{
      
            cell = [[FBTwo_img11TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        FBTwo_img11TableViewCell *cell1 = (FBTwo_img11TableViewCell*)cell;
        [cell1 setModel:model];
        return cell1;
    }else if ([model isKindOfClass:[TongShiModel class]])
    {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
       
        if (![cell isKindOfClass:[ZUZhi_ExpandTableViewCell class]]) {
            cell = [[ZUZhi_ExpandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        ZUZhi_ExpandTableViewCell *cell2 = (ZUZhi_ExpandTableViewCell*)cell;
        [cell2 setModel_tongshi:model];
        return cell2;
    }else
    {
        return nil;
    }
    
  
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model =arr_model[indexPath.row];
    if ([model isKindOfClass:[Com_UserModel class]]) {
        Com_UserModel *model2 = (Com_UserModel*)model;
        if ([self.delegate_tongshiDan respondsToSelector:@selector(getComUserModel:indexpath:)]) {
              [self.navigationController popViewControllerAnimated:NO];
            [self.delegate_tongshiDan getComUserModel:model2 indexpath:self.indexPath];
          
        }else
        {
            PPersonCardViewController *Pvc =[[PPersonCardViewController alloc]init];
            Pvc.userGuid = model2.userGuid;
            [self.navigationController pushViewController:Pvc animated:NO];
        }
        
    }else if ([model isKindOfClass:[TongShiModel class]])
    {
        TongShiModel  *model2 = (TongShiModel*)model;
        model2.isZheDie = !model2.isZheDie;
        [self addDataWithModel:model2];
        [tableV reloadData];
    }else
    {
        
    }
}




@end
