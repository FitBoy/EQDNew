//
//  ProjectExprienceViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ProjectExprienceViewController.h"
#import "ProjectExproence_AddViewController.h"
#import "FBTwo_SwitchTableViewCell.h"

@interface ProjectExprienceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UserModel *user;
    UITableView *tableV;
    NSMutableArray *arr_model;
}

@end

@implementation ProjectExprienceViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest userashx_Get_projectExperienceWithuserGuid:user.Guid peuserGuid:user.Guid And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            [arr_model removeAllObjects];
            NSArray *tarr =dic[Y_ITEMS];
            for(int i=0;i<tarr.count;i++)
            {
                projectExprienceModel *model = [projectExprienceModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"项目经验列表";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_SwitchTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_SwitchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    projectExprienceModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    cell.S_kai.indexPath =indexPath;
    [cell.S_kai addTarget:self action:@selector(kaiCLick:) forControlEvents:UIControlEventValueChanged];
    return cell;
}
-(void)kaiCLick:(FBindexPathSwitch*)witch
{
    projectExprienceModel *model =arr_model[witch.indexPath.row];
    
    [WebRequest  userashx_Update_peovertWithuserGuid:user.Guid projectepid:model.ID isOvert:witch.on==NO?@"0":@"1" And:^(NSDictionary *dic) {
     
    }];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        UIAlertController  *alert =[[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    projectExprienceModel *model =arr_model[indexPath.row];
    ProjectExproence_AddViewController *Dvc =[[ProjectExproence_AddViewController alloc]init];
    Dvc.model =model;
    [self.navigationController pushViewController:Dvc animated:NO];
}

-(void)tianjiaClick
{
    //添加项目经验
    ProjectExproence_AddViewController *Avc =[[ProjectExproence_AddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}


@end
