//
//  Bumen_MutableViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Bumen_MutableViewController.h"
#import "ZuZhiModel.h"
#import "ZUZhi_ExpandTableViewCell.h"
@interface Bumen_MutableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arr_model;
    UserModel *user;
    UITableView *tableV;
}

@end

@implementation Bumen_MutableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest  Com_SelectDepartmentWithCompanyId:user.companyId ParentId:@"0" And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            ZuZhiModel *model =[ZuZhiModel mj_objectWithKeyValues:tarr[i]];
            model.flag=0;
            model.isShow=YES;
            [self setupModel:model];
        }
        
        [tableV reloadData];
    }];
    
}
-(void)setupModel:(ZuZhiModel*)model
{
    for (int i=0; i<self.arr_bumen.count; i++) {
        FBPeople  *peo =self.arr_bumen[i];
        if ([model.departId integerValue]==[peo.departId integerValue]) {
            model.isShow = NO;
            break;
        }else
        {
            model.isShow=YES;
        }
    }
    [arr_model addObject:model];
    if (model.childs.count) {
        for (int j=0; j<model.childs.count; j++) {
            ZuZhiModel *model1 =model.childs[j];
            model1.flag =model.flag+1;
            [self setupModel:model1];
        }
    }else
    {
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"部门";
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
   
}
-(void)quedingClick
{
    NSMutableArray  *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_model.count; i++) {
        ZuZhiModel *model =arr_model[i];
        if (model.isChoose==YES) {
            [tarr addObject:model];
        }else
        {
        }
    }
    if ([self.delegate respondsToSelector:@selector(bumenArr:)]) {
        [self.delegate bumenArr:tarr];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        static NSString *cellId=@"cellID";
        ZUZhi_ExpandTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[ZUZhi_ExpandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        ZuZhiModel *model =arr_model[indexPath.row];
        [cell setModel:model];
    if (model.isShow==NO) {
        cell.userInteractionEnabled=NO;
        cell.IV_choose.hidden=YES;
    }else
    {
        cell.userInteractionEnabled=YES;
        cell.IV_choose.hidden=NO;
        if (model.isChoose==0) {
            cell.IV_choose.image = [UIImage imageNamed:@"shequ_tluntan"];
        }else
        {
            cell.IV_choose.image = [UIImage imageNamed:@"shequ_landui"];
        }
    }
   
        return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZuZhiModel *model =arr_model[indexPath.row];
    model.isChoose =(model.isChoose+1)%2;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
