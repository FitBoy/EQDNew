//
//  EQDR_articlesViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_articlesViewController.h"
#import "EQDR_articleModel.h"
#import "R_RichTextEditor_ViewController.h"
#import "EQDR_Article_DetailViewController.h"
@interface EQDR_articlesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView  *tableV;
    UserModel *user;
    NSMutableArray *arr_model;
}

@end

@implementation EQDR_articlesViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Articles_Get_Article_ByMenuWithuserGuid:user.Guid menuId:self.menuId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr =dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                EQDR_articleModel *model = [EQDR_articleModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
           
        }
        [tableV.mj_header endRefreshing];
        [tableV reloadData];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =self.articleName;
    user =[WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)tianjiaCLick
{
    R_RichTextEditor_ViewController  *Rvc =[[R_RichTextEditor_ViewController alloc]init];
    Rvc.source =@"0";
    
    Rvc.articleName = self.articleName;
    Rvc.menuid = self.menuId;
    [self.navigationController pushViewController:Rvc animated:NO];
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    EQDR_articleModel  *model =arr_model[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text =model.createrTime;
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EQDR_articleModel  *model = arr_model[indexPath.row];
    EQDR_Article_DetailViewController  *Dvc =[[EQDR_Article_DetailViewController alloc]init];
    Dvc.articleId = model.ID;
    [self.navigationController pushViewController:Dvc animated:NO];
}



@end
