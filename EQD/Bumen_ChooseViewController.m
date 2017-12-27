//
//  Bumen_ChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Bumen_ChooseViewController.h"
@interface Bumen_ChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
}

@end

@implementation Bumen_ChooseViewController
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
            [self setupModel:model];
        }
        
        [tableV reloadData];
    }];
    
}
-(void)setupModel:(ZuZhiModel*)model
{
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
    self.navigationItem.title =@"全体-部门的选择";
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?1: arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        UITableViewCell *cell =[[UITableViewCell alloc]init];
        cell.textLabel.font =[UIFont systemFontOfSize:17];
        cell.textLabel.text =@"全体员工";
        return  cell;
    }else
    {
    static NSString *cellId=@"cellID";
    ZUZhi_ExpandTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ZUZhi_ExpandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    ZuZhiModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.delegate respondsToSelector:@selector(getBumenModel:indexPath:)]) {
        if (indexPath.section==0) {
            ZuZhiModel *model =[[ZuZhiModel alloc]init];
            model.departId=@"0";
            model.departName=@"全体员工";
            model.type=@"0";
            [self.delegate getBumenModel:model indexPath:self.indexPath];
        }else
        {
         ZuZhiModel *model =arr_model[indexPath.row];
            model.type=@"1";
        [self.delegate getBumenModel:model indexPath:self.indexPath];
        }
    }
    [self.navigationController popViewControllerAnimated:NO];
   
}



@end
